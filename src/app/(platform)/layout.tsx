import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";
import { TopBar } from "@/components/layouts/top-bar";

export default async function PlatformLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    redirect("/logga-in");
  }

  const displayName =
    user.user_metadata?.display_name ?? user.email?.split("@")[0] ?? null;

  return (
    <div className="min-h-screen bg-[#E8EEF5]">
      <TopBar userName={displayName} />
      <main className="pt-14">
        <div className="mx-auto max-w-4xl px-4 py-6 sm:px-6">
          {children}
        </div>
      </main>
    </div>
  );
}
