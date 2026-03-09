-- =============================================================================
-- NextAct Platform - Migration 00005: Next Act Ung Program
-- =============================================================================
-- Program for 12-15 year olds based on ACT/MAC framework.
-- 6 modules (order 0-5), 18 lessons (3 per module).
-- Uses template vars: {character_name}, {valued_direction}, {main_obstacle}, {context}
-- Video blocks have "videoId": null (placeholder) followed by a callout tip.
-- All user-facing text is in Swedish.
-- Content tone: concise, human, NOT academic. Short sentences. For 12-15 year olds.
--
-- This migration is applied via execute_sql in 4 batches:
--   Batch 1: Create program + 6 modules
--   Batch 2: Lessons for modules 0 and 1
--   Batch 3: Lessons for modules 2 and 3
--   Batch 4: Lessons for modules 4 and 5
-- =============================================================================

-- ---------------------------------------------------------------------------
-- BATCH 1: Program + Modules
-- ---------------------------------------------------------------------------

DO $$
DECLARE
  prog_id UUID;
BEGIN
  INSERT INTO programs (title, description, "order")
  VALUES ('Next Act Ung', 'Mental styrka för unga — ett program som hjälper dig att bli starkare i det som är viktigt för dig.', 1)
  RETURNING id INTO prog_id;

  INSERT INTO modules (program_id, title, description, "order", estimated_duration_minutes) VALUES
    (prog_id, 'Välkommen',       'Lär känna programmet och skapa din karaktär.',                      0, 20),
    (prog_id, 'Vad driver dig?', 'Hitta din drivkraft — det som är viktigt för dig.',                 1, 40),
    (prog_id, 'Vad stoppar dig?','Förstå hindren — tankar och känslor som bromsar.',                  2, 45),
    (prog_id, 'Vad gör du nu?',  'Förstå dina nuvarande reaktioner när det är svårt.',               3, 40),
    (prog_id, 'Nya verktyg',     'Lär dig konkreta verktyg för att ta dig framåt.',                   4, 50),
    (prog_id, 'Håll kursen',     'Bygg momentum och sätt ihop din gameplan.',                         5, 40);
END $$;

-- ---------------------------------------------------------------------------
-- BATCH 2: Lessons for Module 0 (Välkommen) and Module 1 (Vad driver dig?)
-- ---------------------------------------------------------------------------

-- Module 0, Lesson 0: Välkommen till Next Act
INSERT INTO lessons (module_id, title, lesson_type, "order", status, content)
VALUES (
  (SELECT m.id FROM modules m JOIN programs p ON p.id = m.program_id WHERE p.title = 'Next Act Ung' AND m."order" = 0),
  'Välkommen till Next Act',
  'video', 0, 'published',
  '[
    {"type":"video","title":"Introduktion","videoId":null},
    {"type":"callout","variant":"tip","content":"VIDEO: Animerad coach hälsar välkommen. Förklarar att {character_name} just skapats och att programmet handlar om mental styrka. Ca 90 sekunder."},
    {"type":"text","title":"Ditt program är personligt","content":"Du har just skapat {character_name} — din karaktär.\n\nUnder programmet hjälper du {character_name} att bli mentalt starkare.\n\nDet {character_name} lär sig kan du använda på riktigt — i {context} och i livet."}
  ]'::jsonb
);

-- Module 0, Lesson 1: Hur programmet funkar
INSERT INTO lessons (module_id, title, lesson_type, "order", status, content)
VALUES (
  (SELECT m.id FROM modules m JOIN programs p ON p.id = m.program_id WHERE p.title = 'Next Act Ung' AND m."order" = 0),
  'Hur programmet funkar',
  'text', 1, 'published',
  '[
    {"type":"text","title":"Sex steg framåt","content":"Det här programmet har sex delar.\n\nDel 1: Välkommen — det är den här delen.\nDel 2: Vad driver dig? — du hittar vad som är viktigt för dig.\nDel 3: Vad stoppar dig? — du förstår vad som bromsar.\nDel 4: Vad gör du nu? — du ser dina egna mönster.\nDel 5: Nya verktyg — du lär dig konkreta grejer.\nDel 6: Håll kursen — du sätter ihop en plan.\n\nVarje del tar 20-50 minuter. Du bestämmer tempot."},
    {"type":"callout","variant":"info","content":"Ingen del är svår. Men du behöver vara ärlig med dig själv. Det är det som gör skillnad."},
    {"type":"text","title":"Vad händer i varje lektion?","content":"Vissa lektioner har video. Andra har text att läsa eller frågor att svara på.\n\nDu behöver inga förkunskaper. Allt förklaras när du behöver det."}
  ]'::jsonb
);

-- Module 0, Lesson 2: Din karaktär är redo
INSERT INTO lessons (module_id, title, lesson_type, "order", status, content)
VALUES (
  (SELECT m.id FROM modules m JOIN programs p ON p.id = m.program_id WHERE p.title = 'Next Act Ung' AND m."order" = 0),
  'Din karaktär är redo',
  'text', 2, 'published',
  '[
    {"type":"story","title":"{character_name} tar första steget","content":"{character_name} tittar ut över planen. Det är mycket att tänka på — men en sak är säker: det är dags att börja.\n\nDu är med {character_name} på den här resan. Det {character_name} lär sig, lär du dig också."},
    {"type":"callout","variant":"success","content":"Modul 1 är klar! Du vet nu vad programmet går ut på och hur det funkar. Nästa steg: hitta vad som driver dig."}
  ]'::jsonb
);

-- Module 1, Lesson 0: Det som är viktigt
INSERT INTO lessons (module_id, title, lesson_type, "order", status, content)
VALUES (
  (SELECT m.id FROM modules m JOIN programs p ON p.id = m.program_id WHERE p.title = 'Next Act Ung' AND m."order" = 1),
  'Det som är viktigt',
  'video', 0, 'published',
  '[
    {"type":"video","title":"Drivkraft","videoId":null},
    {"type":"callout","variant":"tip","content":"VIDEO: Animerad coach förklarar skillnaden mellan mål (t.ex. vinna) och drivkraft (t.ex. att ge allt, vara med kompisar). Enkelt och kort, ca 2 minuter."},
    {"type":"text","title":"Mål vs drivkraft","content":"Ett mål är något du vill uppnå — som att vinna en match.\n\nEn drivkraft är varför det spelar roll för dig. Det är känslan bakom målet.\n\nMålet kan du misslyckas med. Drivkraften kan du alltid leva efter — oavsett om du vinner eller förlorar."},
    {"type":"callout","variant":"info","content":"I det här programmet kallar vi din drivkraft för din värderade riktning. Det låter svårt, men det är enkelt: vad vill du stå för?"}
  ]'::jsonb
);

-- Module 1, Lesson 1: Hitta din drivkraft
INSERT INTO lessons (module_id, title, lesson_type, "order", status, content)
VALUES (
  (SELECT m.id FROM modules m JOIN programs p ON p.id = m.program_id WHERE p.title = 'Next Act Ung' AND m."order" = 1),
  'Hitta din drivkraft',
  'exercise', 1, 'published',
  '[
    {"type":"text","title":"Vad driver {character_name}?","content":"Nu är det dags att ta reda på vad som driver {character_name}.\n\nTänk på en situation där {character_name} kände att det verkligen spelade roll. Inte för att det gick bra — utan för att det kändes rätt."},
    {"type":"exercise_choice","id":"valued_direction_area","title":"Vilket område är viktigast för {character_name} just nu?","options":["Prestera bättre i {context}","Vara en bra lagkamrat eller kompis","Våga ta plats och visa vem jag är","Hantera motgångar utan att ge upp","Något annat"]},
    {"type":"exercise_text","id":"valued_direction","title":"Beskriv {character_name}s drivkraft med egna ord","placeholder":"T.ex. \"Jag vill ge allt varje gång, även när det är svårt\" eller \"Jag vill vara någon mina kompisar kan lita på\"","hint":"Det finns inga rätta svar. Skriv det som känns sant för dig."}
  ]'::jsonb
);

-- Module 1, Lesson 2: Din kompassnål
INSERT INTO lessons (module_id, title, lesson_type, "order", status, content)
VALUES (
  (SELECT m.id FROM modules m JOIN programs p ON p.id = m.program_id WHERE p.title = 'Next Act Ung' AND m."order" = 1),
  'Din kompassnål',
  'text', 2, 'published',
  '[
    {"type":"story","title":"{character_name} vet vart det bär","content":"{character_name} tänker på det som precis kom fram. {valued_direction} — det är riktningen.\n\nEn kompassnål pekar alltid mot norr, oavsett var du är. Din drivkraft fungerar likadant. Den finns alltid där, även på dåliga dagar."},
    {"type":"text","title":"Spara den här känslan","content":"Du har nu hittat {character_name}s kompassnål — det som pekar mot rätt håll.\n\nNästa gång det känns tungt, påminn dig om den här riktningen. Det är inte ett krav. Det är bara en påminnelse om vad som är viktigt."},
    {"type":"callout","variant":"tip","content":"VECKANS UPPGIFT: Tänk på ett tillfälle den kommande veckan då du kan agera enligt {valued_direction}. Det behöver inte vara stort. Även ett litet steg räknas."}
  ]'::jsonb
);

-- ---------------------------------------------------------------------------
-- BATCH 3: Lessons for Module 2 (Vad stoppar dig?) and Module 3 (Vad gör du nu?)
-- ---------------------------------------------------------------------------

-- Module 2, Lesson 0: Apan i hjärnan
INSERT INTO lessons (module_id, title, lesson_type, "order", status, content)
VALUES (
  (SELECT m.id FROM modules m JOIN programs p ON p.id = m.program_id WHERE p.title = 'Next Act Ung' AND m."order" = 2),
  'Apan i hjärnan',
  'video', 0, 'published',
  '[
    {"type":"video","title":"Möt apan","videoId":null},
    {"type":"callout","variant":"tip","content":"VIDEO: Animerad coach introducerar \"apan\" som en metafor för kamp-eller-flykt-reaktionen. Apan vill skydda dig men tar ibland över. Enkelt, lite humoristiskt, ca 2 minuter."},
    {"type":"text","title":"Varför vi har en apa","content":"Din hjärna har ett larm — en del som alltid håller koll på fara.\n\nVi kallar den apan. Apan är snabb. Den reagerar innan du hinner tänka.\n\nNär apan tar över kan du känna dig stressad, nervös eller arg. Det är inte konstigt. Det är hjärnan som försöker hjälpa dig.\n\nProblemet är att apan ibland larmar i onödan — när du ska prestera, prata inför klassen eller prova något nytt."},
    {"type":"callout","variant":"info","content":"Apan är inte din fiende. Men du behöver lära dig känna igen den — annars styr den utan att du vet om det."}
  ]'::jsonb
);

-- Module 2, Lesson 1: Hitta {character_name}s apa
INSERT INTO lessons (module_id, title, lesson_type, "order", status, content)
VALUES (
  (SELECT m.id FROM modules m JOIN programs p ON p.id = m.program_id WHERE p.title = 'Next Act Ung' AND m."order" = 2),
  'Hitta {character_name}s apa',
  'exercise', 1, 'published',
  '[
    {"type":"text","title":"Hur låter {character_name}s apa?","content":"Alla apor låter lite olika. Vissa skriker \"du är inte bra nog\". Andra viskar \"ge upp\". Några gör att du vill gömma dig.\n\nNu ska du ta reda på hur {character_name}s apa låter."},
    {"type":"exercise_choice","id":"obstacle_type","title":"Hur visar sig {character_name}s apa oftast?","options":["Nervositet eller ångest inför prestationer","Negativa tankar (\"jag klarar det inte\")","Ilska eller frustration när det går dåligt","Jag vill ge upp eller undvika situationen","Jag jämför mig med andra och känner mig sämre"]},
    {"type":"exercise_text","id":"main_obstacle","title":"Beskriv {character_name}s apa med egna ord","placeholder":"T.ex. \"Innan match börjar apan säga att jag kommer göra bort mig\" eller \"När vi förlorar vill jag bara gå därifrån\"","hint":"Försök komma ihåg en konkret situation. Vad hände i kroppen? Vad sade apan?"}
  ]'::jsonb
);

-- Module 2, Lesson 2: Apan är normal
INSERT INTO lessons (module_id, title, lesson_type, "order", status, content)
VALUES (
  (SELECT m.id FROM modules m JOIN programs p ON p.id = m.program_id WHERE p.title = 'Next Act Ung' AND m."order" = 2),
  'Apan är normal',
  'text', 2, 'published',
  '[
    {"type":"story","title":"{character_name} ser apan för första gången","content":"{character_name} känner igen det nu. Det där obehaget innan — det är apan.\n\n{main_obstacle}. Det har hänt förut. Det kommer hända igen. Men nu vet {character_name} vad det är.\n\nOch det förändrar allt."},
    {"type":"text","title":"Alla har en apa","content":"Proffs, elever, lärare, tränare — alla har en apa.\n\nSkillnaden mellan dem som klarar trycket och dem som inte gör det handlar sällan om att apan är tyst. Det handlar om att de har lärt sig hur man hanterar den.\n\nDet är precis det du ska lära dig."},
    {"type":"callout","variant":"success","content":"Bra jobbat! Du har nu identifierat {character_name}s apa. Det är ett stort steg. Nästa del handlar om vad {character_name} gör när apan tar över."}
  ]'::jsonb
);

-- Module 3, Lesson 0: Vad händer när det är svårt?
INSERT INTO lessons (module_id, title, lesson_type, "order", status, content)
VALUES (
  (SELECT m.id FROM modules m JOIN programs p ON p.id = m.program_id WHERE p.title = 'Next Act Ung' AND m."order" = 3),
  'Vad händer när det är svårt?',
  'video', 0, 'published',
  '[
    {"type":"video","title":"Dina reaktioner","videoId":null},
    {"type":"callout","variant":"tip","content":"VIDEO: Animerad coach visar hur vi reagerar när det är svårt — vi antingen kämpar, flyr eller fryser. Koppling till apan från förra modulen. Ca 90 sekunder."},
    {"type":"text","title":"Tre vanliga reaktioner","content":"När apan larmar brukar vi göra en av tre saker:\n\n1. Vi kämpar — vi blir arga, skyller på andra, pressar hårdare.\n2. Vi flyr — vi undviker, hoppar av, låtsas att det inte spelar roll.\n3. Vi fryser — vi gör ingenting, hoppas att det löser sig självt.\n\nIngen av dem är fel. De är automatiska. Men de löser sällan problemet."},
    {"type":"callout","variant":"info","content":"Det du gör när det är svårt kallas din strategi. Nästa lektion hjälper dig se vilken strategi {character_name} använder mest."}
  ]'::jsonb
);

-- Module 3, Lesson 1: Vad gör {character_name}?
INSERT INTO lessons (module_id, title, lesson_type, "order", status, content)
VALUES (
  (SELECT m.id FROM modules m JOIN programs p ON p.id = m.program_id WHERE p.title = 'Next Act Ung' AND m."order" = 3),
  'Vad gör {character_name}?',
  'exercise', 1, 'published',
  '[
    {"type":"text","title":"Känn igen mönstret","content":"Tänk på senast {character_name} mötte {main_obstacle}. Vad hände? Inte vad du önskade skulle hända — utan vad som faktiskt hände."},
    {"type":"exercise_choice","id":"current_strategy","title":"Vad gjorde {character_name} när apan tog över?","options":["Kämpade hårdare — tryckte bort känslan och körde på","Undvek situationen — hoppade av eller drog sig undan","Frös — gjorde ingenting och hoppades det skulle gå över","Pratade med någon om det","Något annat"]},
    {"type":"exercise_text","id":"strategy_detail","title":"Berätta mer — vad hände konkret?","placeholder":"T.ex. \"Jag vägrade byta bana och körde om och om igen\" eller \"Jag låtsades att jag inte brydde mig och slutade försöka\"","hint":"Försök vara konkret. Ju mer specifikt, desto mer lär du dig om ditt eget mönster."},
    {"type":"callout","variant":"info","content":"Det här är inte kritik. Det är kartläggning. Att förstå vad du gör nu är det första steget mot att kunna göra något nytt."}
  ]'::jsonb
);

-- Module 3, Lesson 2: Läktaraktioner vs nyckelaktioner
INSERT INTO lessons (module_id, title, lesson_type, "order", status, content)
VALUES (
  (SELECT m.id FROM modules m JOIN programs p ON p.id = m.program_id WHERE p.title = 'Next Act Ung' AND m."order" = 3),
  'Läktaraktioner vs nyckelaktioner',
  'text', 2, 'published',
  '[
    {"type":"text","title":"Två typer av handlingar","content":"Vi kallar dem läktaraktioner och nyckelaktioner.\n\nEn läktaraktion tar dig bort från det som är viktigt. Det kan kännas bra i stunden — men det tar dig inte framåt. Exempel: undvika, ge upp, skälla på dig själv.\n\nEn nyckelhandling tar dig mot det du bryr dig om — mot {valued_direction}. Det kan kännas jobbigt. Men det är rätt riktning."},
    {"type":"callout","variant":"info","content":"Nyckelaktioner behöver inte vara stora. Ibland är den viktigaste nyckelhandlingen att stanna kvar när allt säger åt dig att dra dig undan."},
    {"type":"text","title":"Vilket är vilket?","content":"Samma sak kan vara en läktaraktion för en person och en nyckelhandling för en annan.\n\nDet beror på om handlingen tar dig mot eller bort från {valued_direction}.\n\nI nästa del lär du dig tre konkreta verktyg för att välja nyckelaktioner — även när apan skriker."}
  ]'::jsonb
);

-- ---------------------------------------------------------------------------
-- BATCH 4: Lessons for Module 4 (Nya verktyg) and Module 5 (Håll kursen)
-- ---------------------------------------------------------------------------

-- Module 4, Lesson 0: Tre verktyg
INSERT INTO lessons (module_id, title, lesson_type, "order", status, content)
VALUES (
  (SELECT m.id FROM modules m JOIN programs p ON p.id = m.program_id WHERE p.title = 'Next Act Ung' AND m."order" = 4),
  'Tre verktyg',
  'video', 0, 'published',
  '[
    {"type":"video","title":"Dina nya verktyg","videoId":null},
    {"type":"callout","variant":"tip","content":"VIDEO: Animerad coach introducerar de tre verktygen visuellt — andningsankaret visas som ett ankare, namnge apan som en pratbubbla, nyckelhandlingen som en nyckel. Motiverande ton, ca 2 minuter."},
    {"type":"text","title":"Verktyg 1: Andningsankaret","content":"När apan tar över — andas.\n\nInandning 4 sekunder. Håll 4 sekunder. Utandning 4 sekunder.\n\nDet tar bara 12 sekunder. Men det räcker för att hjärnan ska sluta larma lite grann. Nok för att du ska kunna tänka klart."},
    {"type":"text","title":"Verktyg 2: Namnge apan","content":"Ge din apa ett namn. Kalla den vad du vill — Larmet, Tvivlaren, Panikern.\n\nNär apan dyker upp, säg till dig själv: \"Där är [namn] igen.\"\n\nDet låter konstigt. Men det fungerar. Att sätta ett namn på apan gör att den känns mindre som sanningen och mer som en gäst som kommit på besök."},
    {"type":"text","title":"Verktyg 3: En nyckelhandling","content":"Välj en enda konkret sak du kan göra — som tar dig mot {valued_direction}.\n\nInget stort. Inte \"bli bättre\". Något litet och specifikt: gå tillbaka till banan, be om hjälp, försöka en gång till.\n\nEn nyckelhandling om dagen bygger upp mental styrka över tid."}
  ]'::jsonb
);

-- Module 4, Lesson 1: Träna verktygen
INSERT INTO lessons (module_id, title, lesson_type, "order", status, content)
VALUES (
  (SELECT m.id FROM modules m JOIN programs p ON p.id = m.program_id WHERE p.title = 'Next Act Ung' AND m."order" = 4),
  'Träna verktygen',
  'exercise', 1, 'published',
  '[
    {"type":"text","title":"Dags att prova","content":"Nu ska {character_name} välja ett verktyg att öva på den kommande veckan.\n\nDet bästa verktyget är det som passar just din situation. Tänk på {main_obstacle} — vilket verktyg tror du hjälper mest?"},
    {"type":"exercise_choice","id":"chosen_tool","title":"Vilket verktyg väljer {character_name} att öva på?","options":["Andningsankaret — andas när apan tar över","Namnge apan — ge den ett namn och lägg märke till när den dyker upp","En nyckelhandling — välj en konkret sak att göra trots obehaget"]},
    {"type":"exercise_text","id":"tool_plan","title":"Hur ska {character_name} använda verktyget?","placeholder":"T.ex. \"Innan varje träning ska jag andas i 12 sekunder i omklädningsrummet\" eller \"Jag kallar min apa Larmet och säger det tyst när den dyker upp\"","hint":"Var specifik — när, var och hur. Ju mer konkret, desto lättare att faktiskt göra det."}
  ]'::jsonb
);

-- Module 4, Lesson 2: Våga-listan
INSERT INTO lessons (module_id, title, lesson_type, "order", status, content)
VALUES (
  (SELECT m.id FROM modules m JOIN programs p ON p.id = m.program_id WHERE p.title = 'Next Act Ung' AND m."order" = 4),
  'Våga-listan',
  'exercise', 2, 'published',
  '[
    {"type":"text","title":"Vad behöver {character_name} våga?","content":"Mental styrka byggs inte i teorin. Den byggs när du gör saker som känns svåra.\n\nVåga-listan är tre situationer där {character_name} kan öva. Börja med det minst läskiga. Ta dig uppåt i din egen takt."},
    {"type":"exercise_text","id":"dare_1","title":"Situation 1 — lite utmanande","placeholder":"T.ex. \"Prata med tränaren efter träning\" eller \"Stanna kvar i kastet även om det känns dåligt\"","hint":"Något som känns lite obehagligt men ganska hanterbart."},
    {"type":"exercise_text","id":"dare_2","title":"Situation 2 — rätt utmanande","placeholder":"T.ex. \"Be om mer speltid\" eller \"Försöka på nytt direkt efter ett misstag\"","hint":"Något som kräver att du tar i lite mer."},
    {"type":"exercise_text","id":"dare_3","title":"Situation 3 — riktigt utmanande","placeholder":"T.ex. \"Ta ansvar inför laget när det gick dåligt\" eller \"Prata om nervositet med en kompis\"","hint":"Något du normalt undviker. Det du vet att {character_name} behöver göra."},
    {"type":"callout","variant":"tip","content":"Du behöver inte göra alla tre den här veckan. Välj en. Gör den. Märk att du klarade det."}
  ]'::jsonb
);

-- Module 5, Lesson 0: Hur gick det?
INSERT INTO lessons (module_id, title, lesson_type, "order", status, content)
VALUES (
  (SELECT m.id FROM modules m JOIN programs p ON p.id = m.program_id WHERE p.title = 'Next Act Ung' AND m."order" = 5),
  'Hur gick det?',
  'exercise', 0, 'published',
  '[
    {"type":"text","title":"Kolla in med {character_name}","content":"Förra veckan valde {character_name} ett verktyg och en situation att öva i.\n\nOavsett hur det gick — du är här nu. Det räknas."},
    {"type":"exercise_choice","id":"attempt_result","title":"Hur gick det när {character_name} provade?","options":["Det gick bättre än väntat","Det var svårt men jag klarade det","Apan tog över men jag märkte det","Jag fick inte chansen att prova","Det gick inte alls som planerat"]},
    {"type":"exercise_text","id":"attempt_reflection","title":"Vad lärde sig {character_name}?","placeholder":"T.ex. \"Jag märkte att andningen faktiskt hjälpte\" eller \"Apan var starkare än jag trodde, men jag stannade kvar\"","hint":"Det viktigaste är inte att det gick bra. Det viktigaste är vad du lärde dig om dig själv."},
    {"type":"callout","variant":"info","content":"Mental träning fungerar precis som fysisk träning. Det händer ingenting av ett enda pass. Det är upprepningen som bygger styrkan."}
  ]'::jsonb
);

-- Module 5, Lesson 1: Din gameplan
INSERT INTO lessons (module_id, title, lesson_type, "order", status, content)
VALUES (
  (SELECT m.id FROM modules m JOIN programs p ON p.id = m.program_id WHERE p.title = 'Next Act Ung' AND m."order" = 5),
  'Din gameplan',
  'exercise', 1, 'published',
  '[
    {"type":"text","title":"Sätt ihop {character_name}s gameplan","content":"Nu har {character_name} allt som behövs.\n\nEn drivkraft: {valued_direction}.\nEtt hinder: {main_obstacle}.\nEtt verktyg som fungerar.\n\nNu sätter du ihop det till en gameplan — tre konkreta saker att fortsätta med."},
    {"type":"exercise_text","id":"gameplan_direction","title":"Min riktning","placeholder":"Skriv {valued_direction} med dina egna ord. Vad vill {character_name} stå för?","hint":"En mening räcker. Det ska kännas sant."},
    {"type":"exercise_text","id":"gameplan_tool","title":"Mitt verktyg","placeholder":"Vilket verktyg använder {character_name}? När och hur?","hint":"Var specifik. T.ex. \"Andningsankaret innan matchstart, i omklädningsrummet.\""},
    {"type":"exercise_text","id":"gameplan_action","title":"Min nyckelhandling den kommande veckan","placeholder":"En konkret sak {character_name} ska göra — mot {valued_direction}, trots {main_obstacle}.","hint":"Litet och specifikt. Något du faktiskt kan göra."}
  ]'::jsonb
);

-- Module 5, Lesson 2: Avslutning
INSERT INTO lessons (module_id, title, lesson_type, "order", status, content)
VALUES (
  (SELECT m.id FROM modules m JOIN programs p ON p.id = m.program_id WHERE p.title = 'Next Act Ung' AND m."order" = 5),
  'Avslutning',
  'text', 2, 'published',
  '[
    {"type":"story","title":"{character_name} ser tillbaka","content":"{character_name} vet nu vad som driver. Vad som stoppar. Vad som faktiskt funkar.\n\nDet är inte slutet på resan. Det är början.\n\nVarje gång du möter {main_obstacle} och väljer en nyckelhandling ändå — då växer du. Det syns inte alltid direkt. Men det händer."},
    {"type":"text","title":"Tack för att du var med","content":"Du har gjort något som de flesta aldrig gör: du har tagit tid att förstå hur du fungerar.\n\nDet är mental styrka på riktigt — inte att aldrig känna sig nervös eller osäker, utan att veta vad du gör med de känslorna.\n\n{character_name} är redo. Och det är du också."},
    {"type":"callout","variant":"success","content":"Program slutfört! Ta med dig din gameplan. Använd den. Och kom tillbaka hit om du behöver en påminnelse om vad du är kapabel till."}
  ]'::jsonb
);
