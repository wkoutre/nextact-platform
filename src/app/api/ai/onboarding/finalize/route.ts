import { NextResponse } from "next/server";
import { generateObject } from "ai";
import { anthropic } from "@ai-sdk/anthropic";
import { z } from "zod";
import { createClient } from "@/lib/supabase/server";
import { createAdminClient } from "@/lib/supabase/admin";

export const runtime = "nodejs";
export const dynamic = "force-dynamic";

const profileSchema = z.object({
  character_name: z
    .string()
    .describe("The name the user gave their character"),
  valued_direction: z
    .string()
    .describe(
      "What is most important to the user — their goal or dream, in their own words. Keep it in Swedish, 1-2 sentences max."
    ),
  main_obstacle: z
    .string()
    .describe(
      "The main challenge that stops them — a situation, feeling, or thought pattern. In Swedish, 1-2 sentences max."
    ),
  current_behavior: z
    .string()
    .optional()
    .describe(
      "What they currently do when they hit the obstacle. In Swedish."
    ),
  context: z
    .enum(["sport", "school", "social", "music", "other", "general"])
    .describe("The primary area of life this relates to"),
  context_detail: z
    .string()
    .optional()
    .describe(
      "Specific detail e.g. 'fotboll', 'matte', 'kompisar'"
    ),
  profile_summary: z
    .string()
    .describe(
      "A warm 3-5 sentence summary in Swedish second person (du-form), using the user's own words"
    ),
});

export async function POST(request: Request) {
  const supabase = await createClient();
  const {
    data: { user },
    error: authError,
  } = await supabase.auth.getUser();

  if (authError || !user) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const body = await request.json();
  const messages: Array<{ role: "user" | "assistant"; content: string }> =
    body.messages;
  const characterName: string = body.characterName;

  if (!Array.isArray(messages) || messages.length === 0) {
    return NextResponse.json({ error: "Messages required" }, { status: 400 });
  }

  if (!characterName || typeof characterName !== "string") {
    return NextResponse.json(
      { error: "characterName required" },
      { status: 400 }
    );
  }

  const model = anthropic(process.env.AI_MODEL ?? "claude-haiku-4-5-20251001");

  const { object: extracted } = await generateObject({
    model,
    schema: profileSchema,
    system: `Du är ett system som extraherar strukturerad profildata från ett onboarding-samtal.
Basera din extraktion enbart på vad som faktiskt sagts i konversationen.
Karaktärens namn är: "${characterName}".
Svara alltid på svenska för textfält.`,
    messages,
  });

  const admin = createAdminClient();

  const { data, error } = await admin
    .from("character_profiles")
    .upsert(
      {
        user_id: user.id,
        character_name: extracted.character_name,
        valued_direction: extracted.valued_direction,
        main_obstacle: extracted.main_obstacle,
        current_behavior: extracted.current_behavior ?? null,
        context: extracted.context,
        context_detail: extracted.context_detail ?? null,
        profile_summary: extracted.profile_summary,
      },
      { onConflict: "user_id" }
    )
    .select()
    .single();

  if (error) {
    console.error("character_profiles upsert error:", error);
    return NextResponse.json(
      { error: "Failed to save profile" },
      { status: 500 }
    );
  }

  return NextResponse.json({ profile: data });
}
