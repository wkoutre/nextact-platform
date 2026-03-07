import type { SupabaseClient } from "@supabase/supabase-js";

export type ModuleAccessStatus = "locked" | "active" | "completed";

export async function getModuleAccess(
  supabase: SupabaseClient,
  userId: string
): Promise<Map<string, ModuleAccessStatus>> {
  const { data: modules } = await supabase
    .from("modules")
    .select("id, order")
    .order("order", { ascending: true });

  const { data: progress } = await supabase
    .from("module_progress")
    .select("module_id, lessons_completed, lessons_total, completed_at")
    .eq("user_id", userId);

  const progressMap = new Map(
    (progress ?? []).map((p) => [p.module_id, p])
  );

  const result = new Map<string, ModuleAccessStatus>();
  let previousCompleted = true; // First module always unlocked

  for (const mod of modules ?? []) {
    const p = progressMap.get(mod.id);
    const isCompleted =
      !!p?.completed_at ||
      (p
        ? p.lessons_completed >= p.lessons_total && p.lessons_total > 0
        : false);

    if (isCompleted) {
      result.set(mod.id, "completed"); // Always accessible
    } else if (previousCompleted) {
      result.set(mod.id, "active"); // Unlocked
    } else {
      result.set(mod.id, "locked");
    }

    previousCompleted = isCompleted;
  }

  return result;
}
