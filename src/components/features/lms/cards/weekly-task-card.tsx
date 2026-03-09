"use client";

type WeeklyTaskCardProps = { tasks: string[]; moduleTitle?: string };

export function WeeklyTaskCard({ tasks, moduleTitle }: WeeklyTaskCardProps) {
  return (
    <div className="w-full bg-[#2E3347] px-6 py-8 sm:px-10 sm:py-10">
      <div className="mx-auto max-w-2xl">
        <h2 className="font-heading text-2xl font-bold text-white">
          Veckans träningsprogram
        </h2>
        {moduleTitle && (
          <p className="mt-1 text-sm text-white/60">{moduleTitle}</p>
        )}
        <p className="mt-4 text-sm leading-relaxed text-white/80">
          I början av varje modul kommer du få några uppgifter eller övningar som du ska göra under veckan som kommer. Kom ihåg att ju mer du övar, desto mer kommer du få ut av programmet.
        </p>
        <div className="mt-6 space-y-4">
          {tasks.map((task, i) => (
            <div key={i}>
              <h3 className="font-heading text-base font-semibold text-white">
                {i + 1}. {task}
              </h3>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}
