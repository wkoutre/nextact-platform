-- character_profiles: personalized character data for Next Act Ung
CREATE TABLE public.character_profiles (
  id                UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id           UUID        NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  character_name    TEXT        NOT NULL,
  valued_direction  TEXT        NOT NULL,
  main_obstacle     TEXT        NOT NULL,
  current_behavior  TEXT,
  context           TEXT        NOT NULL DEFAULT 'general'
                                CHECK (context IN ('sport','school','social','music','other','general')),
  context_detail    TEXT,
  profile_summary   TEXT,
  created_at        TIMESTAMPTZ DEFAULT now(),
  updated_at        TIMESTAMPTZ DEFAULT now(),
  UNIQUE (user_id)
);

ALTER TABLE public.character_profiles ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users manage own character profile"
  ON public.character_profiles FOR ALL
  USING  (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

CREATE TRIGGER handle_character_profiles_updated_at
  BEFORE UPDATE ON public.character_profiles
  FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();
