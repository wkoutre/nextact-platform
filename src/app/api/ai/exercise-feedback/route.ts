import { NextResponse } from "next/server";
import { generateObject } from "ai";
import { createAnthropic } from "@ai-sdk/anthropic";
import { z } from "zod";
import { createClient } from "@/lib/supabase/server";

export const runtime = "nodejs";
export const dynamic = "force-dynamic";

type FeedbackContext = "valued_direction" | "obstacle" | "key_action";

const SYSTEM_PROMPTS: Record<FeedbackContext, string> = {
  valued_direction: `Du är en tränarcoach för unga idrottare (12–16 år) i psykologiprogrammet Next Act.

En spelare har precis skrivit sin värderade riktning – varför de idrottar, bortom yttre mål.

VIKTIGT: Var MYCKET generös. De flesta svar är tillräckligt bra. Ge "good" om svaret på något sätt handlar om inre drivkraft, känsla, gemenskap, glädje, att växa, att bidra, att känna sig levande – även om det inte är perfekt formulerat.

Ge bara "needs_revision" om svaret TYDLIGT är ett konkret yttre mål med noll inre dimension, som:
- "Vinna SM"
- "Bli proffs"
- "Komma med i landslaget"
- "Göra X antal mål"

Nästan allt annat ska få "good". Om du är det minsta osäker → "good".

Om "good": ge en kort varm bekräftelse (1 mening).
Om "needs_revision": ställ en nyfiken fråga som hjälper spelaren att hitta det inre varför bakom målet. Max 2 meningar. Var alltid varm, aldrig dömande. Använd du-form.`,

  obstacle: `Du är en tränarcoach för unga idrottare (12–16 år) i psykologiprogrammet Next Act.

En spelare har beskrivit sitt hinder – det som stoppar dem i sin idrott.

Ett äkta psykologiskt hinder är en inre upplevelse: tankar ("jag duger inte"), känslor (nervositet, rädsla), eller mönster (undvikande, prestationsångest).

Det är INTE ett äkta hinder om svaret är:
- Yttre omständigheter ("tränaren är dålig", "laget satsar inte")
- Väldigt vagt ("det är svårt", "jag har problem")

Om svaret beskriver ett genuint inre hinder → verdict: "good", ge en kort varm bekräftelse.
Om svaret är yttre eller alltför vagt → verdict: "needs_revision", ge ett snällt tips på hur man formulerar det mer konkret. Max 2 meningar. Var alltid varm. Använd du-form.`,

  key_action: `Du är en tränarcoach för unga idrottare (12–16 år) i psykologiprogrammet Next Act.

En spelare har skrivit sin nyckelåtgärd – en konkret handling de ska ta den kommande veckan.

En bra nyckelåtgärd är:
- Specifik och konkret (inte vag)
- Något spelaren faktiskt kan göra (inte ett resultat de hoppas på)
- Helst formulerat som "jag ska..." eller liknande

Det är INTE en bra nyckelåtgärd om det är:
- Ett resultat ("jag ska spela bättre", "vi ska vinna")
- Alltför vagt ("jag ska försöka")

Om svaret är en konkret handling → verdict: "good", ge en kort uppmuntrande bekräftelse.
Om svaret är för vagt eller ett resultat → verdict: "needs_revision", ge ett kort konkret tips. Max 2 meningar. Var alltid varm. Använd du-form.`,
};

const feedbackSchema = z.object({
  verdict: z.enum(["good", "needs_revision"]),
  feedback: z
    .string()
    .describe("Short, warm feedback in Swedish, max 2 sentences"),
});

export async function POST(request: Request) {
  const apiKey = process.env.ANTHROPIC_API_KEY;
  if (!apiKey) {
    return NextResponse.json({ error: "AI not configured" }, { status: 503 });
  }

  const supabase = await createClient();
  const {
    data: { user },
    error: authError,
  } = await supabase.auth.getUser();

  if (authError || !user) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  const body = await request.json();
  const { response, context } = body as {
    response: string;
    context: FeedbackContext;
  };

  if (!response || typeof response !== "string" || response.trim().length < 3) {
    return NextResponse.json({ error: "Response too short" }, { status: 400 });
  }

  if (!context || !(context in SYSTEM_PROMPTS)) {
    return NextResponse.json({ error: "Invalid context" }, { status: 400 });
  }

  const anthropicProvider = createAnthropic({ apiKey });
  // Use Haiku for speed and cost — this is a simple classification task
  const model = anthropicProvider("claude-haiku-4-5-20251001");

  try {
    const { object } = await generateObject({
      model,
      schema: feedbackSchema,
      system: SYSTEM_PROMPTS[context],
      prompt: `Spelarens svar: "${response.trim()}"`,
    });

    return NextResponse.json(object);
  } catch (err) {
    console.error("[exercise-feedback] generateObject error:", err);
    // On AI error, silently pass — don't block the player
    return NextResponse.json({ verdict: "good", feedback: "" });
  }
}
