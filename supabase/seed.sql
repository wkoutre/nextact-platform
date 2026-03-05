-- =============================================================================
-- NextAct Platform - Seed Data
-- Based on the actual Next Act / Pratamera Sport curriculum
-- 12 modules mapping to ACT/MAC framework
-- =============================================================================

-- Default program
INSERT INTO public.programs (id, title, description, "order") VALUES
  ('00000000-0000-0000-0000-000000000001',
   'Mental Träning för Idrottare',
   'Steg för steg till mental styrka. Ett evidensbaserat program byggt på ACT och MAC för att utveckla psykologisk flexibilitet och topprestationer.',
   1);

-- ---------------------------------------------------------------------------
-- Module 1: Analys
-- ---------------------------------------------------------------------------
INSERT INTO public.modules (id, program_id, title, description, act_process, icon, color_theme, "order", estimated_duration_minutes) VALUES
  ('00000000-0000-0000-0001-000000000001',
   '00000000-0000-0000-0000-000000000001',
   'Analys',
   'Kartlägg din nuvarande idrottssituation. Identifiera dina mål, styrkor och utvecklingsområden som utgångspunkt för din mentala träning.',
   'values', 'clipboard', 'slate', 1, 30);

INSERT INTO public.lessons (id, module_id, title, "order", lesson_type, content, duration_seconds, status) VALUES
  ('00000000-0000-0000-0001-000000000101', '00000000-0000-0000-0001-000000000001', 'Välkommen till programmet', 1, 'video', '[]', 180, 'published'),
  ('00000000-0000-0000-0001-000000000102', '00000000-0000-0000-0001-000000000001', 'Din idrottssituation idag', 2, 'exercise', '[]', 300, 'published'),
  ('00000000-0000-0000-0001-000000000103', '00000000-0000-0000-0001-000000000001', 'Sätt dina utvecklingsmål', 3, 'exercise', '[]', 300, 'published'),
  ('00000000-0000-0000-0001-000000000104', '00000000-0000-0000-0001-000000000001', 'Introduktion till mental styrka', 4, 'text', '[]', 180, 'published'),
  ('00000000-0000-0000-0001-000000000105', '00000000-0000-0000-0001-000000000001', 'Reflektion: Var börjar du?', 5, 'reflection', '[]', 180, 'published');

-- ---------------------------------------------------------------------------
-- Module 2: Värderad Riktning
-- ---------------------------------------------------------------------------
INSERT INTO public.modules (id, program_id, title, description, act_process, icon, color_theme, "order", estimated_duration_minutes) VALUES
  ('00000000-0000-0000-0001-000000000002',
   '00000000-0000-0000-0000-000000000001',
   'Värderad Riktning',
   'Utforska din värderade riktning och dess roll för din måluppfyllelse. Börja bygga din personliga tuffhetsmodell.',
   'values', 'compass', 'rose', 2, 35);

INSERT INTO public.lessons (id, module_id, title, "order", lesson_type, content, duration_seconds, status) VALUES
  ('00000000-0000-0000-0002-000000000101', '00000000-0000-0000-0001-000000000002', 'Vad är värderad riktning?', 1, 'video', '[]', 180, 'published'),
  ('00000000-0000-0000-0002-000000000102', '00000000-0000-0000-0001-000000000002', 'Dina värderingar som idrottare', 2, 'exercise', '[]', 300, 'published'),
  ('00000000-0000-0000-0002-000000000103', '00000000-0000-0000-0001-000000000002', 'Tuffhetsmodellen — del 1', 3, 'text', '[]', 180, 'published'),
  ('00000000-0000-0000-0002-000000000104', '00000000-0000-0000-0001-000000000002', 'Bygg din värderade riktning', 4, 'exercise', '[]', 300, 'published'),
  ('00000000-0000-0000-0002-000000000105', '00000000-0000-0000-0001-000000000002', 'Reflektion: Din kompass', 5, 'reflection', '[]', 180, 'published');

-- ---------------------------------------------------------------------------
-- Module 3: Utforska Hinder
-- ---------------------------------------------------------------------------
INSERT INTO public.modules (id, program_id, title, description, act_process, icon, color_theme, "order", estimated_duration_minutes) VALUES
  ('00000000-0000-0000-0001-000000000003',
   '00000000-0000-0000-0000-000000000001',
   'Utforska Hinder',
   'Förstå hur hjärnan fungerar och hur tankar och känslor skapar prestationshinder. Utveckla tuffhetsmodellen med identifierade hinder.',
   'acceptance', 'brain', 'violet', 3, 35);

INSERT INTO public.lessons (id, module_id, title, "order", lesson_type, content, duration_seconds, status) VALUES
  ('00000000-0000-0000-0003-000000000101', '00000000-0000-0000-0001-000000000003', 'Hur hjärnan skapar hinder', 1, 'video', '[]', 180, 'published'),
  ('00000000-0000-0000-0003-000000000102', '00000000-0000-0000-0001-000000000003', 'Tankar och känslor som fällor', 2, 'text', '[]', 180, 'published'),
  ('00000000-0000-0000-0003-000000000103', '00000000-0000-0000-0001-000000000003', 'Identifiera dina hinder', 3, 'exercise', '[]', 300, 'published'),
  ('00000000-0000-0000-0003-000000000104', '00000000-0000-0000-0001-000000000003', 'Tuffhetsmodellen — del 2', 4, 'text', '[]', 180, 'published'),
  ('00000000-0000-0000-0003-000000000105', '00000000-0000-0000-0001-000000000003', 'Reflektion: Dina prestationshinder', 5, 'reflection', '[]', 180, 'published');

-- ---------------------------------------------------------------------------
-- Module 4: Dina Beteenden
-- ---------------------------------------------------------------------------
INSERT INTO public.modules (id, program_id, title, description, act_process, icon, color_theme, "order", estimated_duration_minutes) VALUES
  ('00000000-0000-0000-0001-000000000004',
   '00000000-0000-0000-0000-000000000001',
   'Dina Beteenden',
   'Analysera dina beteenden i olika idrottssituationer. Identifiera nyckelbeteenden och nya möjligheter att träna dem.',
   'committed_action', 'activity', 'emerald', 4, 35);

INSERT INTO public.lessons (id, module_id, title, "order", lesson_type, content, duration_seconds, status) VALUES
  ('00000000-0000-0000-0004-000000000101', '00000000-0000-0000-0001-000000000004', 'Beteenden i idrott', 1, 'video', '[]', 180, 'published'),
  ('00000000-0000-0000-0004-000000000102', '00000000-0000-0000-0001-000000000004', 'Kartlägg dina beteenden', 2, 'exercise', '[]', 300, 'published'),
  ('00000000-0000-0000-0004-000000000103', '00000000-0000-0000-0001-000000000004', 'Nyckelbeteenden', 3, 'text', '[]', 180, 'published'),
  ('00000000-0000-0000-0004-000000000104', '00000000-0000-0000-0001-000000000004', 'Träna nyckelbeteenden', 4, 'exercise', '[]', 300, 'published'),
  ('00000000-0000-0000-0004-000000000105', '00000000-0000-0000-0001-000000000004', 'Reflektion: Dina vanor', 5, 'reflection', '[]', 180, 'published');

-- ---------------------------------------------------------------------------
-- Module 5: Våga Utmana
-- ---------------------------------------------------------------------------
INSERT INTO public.modules (id, program_id, title, description, act_process, icon, color_theme, "order", estimated_duration_minutes) VALUES
  ('00000000-0000-0000-0001-000000000005',
   '00000000-0000-0000-0000-000000000001',
   'Våga Utmana',
   'Utforska mental styrka genom varierade situationer. Skapa din egen våga-lista och utveckla din förmåga att möta utmaningar.',
   'committed_action', 'flame', 'amber', 5, 30);

INSERT INTO public.lessons (id, module_id, title, "order", lesson_type, content, duration_seconds, status) VALUES
  ('00000000-0000-0000-0005-000000000101', '00000000-0000-0000-0001-000000000005', 'Att våga — utanför komfortzonen', 1, 'video', '[]', 180, 'published'),
  ('00000000-0000-0000-0005-000000000102', '00000000-0000-0000-0001-000000000005', 'Din våga-lista', 2, 'exercise', '[]', 300, 'published'),
  ('00000000-0000-0000-0005-000000000103', '00000000-0000-0000-0001-000000000005', 'Utmana dig själv i vardagen', 3, 'exercise', '[]', 300, 'published'),
  ('00000000-0000-0000-0005-000000000104', '00000000-0000-0000-0001-000000000005', 'Reflektion: Mod och tillväxt', 4, 'reflection', '[]', 180, 'published');

-- ---------------------------------------------------------------------------
-- Module 6: Fokusera Mera
-- ---------------------------------------------------------------------------
INSERT INTO public.modules (id, program_id, title, description, act_process, icon, color_theme, "order", estimated_duration_minutes) VALUES
  ('00000000-0000-0000-0001-000000000006',
   '00000000-0000-0000-0000-000000000001',
   'Fokusera Mera',
   'Fördjupade fokusövningar för att förbereda dig för träningsbaserat fokusarbete. Öka din koncentrationsförmåga.',
   'present_moment', 'eye', 'sky', 6, 30);

INSERT INTO public.lessons (id, module_id, title, "order", lesson_type, content, duration_seconds, status) VALUES
  ('00000000-0000-0000-0006-000000000101', '00000000-0000-0000-0001-000000000006', 'Fokus — din superkraft', 1, 'video', '[]', 180, 'published'),
  ('00000000-0000-0000-0006-000000000102', '00000000-0000-0000-0001-000000000006', 'Grundläggande fokusövning', 2, 'exercise', '[]', 300, 'published'),
  ('00000000-0000-0000-0006-000000000103', '00000000-0000-0000-0001-000000000006', 'Avancerad fokusövning', 3, 'exercise', '[]', 300, 'published'),
  ('00000000-0000-0000-0006-000000000104', '00000000-0000-0000-0001-000000000006', 'Fokus under press', 4, 'text', '[]', 180, 'published'),
  ('00000000-0000-0000-0006-000000000105', '00000000-0000-0000-0001-000000000006', 'Reflektion: Ditt fokus', 5, 'reflection', '[]', 180, 'published');

-- ---------------------------------------------------------------------------
-- Module 7: Målsättning & Utvärdering
-- ---------------------------------------------------------------------------
INSERT INTO public.modules (id, program_id, title, description, act_process, icon, color_theme, "order", estimated_duration_minutes) VALUES
  ('00000000-0000-0000-0001-000000000007',
   '00000000-0000-0000-0000-000000000001',
   'Målsättning & Utvärdering',
   'Lär dig effektiv målsättning och utvärdering. Sätt upp mål och mät förändringar i din prestation.',
   'committed_action', 'target', 'blue', 7, 35);

INSERT INTO public.lessons (id, module_id, title, "order", lesson_type, content, duration_seconds, status) VALUES
  ('00000000-0000-0000-0007-000000000101', '00000000-0000-0000-0001-000000000007', 'Målsättning som verktyg', 1, 'video', '[]', 180, 'published'),
  ('00000000-0000-0000-0007-000000000102', '00000000-0000-0000-0001-000000000007', 'Sätt dina mål', 2, 'exercise', '[]', 300, 'published'),
  ('00000000-0000-0000-0007-000000000103', '00000000-0000-0000-0001-000000000007', 'Utvärdera din progress', 3, 'exercise', '[]', 300, 'published'),
  ('00000000-0000-0000-0007-000000000104', '00000000-0000-0000-0001-000000000007', 'Reflektion: Mål och riktning', 4, 'reflection', '[]', 180, 'published');

-- ---------------------------------------------------------------------------
-- Module 8: Hitta Balansen
-- ---------------------------------------------------------------------------
INSERT INTO public.modules (id, program_id, title, description, act_process, icon, color_theme, "order", estimated_duration_minutes) VALUES
  ('00000000-0000-0000-0001-000000000008',
   '00000000-0000-0000-0000-000000000001',
   'Hitta Balansen',
   'Uppdatera tuffhetsmodellen med svårare situationer. Utforska balansen mellan idrott och privatliv.',
   'self_as_context', 'scale', 'teal', 8, 35);

INSERT INTO public.lessons (id, module_id, title, "order", lesson_type, content, duration_seconds, status) VALUES
  ('00000000-0000-0000-0008-000000000101', '00000000-0000-0000-0001-000000000008', 'Balans i en krävande vardag', 1, 'video', '[]', 180, 'published'),
  ('00000000-0000-0000-0008-000000000102', '00000000-0000-0000-0001-000000000008', 'Din tuffhetsmodell — uppdatering', 2, 'exercise', '[]', 300, 'published'),
  ('00000000-0000-0000-0008-000000000103', '00000000-0000-0000-0001-000000000008', 'Idrott och livet utanför', 3, 'text', '[]', 180, 'published'),
  ('00000000-0000-0000-0008-000000000104', '00000000-0000-0000-0001-000000000008', 'Reflektion: Din balans', 4, 'reflection', '[]', 180, 'published');

-- ---------------------------------------------------------------------------
-- Module 9: Återhämtning
-- ---------------------------------------------------------------------------
INSERT INTO public.modules (id, program_id, title, description, act_process, icon, color_theme, "order", estimated_duration_minutes) VALUES
  ('00000000-0000-0000-0001-000000000009',
   '00000000-0000-0000-0000-000000000001',
   'Återhämtning',
   'Utforska balansen mellan träning och återhämtning. Planera hållbar träning med rätt förhållningssätt till kost och sömn.',
   'acceptance', 'battery', 'green', 9, 35);

INSERT INTO public.lessons (id, module_id, title, "order", lesson_type, content, duration_seconds, status) VALUES
  ('00000000-0000-0000-0009-000000000101', '00000000-0000-0000-0001-000000000009', 'Träning och vila — två sidor', 1, 'video', '[]', 180, 'published'),
  ('00000000-0000-0000-0009-000000000102', '00000000-0000-0000-0001-000000000009', 'Din återhämtningsplan', 2, 'exercise', '[]', 300, 'published'),
  ('00000000-0000-0000-0009-000000000103', '00000000-0000-0000-0001-000000000009', 'Kost och sömn för prestation', 3, 'text', '[]', 180, 'published'),
  ('00000000-0000-0000-0009-000000000104', '00000000-0000-0000-0001-000000000009', 'Hållbar träningsplanering', 4, 'exercise', '[]', 300, 'published'),
  ('00000000-0000-0000-0009-000000000105', '00000000-0000-0000-0001-000000000009', 'Reflektion: Din återhämtning', 5, 'reflection', '[]', 180, 'published');

-- ---------------------------------------------------------------------------
-- Module 10: Din Inre Kritiker
-- ---------------------------------------------------------------------------
INSERT INTO public.modules (id, program_id, title, description, act_process, icon, color_theme, "order", estimated_duration_minutes) VALUES
  ('00000000-0000-0000-0001-000000000010',
   '00000000-0000-0000-0000-000000000001',
   'Din Inre Kritiker',
   'Utveckla medvetenhet om ditt inre självprat. Skriv om din personliga berättelse på ett konstruktivt sätt.',
   'defusion', 'message-circle', 'purple', 10, 35);

INSERT INTO public.lessons (id, module_id, title, "order", lesson_type, content, duration_seconds, status) VALUES
  ('00000000-0000-0000-0010-000000000101', '00000000-0000-0000-0001-000000000010', 'Möt din inre kritiker', 1, 'video', '[]', 180, 'published'),
  ('00000000-0000-0000-0010-000000000102', '00000000-0000-0000-0001-000000000010', 'Ditt inre självprat', 2, 'exercise', '[]', 300, 'published'),
  ('00000000-0000-0000-0010-000000000103', '00000000-0000-0000-0001-000000000010', 'Skriv om din berättelse', 3, 'exercise', '[]', 300, 'published'),
  ('00000000-0000-0000-0010-000000000104', '00000000-0000-0000-0001-000000000010', 'Självmedkänsla i idrott', 4, 'text', '[]', 180, 'published'),
  ('00000000-0000-0000-0010-000000000105', '00000000-0000-0000-0001-000000000010', 'Reflektion: Din nya berättelse', 5, 'reflection', '[]', 180, 'published');

-- ---------------------------------------------------------------------------
-- Module 11: Hantera Motgångar
-- ---------------------------------------------------------------------------
INSERT INTO public.modules (id, program_id, title, description, act_process, icon, color_theme, "order", estimated_duration_minutes) VALUES
  ('00000000-0000-0000-0001-000000000011',
   '00000000-0000-0000-0000-000000000001',
   'Hantera Motgångar',
   'Utforska strategier för att hantera motgångar och omvandla dem till utvecklingsmöjligheter.',
   'acceptance', 'shield', 'orange', 11, 35);

INSERT INTO public.lessons (id, module_id, title, "order", lesson_type, content, duration_seconds, status) VALUES
  ('00000000-0000-0000-0011-000000000101', '00000000-0000-0000-0001-000000000011', 'Motgångar — en del av resan', 1, 'video', '[]', 180, 'published'),
  ('00000000-0000-0000-0011-000000000102', '00000000-0000-0000-0001-000000000011', 'Dina motgångserfarenheter', 2, 'exercise', '[]', 300, 'published'),
  ('00000000-0000-0000-0011-000000000103', '00000000-0000-0000-0001-000000000011', 'Strategier för motgångar', 3, 'text', '[]', 180, 'published'),
  ('00000000-0000-0000-0011-000000000104', '00000000-0000-0000-0001-000000000011', 'Vänd motgång till utveckling', 4, 'exercise', '[]', 300, 'published'),
  ('00000000-0000-0000-0011-000000000105', '00000000-0000-0000-0001-000000000011', 'Reflektion: Styrka genom motgångar', 5, 'reflection', '[]', 180, 'published');

-- ---------------------------------------------------------------------------
-- Module 12: Utvärdering och Planering
-- ---------------------------------------------------------------------------
INSERT INTO public.modules (id, program_id, title, description, act_process, icon, color_theme, "order", estimated_duration_minutes) VALUES
  ('00000000-0000-0000-0001-000000000012',
   '00000000-0000-0000-0000-000000000001',
   'Utvärdering och Planering',
   'Sammanfatta din utveckling och skapa en plan för din framtida idrottskarriär. Integrera alla verktyg du lärt dig.',
   'integration', 'award', 'gold', 12, 35);

INSERT INTO public.lessons (id, module_id, title, "order", lesson_type, content, duration_seconds, status) VALUES
  ('00000000-0000-0000-0012-000000000101', '00000000-0000-0000-0001-000000000012', 'Din resa — en tillbakablick', 1, 'video', '[]', 180, 'published'),
  ('00000000-0000-0000-0012-000000000102', '00000000-0000-0000-0001-000000000012', 'Utvärdera din utveckling', 2, 'exercise', '[]', 300, 'published'),
  ('00000000-0000-0000-0012-000000000103', '00000000-0000-0000-0001-000000000012', 'Din framtidsplan', 3, 'exercise', '[]', 300, 'published'),
  ('00000000-0000-0000-0012-000000000104', '00000000-0000-0000-0001-000000000012', 'Reflektion: Vägen framåt', 4, 'reflection', '[]', 180, 'published');
