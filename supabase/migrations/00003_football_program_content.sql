-- =============================================================================
-- NextAct Platform - Migration 00003: Football Program Content from Moodle
-- =============================================================================
-- Generated from Moodle backup: fotboll-20260306
-- 8 modules (Welcome + 7), 42 lessons with full content blocks

DO $$
DECLARE
  prog_id uuid;
  mod0_id uuid;
  mod1_id uuid;
  mod2_id uuid;
  mod3_id uuid;
  mod4_id uuid;
  mod5_id uuid;
  mod6_id uuid;
  mod7_id uuid;
  les_174_id uuid;
  les_175_id uuid;
  les_176_id uuid;
  les_177_id uuid;
  les_179_id uuid;
  les_180_id uuid;
  les_181_id uuid;
  les_182_id uuid;
  les_183_id uuid;
  les_184_id uuid;
  les_185_id uuid;
  les_186_id uuid;
  les_187_id uuid;
  les_188_id uuid;
  les_189_id uuid;
  les_190_id uuid;
  les_191_id uuid;
  les_192_id uuid;
  les_193_id uuid;
  les_194_id uuid;
  les_195_id uuid;
  les_196_id uuid;
  les_197_id uuid;
  les_198_id uuid;
  les_199_id uuid;
  les_200_id uuid;
  les_201_id uuid;
  les_202_id uuid;
  les_203_id uuid;
  les_204_id uuid;
  les_205_id uuid;
  les_206_id uuid;
  les_207_id uuid;
  les_208_id uuid;
  les_209_id uuid;
  les_210_id uuid;
  les_211_id uuid;
  les_212_id uuid;
  les_213_id uuid;
  les_216_id uuid;
  les_217_id uuid;
  les_218_id uuid;
BEGIN

  -- -------------------------------------------------------------------------
  -- Get or create the Fotboll program
  -- -------------------------------------------------------------------------
  SELECT id INTO prog_id FROM public.programs WHERE title = 'Fotboll' LIMIT 1;
  IF prog_id IS NULL THEN
    INSERT INTO public.programs (title, description, "order")
    VALUES ('Fotboll', 'Fotbollsprogrammet – mental träning för fotbollsspelare', 1)
    RETURNING id INTO prog_id;
  END IF;

  -- -------------------------------------------------------------------------
  -- Delete existing modules (cascades to lessons)
  -- -------------------------------------------------------------------------
  DELETE FROM public.modules WHERE program_id = prog_id;

  -- =========================================================================
  -- INSERT MODULES
  -- =========================================================================

  -- Module 0: Välkommen till Next Act
  INSERT INTO public.modules (program_id, title, description, act_process, "order", estimated_duration_minutes)
  VALUES (prog_id, 'Välkommen till Next Act', 'En introduktion till programmet och verktygen du kommer använda.', NULL, 0, 15)
  RETURNING id INTO mod0_id;

  -- Module 1: Modul 1 – Psykologin bakom prestation
  INSERT INTO public.modules (program_id, title, description, act_process, "order", estimated_duration_minutes)
  VALUES (prog_id, 'Modul 1 – Psykologin bakom prestation', 'I denna första modul gör du en övergripande analys av ditt idrottande så du får en tydlig bild av var du är just nu, vart du vill och vilka förutsättningar och hinder som finns för att ta dig dit. Vi går också igenom vad mental styrka är och vad som krävs för att uppnå det.', 'orientation', 1, 45)
  RETURNING id INTO mod1_id;

  -- Module 2: Modul 2 – Din värderade riktning
  INSERT INTO public.modules (program_id, title, description, act_process, "order", estimated_duration_minutes)
  VALUES (prog_id, 'Modul 2 – Din värderade riktning', 'Vi går igenom vad "värderad riktning" är och på vilket sätt den kan hjälpa dig att ta dig mot dina mål. Du börjar bygga din personliga mentala tuffhetsmodell genom att utforska och identifiera vad just din värderade riktning är.', 'values', 2, 50)
  RETURNING id INTO mod2_id;

  -- Module 3: Modul 3 – Hinder för prestation
  INSERT INTO public.modules (program_id, title, description, act_process, "order", estimated_duration_minutes)
  VALUES (prog_id, 'Modul 3 – Hinder för prestation', 'Vi går igenom hur hjärnan fungerar och undersöker hur tankar och känslor kan utgöra hinder för vår förmåga att prestera. Du fortsätter bygga på din mentala tuffhetsmodell genom att identifiera vilka just dina hinder är.', 'defusion', 3, 60)
  RETURNING id INTO mod3_id;

  -- Module 4: Modul 4 – Analysera dina beteenden
  INSERT INTO public.modules (program_id, title, description, act_process, "order", estimated_duration_minutes)
  VALUES (prog_id, 'Modul 4 – Analysera dina beteenden', 'Nu är det dags att undersöka vilka beteenden du har i olika situationer, vad exakt du gör och varför. Du identifierar nyckelaktioner och lär dig en ny metodik för att öva på dina nyckelaktioner när du tränar.', 'commitment', 4, 60)
  RETURNING id INTO mod4_id;

  -- Module 5: Modul 5 – Strategier och nyckelaktioner
  INSERT INTO public.modules (program_id, title, description, act_process, "order", estimated_duration_minutes)
  VALUES (prog_id, 'Modul 5 – Strategier och nyckelaktioner', 'Du fortsätter utforska din mentala tuffhet genom att hitta fler situationer där du kan öva upp din mentala styrka, även i ditt liv utanför idrotten. Du gör en "våga-lista" att jobba med under träningspass och fortsätter skärpa din fokus genom olika övningar.', 'action', 5, 55)
  RETURNING id INTO mod5_id;

  -- Module 6: Modul 6 – Din förmåga att fokusera
  INSERT INTO public.modules (program_id, title, description, act_process, "order", estimated_duration_minutes)
  VALUES (prog_id, 'Modul 6 – Din förmåga att fokusera', 'Denna modul ägnar vi helt åt din förmåga att fokusera. Vi utforskar och gör fokusövningar i olika svårighetsgrad för att förbereda dig inför det fokusarbete du kommer göra under veckans träningspass.', 'present', 6, 50)
  RETURNING id INTO mod6_id;

  -- Module 7: Modul 7 – Avslutning
  INSERT INTO public.modules (program_id, title, description, act_process, "order", estimated_duration_minutes)
  VALUES (prog_id, 'Modul 7 – Avslutning', 'Här rundar vi av programmet och hjälper dig lägga upp en plan framåt. Vi skapar också en personlig gameplan som du kan använda dig av i din vardag och under match.', 'integration', 7, 20)
  RETURNING id INTO mod7_id;

  -- =========================================================================
  -- INSERT LESSONS
  -- =========================================================================

  -- Lesson: Välkommen till Next Act (section 174)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod0_id,
    'Välkommen till Next Act',
    0,
    'text',
    '[{"type": "video", "title": "Introduktion Axel", "videoId": "1100225761"}, {"type": "text", "title": "Programmets innehåll", "content": "Här får du en snabb inblick i hur programmet är uppbyggt och vilket innehåll de olika modulerna har. I varje modul presenteras ett träningsprogram med övningar som du ska genomföra i din vardag och i samband med dina vanliga träningspass under veckan. Ju mer du tränar, desto mer kommer du få ut av programmet. Klicka på siffrorna på kartan för att läsa mer om varje steg."}, {"type": "text", "title": "Bli din egen mentala tränare", "content": "Målsättningen med mental träning, som vi ser det, är att du ska bli din egen mentala tränare. Du ska bli mer självständig och självgående när det gäller att hantera dina mentala utmaningar och behöva mindre hjälp av idrottspsykologiska rådgivare. Detta innebär inte att du helt och hållet hanterar allt själv, det finns naturligtvis många situationer där du kanske behöver få hjälp och ha någon professionell som bollplank. Men i det stora hela är ambitionen att du så småningom ska kunna hantera det mesta på egen hand."}, {"type": "text", "title": "Teorin bakom programmet", "content": "De teoretiska ramarna som det här mentala träningsprogrammet bygger på är en vidareutveckling av Kognitiv beteendeterapi (KBT) och kallas Acceptance and Commitment Therapy, ACT. Det bygger även på en vidareutveckling av ACT, där fokus ligger på själva utförandet, d.v.s. det du ska göra. Denna metod kallas för MAC.\n\nI korta drag handlar ACT om att identifiera, drivas och vägledas av vad du verkligen vill göra med ditt liv. Det du har ansvar att, inför dig själv, sträva mot. Det handlar om att hitta strategier för att ta med dig hinder på vägen istället för att undvika dem, som t.ex. begränsande tankar, känslor och andra saker du vill undvika och som brukar dyka upp när du vill göra något som verkligen är viktigt för dig."}, {"type": "text", "title": "Tack för dina svar! Nu ger vi oss in i idrottspsykologins värld!", "content": "Om du känner att du mår dåligt och inte vet vem du ska prata med, kan du alltid kontakta din vårdcentral, elevhälsan eller oss på Next Act för att få stöd. Du kan också alltid ringa 1177 för rådgivning, eller vända dig till en psykiatrisk akutmottagning."}]'::jsonb,
    'published'
  ) RETURNING id INTO les_174_id;

  -- Lesson: Psykologin bakom prestation (section 175)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod1_id,
    'Psykologin bakom prestation',
    0,
    'text',
    '[{"type": "video", "title": "Modul 1", "videoId": "455422409"}, {"type": "text", "title": "Veckans träningsprogram", "content": "I början av varje modul kommer du få några uppgifter eller övningar som du ska göra under veckan som kommer, \"Veckans träningsprogram\". Poängen med dessa är att du ska få möjlighet att öva på de färdigheter och beteenden du läst om och gjort uppgifter kring i den pågående modulen. Du kan göra övningarna under dina vanliga träningspass, under tävlingar eller matcher och vid andra tillfällen under veckan som kommer. Kom ihåg att ju mer du övar, desto mer kommer du få ut av programmet. Lycka till och kör hårt!"}, {"type": "text", "title": "Fokus under träningspass", "content": "1. Fokus under träningspass\n\nÖva på att uppmärksamma var du har ditt fokus under ett träningspass. När är du fokuserad på utförandet och när tänker du på annat?"}]'::jsonb,
    'published'
  ) RETURNING id INTO les_175_id;

  -- Lesson: Vad har psykologi med idrott att göra? (section 176)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod1_id,
    'Vad har psykologi med idrott att göra?',
    1,
    'text',
    '[{"type": "video", "title": "Anders välkomnar och berättar", "videoId": "455700750"}, {"type": "exercise_text", "prompt": "Tänk dig in i ett avgörande läge där du vill prestera. Hur tänker du och vad gör du? Har du några knep du brukar du använda dig av?", "placeholder": "Skriv ditt svar här..."}, {"type": "exercise_text", "prompt": "Vad har din coach sagt att du ska göra?", "placeholder": "Skriv ditt svar här..."}, {"type": "exercise_text", "prompt": "Hur brukar det fungera?", "placeholder": "Skriv ditt svar här..."}, {"type": "text", "title": "Vad har psykologi med idrott att göra?", "content": "I ditt indrottsliv kanske du redan stött på några av dessa påståenden och uppmaningar?\n\nTänk inte så mycket!  Sätt huvudet under armen och bara ut och kötta! Tänk 0-0! Strunta i allt och bara gör! Glöm allt vi gjort på träningen, bara släpp allt och kör! Tänk att det är som vilken match som helst! Det är mycket psykologi i idrott, mycket hänger på det mentala! Det är nu det verkligen gäller! Fokusera nu! Tänk positivt! Du måste ha bättre självförtroende! Tänk dig att du vinner allt!\n\nJa, det är mycket psykologi i idrott.\n\nMen hur fungerar psykologin? Vad kan du påverka, och på vilket sätt kan du påverka det? Vad ska du göra för att inte tänka så mycket?\n\nIdrottspsykologi är väldigt komplext och väldigt enkelt på en och samma gång. Det gäller att göra det du tränar för både när du tränar och när det verkligen gäller, t.ex. i ett tävlingssammanhang. Samma sak men väldigt annorlunda."}, {"type": "text", "title": "Från kontroll till acceptans ", "content": "De senaste tio åren har det hänt väldigt mycket inom idrottspsykologin. De gamla ”sanningarna” om hur man optimerar prestation har reviderats i grunden. Tidigare handlade idrottspsykologi om att kontrollera tankar, känslor och nervositet. Idrottare skulle lära sig att reglera sin anspänning och nervositet med hjälp av tekniker och avslappning och att ersätta negativa tankar med positiva genom positivt “self talk” och genom att “tänka sig till seger” - något vi senare kommer visa kan vara väldigt svårt.\n\nModern idrottspsykologi handlar istället om att acceptera känslor, tankar och nervositet och ta dem med sig mot sitt mål, snarare än att tänka rätt, ha kontroll eller uppnå en viss perfekt anspänning.\n\nVi har alltså gått från ett kontrollerande till ett accepterande förhållningssätt - så vi kan låta fjärilarna i magen lyfta oss mot högre höjder."}, {"type": "text", "title": "Prestation sitter i utförandet", "content": "Vi vet att vi har tankar, känslor och beteenden och att dessa påverkar varandra. Under programmets gång kommer detta bli tydligt och enkelt för dig att förstå. Tankar kan inte förflytta berg eller ta dig till en OS-medalj, men viljan, drivet och envisheten i utförandet kan göra det. Det är i utförandet som prestationen sitter.\n\nFokus i det här programmet kommer alltså att ligga på utförandet. Att du ska få möjligheten att verkligen våga göra det du vill, att du ska få ut så mycket som möjligt av alla dina träningstimmar. Att du inte ska hindras av tankar, idéer eller principer som säger att du inte får, kan eller ska göra det."}]'::jsonb,
    'published'
  ) RETURNING id INTO les_176_id;

  -- Lesson: Introduktion till din mentala tuffhetsmodell (section 177)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod1_id,
    'Introduktion till din mentala tuffhetsmodell',
    2,
    'text',
    '[{"type": "text", "title": "Den mentala tuffhetsmodellen", "content": "I filmen du just såg beskrev Anders den mentala tuffhetsmodellen som en central del av det här programmet. Under de kommande sex modulerna kommer du arbeta fokuserat med den för att bygga din egen mentala tuffhetsmodell steg för steg. \n\nSyftet med din egen personliga tuffhetsmodell är att du ska bli mentalt starkare i situationer där du stöter på svårigheter eller utmaningar."}, {"type": "text", "title": "Mental tuffhet definieras som:", "content": "Vår förmåga att agera meningsfullt, systematiskt och noggrant mot vår värderade riktning, särskilt när vi som idrottare upplever känslor och tankar som vi helst vill undvika, kontrollera eller reducera."}, {"type": "text", "title": "Intro till första modellen.", "content": "Här nedan ser du den mentala tuffhetmodellen som du alltså kommer anpassa, steg för steg, för just dig. \n\nKlicka gärna runt i modellen för att bekanta dig med den. I det här exemplet har vi en fotbollsspelare som spelar en match. Hon begränsas mentalt av att hon känner efter för mycket och därmed inte får ut sin fulla potential."}, {"type": "callout", "variant": "insight", "content": "Mental tuffhetsmodell: Mental Tuffhet"}, {"type": "text", "title": "Efter första modell", "content": "Såhär kommer du att arbeta dig igenom din egen modell: \n\nModul 2: Du definierar din värderade riktning, d.v.s. det du brinner för inom din idrott. Din glöd i bröstet! \n\nModul 3: Du beskriver och definierar just dina hinder och de mentala utmaningar som du brottas med i din satsning. \n\nModul 4:  Du analyserar fram vad du gör när du stöter på dina hinder \n\nModul 5: Du definierar nyckelbeteenden, som hjälper dig att utmana och ta dig an dina mentala svårigheter. \n\nMed hjälp av dessa steg kommer du öva på din förmåga att hantera och bemästra utmanande situationer. Du kommer alltså att skärpa din mentala tuffhet!"}, {"type": "text", "title": "Fullt fokus!", "content": "Förmågan att fokusera är en central del i all prestation. Att vara närvarande och fokuserad på det du gör just nu. Förmågan att fokusera är också central när det gäller att bli mentalt tuff. Att kunna fokusera och samtidigt förstå vilka hinder som dyker upp och hur de påverkar ditt utförande är en viktig del i det här programmet och vi kommer återkomma till detta i flera moduler.\n\nDu kommer under programmets gång göra många övningar för att öva upp din förmåga att fokusera. Här kommer den första!"}, {"type": "callout", "variant": "tip", "content": "Ljudövning: Övning - Tio andetag"}]'::jsonb,
    'published'
  ) RETURNING id INTO les_177_id;

  -- Lesson: Kartläggning: Dina förutsättningar för att prestera (section 179)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod1_id,
    'Kartläggning: Dina förutsättningar för att prestera',
    3,
    'exercise',
    '[{"type": "text", "title": "Dina förutsättningar för att prestera", "content": "Nu ska du få kartlägga din idrott och ditt idrottande. Syftet är att du ska få en bra bild över var du är, vad du vill uppnå, vilka hinder du ser för din utveckling och vilka förutsättningar du har för att uppnå dina mål. Det här är grunden i all prestationsutveckling och något alla idrottare skulle vinna på att göra vid varje säsongavslut och säsongstart."}, {"type": "exercise_text", "prompt": "Vad har du för kortsiktiga mål? Tänk dig en månad fram ungefär", "placeholder": "Skriv ditt svar här..."}, {"type": "exercise_text", "prompt": "Vilka är dina långsiktiga resultatmål? Tänk dig ungefär 3 år fram i tiden, vart befinner du dig?", "placeholder": "Skriv ditt svar här..."}, {"type": "exercise_text", "prompt": "Är dina målsättningar realistiska?", "placeholder": "Skriv ditt svar här..."}, {"type": "exercise_text", "prompt": "Vad kan du förändra dina beteenden och vanor för att nå dit?", "placeholder": "Skriv ditt svar här..."}, {"type": "exercise_text", "prompt": "Ger du dig själv rätt förutsättningar för att nå dina mål?", "placeholder": "Skriv ditt svar här..."}, {"type": "exercise_text", "prompt": "Vilka hinder finns på vägen mot dina målsättningar?", "placeholder": "Skriv ditt svar här..."}, {"type": "exercise_text", "prompt": "I vilka delar av din satsning ser du störst utvecklingspotential (t.ex. teknik, fysik, mentalt, materiellt etc)?", "placeholder": "Skriv ditt svar här..."}, {"type": "exercise_text", "prompt": "Vilka förutsättningar kan du själv påverka för att förbättra möjligheten att nå dina mål? Exempelvis, kost, sömn, goda vanor? Förklara gärna.", "placeholder": "Skriv ditt svar här..."}, {"type": "exercise_text", "prompt": "Vad gör de bästa?", "placeholder": "Skriv ditt svar här..."}, {"type": "exercise_text", "prompt": "Om du jämför dina vanor och beteenden mot någon du ser upp till, hur skiljer de sig?.", "placeholder": "Skriv ditt svar här..."}, {"type": "text", "title": "Nu har du kommit igång!", "content": "Nu har du gjort en första grundläggande analys av din träning och du har också fått bekanta dig med teorierna bakom programmet, där fokus ligger på utförandet. Du har också gjort en första fokusövning, något du kommer göra många fler av under programmets gång.\n\nI nästa modul ligger fokus på dina drivkrafter och din värderade riktning.  \n\nGenom hela programmet gäller principen att nästa modul blir tillgänglig för dig när du gjort klart allt i den föregående modulen. För bästa resultat, för att du ska få ut så mycket som möjligt av  träningsprogrammet, så rekommenderar vi att du arbetar med varje modul i ungefär en vecka – och att du särskilt fokuserar på att göra \"Veckans träningsprogram\" för varje modul så noggrant som möjligt."}]'::jsonb,
    'published'
  ) RETURNING id INTO les_179_id;

  -- Lesson: Din värderade riktning (section 180)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod2_id,
    'Din värderade riktning',
    0,
    'text',
    '[{"type": "video", "title": "Modul 2", "videoId": "1097559806"}, {"type": "text", "title": "Fokus UNDER träning", "content": "1. Fokus UNDER träning\n\nUppmärksamma var ditt fokus är vid minst ett tillfälle under varje träningspass den här veckan. Är du helt engagerad i din idrott? Totalt där? Eller tänker du på att du skulle kunna gjort något bättre, att du borde gjort något annorlunda eller att du är dålig eller värdelös?"}]'::jsonb,
    'published'
  ) RETURNING id INTO les_180_id;

  -- Lesson: Värderad riktning - det som driver oss (section 181)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod2_id,
    'Värderad riktning - det som driver oss',
    1,
    'text',
    '[{"type": "video", "title": "Anders förklarar värderad riktning", "videoId": "1097563492"}, {"type": "text", "title": "Fotbollsspelaren och kärleken till bollen", "content": "Det är en grå och regnig eftermiddag, och han känner sig tung i benen efter gårdagens löpträning. Skoldagen har varit lång och tröttsam, och nu väntar ännu ett träningspass. Tankarna börjar snurr: \"Varför gör jag det här egentligen?\"\n\nHan tar sig\nändå ut till planen, med bollväskan över axeln och regnet droppande på jackan.\nFörsta minuterna känns sega, och varje rörelse är kantig och stel. Men efter\nett tag börjar kroppen svara. När han driver bollen förbi en rad koner, känner\nhan plötsligt en välbekant känsla – den där friheten som bara bollen kan ge\nhonom.\n\nHan kommer\npå sig själv med ett leende när han sätter ett perfekt avslut i krysset. Det är\nsom om bollen och foten kommunicerar direkt, utan att han ens behöver tänka.\nHan minns varför han älskar det här – inte för att vinna matcher eller bevisa\nnågot för andra, utan för känslan av att spelet är hans egen plats i världen. \n\nRegnet känns inte längre lika kallt, och han tar en löpning till, bara för att\nhan vill."}, {"type": "text", "title": "Värderad riktning ger bättre prestationsförmåga", "content": "Forskning visar att idrottare som\nhar koll på sin värderade riktning och fokuserar på den drivkraften kommer att\nträna och öva mer. Det visar sig också att de som fokuserar på det som driver\ndem gör bättre val i situationer där de stöter på svårigheter. Fotbollsspelaren\ni exemplet ovan får kämpa lite där på morgonen för att efter ett tag komma in i\nlöpandet och känslan av den där glöden i bröstet.\n\nVanliga exempel på olika\nfotbollsspelares värderade riktning:\n\n • \"Jag spelar för att jag älskar känslan av\n     att kämpa för laget och göra skillnad på planen.\"\n\n • \"Fotbollen ger mig en känsla av glädje och\n     gemenskap som jag inte hittar någon annanstans.\"\n\n • \"Jag brinner för att utvecklas och nå min\n     fulla potential som spelare.\"\n\n • \"Att känna stödet från mina lagkamrater och\n     veta att vi jobbar mot samma mål är det som motiverar mig.\"\n\n • \"Fotbollen är mitt sätt att uttrycka mig\n     själv och känna frihet.\""}, {"type": "text", "title": "En introduktion till den mentala tuffhetsmodellen", "content": "Din värderade riktning är det som\nkommer ta dig hela vägen. Men det är inte alltid som allt stämmer eller allt\ngår som man vill. Det kan dyka upp hinder i form av dåliga coacher, skador,\nkonkurrenter som utvecklas snabbare, eller tävlingar som inte går som du tänkt\ndig. Sedan kan dina egna tankar, rädslor och känslor också utgöra hinder. T.ex.\ntankar på att du inte kommer orka eller att du inte är tillräckligt stark,\neller de tankar som kommer efter att motståndarna har gjort ledningsmålet.\n\nDen här typen av hinder återkommer\nvi till senare i programmet."}]'::jsonb,
    'published'
  ) RETURNING id INTO les_181_id;

  -- Lesson: Hitta din värderade riktning (section 182)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod2_id,
    'Hitta din värderade riktning',
    2,
    'exercise',
    '[{"type": "text", "title": "Definiera din värderade riktning", "content": "Du ska nu ta reda på din värderade riktning. Vad det är som driver dig, varför du gör det du gör och vad det är just du vill ha ut av ditt idrottande.\n\nNär du definierar dina värden, tänk bort resultat och målsättning. Du kanske vill bli bäst i världen, men det är resan dit som är det viktiga. Hur vill du att den ska se ut?\n\nFör att göra det enklare kan du jämföra med att gifta sig eller få barn, vilket är ett livsmål för många. Det som i det exemplet är viktigt i längden och som säger mer om ens värderade riktning är hur man vill vara som partner eller förälder, inte bara att att man vill gifta sig eller ha barn."}, {"type": "text", "title": "Mål eller värderad riktning?", "content": "Ett mål är något konkret som du kan uppnå och bocka av – som att vinna en viss match eller göra 10 mål på en säsong. En värderad riktning är ditt \"varför\" – den inre drivkraft som gör att du älskar att spela fotboll.\n\nDin värderade riktning kan vara att du spelar fotboll för att du älskar känslan av att utvecklas, att tävla, att vara en del av ett lag eller för att du vill se hur bra du kan bli. Den handlar inte om resultat – den handlar om vad som verkligen betyder något för dig i din idrott.\n\nOm du bara fokuserar på mål kan motivationen svikta när du når dem – eller om du inte gör det. Men när du spelar med din värderade riktning i ryggen har du alltid en tydlig kompass, oavsett resultat."}, {"type": "text", "title": "Outro mål eller värdering", "content": "Det är alltså resan i enlighet med dina värden som är själva målet och som kommer ta dig hela vägen.\n\nEtt annat sätt att se på värden är att likna dem vid en kompass. Om du vet att du ska västerut så är det dit du hela tiden måste sträva. Öar och stormar kommer försöka få dig ur kurs men om du vet att du ska västerut så är det dit du ska sträva. Mål är det du vill uppnå under resans gång. En ö du vill besöka, ett berg att bestiga eller ett stort mästerskap på din fortsatta resa västerut."}, {"type": "text", "title": "Definiera din värderade riktning - intro", "content": "Nu är det din tur att definiera din värderade riktning. Att hitta exakt vad det är som glöder i ditt bröst."}, {"type": "text", "title": "Övning: Din avslutningsfest", "content": "Tänk dig att du precis avslutat din fotbollskarriär. Du anordnar en fest där din familj och vänner är närvarande. Även flera av dina gamla lagkamrater och tränare är på plats. Många håller tal. Tre av talen är från vänner du känner från din fotbollskarriär. De pratar om vad du betytt för dem, hur du var att möta och hur det var att tävla sida vid sida med dig. Den sista talaren är en inflytelserik tränare inom din idrott."}, {"type": "exercise_text", "prompt": "I en värld där du alltid varit ditt bästa, vad skulle du få höra?", "placeholder": "Skriv ditt svar här..."}, {"type": "text", "title": "Intro definiera din värderade riktning", "content": "Du kan få fler ledtrådar till vad det är du värderar med din idrott genom att besvara följande frågor:"}, {"type": "exercise_text", "prompt": "Påminn dig om hur det var första gången du utövade din idrott. Vad upplevde och kände du då? Vad var det som fick dig att gå tillbaka till träningslokalen?", "placeholder": "Skriv ditt svar här..."}, {"type": "exercise_text", "prompt": "Tänk dig tillbaka till ett ögonblick där allt stämde och du var ett med ditt utövande och verkligen var \"i zonen\". Vad kände och upplevde du då?", "placeholder": "Skriv ditt svar här..."}, {"type": "exercise_text", "prompt": "Analysera ett par träningar under veckan som gått. När kändes det kul? Vad var det som var kul? Pirrade det till i bröstet lite extra någon gång och hur kändes det?", "placeholder": "Skriv ditt svar här..."}]'::jsonb,
    'published'
  ) RETURNING id INTO les_182_id;

  -- Lesson: Sammanfatta din värderade riktning (section 183)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod2_id,
    'Sammanfatta din värderade riktning',
    3,
    'exercise',
    '[{"type": "text", "title": "Sammanfatta din värderade riktning", "content": "Här är svaren på de frågor du just svarade på - de ger dig ledtrådar till din värderade riktning. Dina svar kommer sannolikt förändras lite i takt med att du blir äldre, får fler erfarenheter och kanske upptäcker andra tjusningar med din sport. Det kan alltså vara\n    bra att ibland återkomma till dessa frågor fler gånger under din idrottskarriär.\n\n    • [[firsttime]]\n\n    • [[everythingworks]]\n\n    • [[trainingfun]]"}, {"type": "exercise_text", "prompt": "Sammanfatta din uppdaterade värderade riktning med några korta meningar eller ord.", "placeholder": "Skriv ditt svar här..."}]'::jsonb,
    'published'
  ) RETURNING id INTO les_183_id;

  -- Lesson: Ta-daaaaah - Din värderade riktning! (section 184)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod2_id,
    'Ta-daaaaah - Din värderade riktning!',
    4,
    'text',
    '[{"type": "text", "title": "Ta-daaaaah - Din värderade riktning!", "content": "Nu har du tagit det första steget i att bygga din egen personliga tuffhetsmodell, din värderade riktning är på plats! Ledstjärnan, den inre glöden i ditt bröst, som ska ta dig hela vägen mot dina mål, driva dig till att träna, träna hårdare och ännu hårdare. Den här glöden är du skyldig dig själv att förvalta, försvara\n    och ta på största allvar!"}, {"type": "callout", "variant": "insight", "content": "Mental tuffhetsmodell: Din värderade riktning!"}, {"type": "text", "title": "Jaga efter din inre glöd", "content": "2. Jaga efter din inre glöd\n\nDen här veckan ska du fundera på när det är du upplever din värderade riktning. När känner du att glöden tänds i bröstet? Vid vilka träningspass eller matchsekvenser? Och i vilka situationer kan du känna att glöden svalnar en aning?"}]'::jsonb,
    'published'
  ) RETURNING id INTO les_184_id;

  -- Lesson: Din förmåga att fokusera (section 185)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod2_id,
    'Din förmåga att fokusera',
    5,
    'text',
    '[{"type": "text", "title": "Förmåga att fokusera ", "content": "Parallellt med din mentala tuffhetsmodell kommer du arbeta med din förmåga att fokusera. Förmågan att fokusera är central för all prestation men också viktig för att förstå vad som händer i olika situationer, vilka tankar och känslor som kan dyka upp och vad de kan leda till.\n\nDu kommer under hela programmets gång öva på din förmåga att fokusera.\n\nNu har du tagit det första steget in i din mentala tuffhetsmodell. Du har definierat dina drivkrafter och din värderade riktning, och du har även börjat förstå hur viktigt det är att kunna fokusera och vara närvarande i det som sker här och nu. Innan du börjar med nästa modul är det viktigt att du gör övningarna i modulens träningsprogram under dina träningspass. \n\nVarför är fokusförmåga så avgörande?\n\nFörmågan att fokusera är inte bara grunden för att prestera, den är också nyckeln till att förstå sig själv och kunna välja hur man agerar i pressade situationer. I idrott är det lätt att bli distraherad av yttre faktorer som publik, motståndare eller domslut – men också av inre faktorer som självtvivel, stress eller prestationskrav.\n\nGenom att träna upp din uppmärksamhet stärker du förmågan att märka när du hamnar ur balans. Du blir bättre på att notera vad som pågår – utan att fastna i det – och kan då lättare styra ditt beteende tillbaka till det som är viktigt just där och då.\n\nExempel:Du står inför en avgörande straffsprark. Tankar som \"jag får inte missa\" dyker upp och kroppen känns spänd. Istället för att låta tankarna styra ditt agerande – märker du dem, noterar spänningen, och återför fokuset till din nästa aktion. Du agerar medvetet, inte automatiskt.\n\nAtt fokusera handlar alltså inte om att stänga ute allt – utan om att välja var du lägger din uppmärksamhet och att kunna återvända dit, om och om igen. Det är en färdighet – och precis som andra färdigheter, går den att träna."}, {"type": "text", "title": "Veckans träningsprogram", "content": "1. Fokus UNDER träning\n\nUppmärksamma var ditt fokus är vid minst ett tillfälle under varje träningspass den här veckan. Är du helt engagerad i din idrott? Totalt där? Eller tänker du på att du skulle kunna gjort något bättre, att du borde gjort något annorlunda eller att du är dålig eller värdelös?\n\n2. Jaga efter din inre glöd\n\nDen här veckan ska du fundera på när det är du upplever din värderade riktning. När känner du att glöden tänds i bröstet? Vid vilka träningspass eller matchsekvenser? Och i vilka situationer kan du känna att glöden svalnar en aning?"}]'::jsonb,
    'published'
  ) RETURNING id INTO les_185_id;

  -- Lesson: Definiera dina hinder för prestation (section 186)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod3_id,
    'Definiera dina hinder för prestation',
    0,
    'text',
    '[{"type": "video", "title": "Modul 3", "videoId": "1097569313"}, {"type": "text", "title": "Fortsätt fokusarbetet", "content": "1. Fortsätt fokusarbetet\n\nFörsta övningen i veckans träningsprogram är att vid tre tillfällen under varje träningspass öva på att bibehålla fokus på det du gör, under minst en minut."}]'::jsonb,
    'published'
  ) RETURNING id INTO les_186_id;

  -- Lesson: Såhär funkar vår hjärna (section 187)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod3_id,
    'Såhär funkar vår hjärna',
    1,
    'text',
    '[{"type": "text", "title": "Såhär funkar vår hjärna", "content": "Människans\nhjärna är formad av en miljon års evolution, där vi tillbringade 99,9 % av\ntiden som jägare på savannen. Men de senaste 200 åren har samhället förändrats\nradikalt med industrialisering och modern teknik. Trots det har vår hjärna\nknappt förändrats. Den är fortfarande anpassad för att reagera snabbt på faror\n– vilket är en förklaring till varför vi ofta känner stress och oro även i\nsituationer som inte är livshotande. Hjärnan tror fortfarande att vi är på\nsavannen, i en värld fylld av faror.\n\nVarför\ndetta perspektiv är viktigt:\n\nFör att prestera under press måste vi förstå att hjärnan är byggd för\növerlevnad, inte för dagens stressiga liv och komplexa problem. Genom att veta\ndetta kan vi använda smarta strategier som mindfulness och acceptans för att\nhantera stress bättre och hitta fokus och balans när vi behöver prestera på\ntopp."}, {"type": "video", "title": "Anders förklarar hur hjärnan fungerar", "videoId": "1097572332"}, {"type": "text", "title": "Apan under prestation", "content": "Apan är optimerad för att öka din prestationsförmåga. Samma överlevnadsmekanismer som aktiveras när du jagas av lejon aktiveras när du ska tävla. Den gör dig fokuserad, koncentrerad, taggad och på hugget. Optimerad för att prestera helt enkelt."}]'::jsonb,
    'published'
  ) RETURNING id INTO les_187_id;

  -- Lesson: Hitta din apa (section 188)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod3_id,
    'Hitta din apa',
    2,
    'text',
    '[{"type": "text", "title": "Apan innan matchen", "content": "En ung\nfotbollsspelare ska göra sin debut i ett internationellt mästerskap som junior.\nHon är lovande och har ögonen på sig. Hon brukar bli nervös i matchsituationer\nmen försöker hantera det genom att stänga av nervositeten. Hon försöker tänka\npositiva tankar och säga till sig själv att hon inte ska bli nervös.\n\nI spelartunneln ökar nervositeten. Hon börjar titta på vad de andra spelarna\ngör och lägger märke till att de verkar lugna. Hon känner hur axlarna är spända\noch vet att det inte är bra, men hon försöker ignorera det. Hon försöker också\nandas djupt, men det känns som att luften fastnar i bröstet. Pulsen slår hårt,\noch hon blir orolig att de andra ska märka hur nervös hon är. Apan sätter igång kletiga tankar \"Misslyckas inte, gör inte bort dig.\"\n\nHon försöker se lugn ut och\nintalar sig själv att hon måste slappna av. Men tankarna rusar, andningen blir\nsnabbare och kroppen känns tung. När matchen börjar är pulsen för hög och hon\nhar svårt att prestera."}, {"type": "video", "title": "Anders analyserar fotbollsspelaren", "videoId": "1097577445"}, {"type": "text", "title": "Apan blir rädd för apan", "content": "Apan kan ibland kännas läskig eller hotfull. Som den nervositet du känner inför en ny utmaning när apan gör sig redo. Försöker vi ta bort apan för att minska eller kontrollera den på något sätt, kan apan bli rädd för sig själv. Apan blir rädd för apan och du känner mer nervositet.\n\nLängre fram i programmet kommer du lära dig hur du skall ta hand om apan. Men redan nu kanske du kan se att det är viktigt att ta hand om apan, liksom ta den i handen istället för att kontrollera den.\n\nFörsta steget är att bekanta dig med just din apa, att veta när den dyker upp och vad du brukar göra då."}, {"type": "exercise_text", "prompt": "I vilka situationer brukar din apa dyka upp?", "placeholder": "Skriv ditt svar här..."}, {"type": "exercise_text", "prompt": "Hur brukar det kännas i din kropp när apan gör dig nervös eller stressad?", "placeholder": "Skriv ditt svar här..."}, {"type": "exercise_text", "prompt": "Hur brukar apan påverka ditt agerande? Hur agerar du när apan är aktiv?", "placeholder": "Skriv ditt svar här..."}, {"type": "text", "title": "Din apa under veckan", "content": "2. Din apa under veckan\n\nDen här veckan ska du känna efter hur du upplever din apa under ett träningspass eller en tävling/match. Uppmärksamma hur apan påverkar dig i både i tränings- och tävlingssituationer."}]'::jsonb,
    'published'
  ) RETURNING id INTO les_188_id;

  -- Lesson: Tankar, tankar och fler tankar (section 189)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod3_id,
    'Tankar, tankar och fler tankar',
    3,
    'text',
    '[{"type": "text", "title": "Tankar, tankar och fler tankar - intro", "content": "Vi tänker hela tiden. Vi registrerar, planerar, strukturerar, fantiserar och dagdrömmer. Vår hjärna stannar aldrig upp. En hel del passerar bara men det finns många tankar som handlar om att upptäcka faror och orosmoment. Saker som är fel eller kan gå fel."}, {"type": "text", "title": "Fotbollsspelaren med matchen på sina axlar", "content": "En fotbollsspelare spelar en av\nsina bästa matcher. Som central mittfältare har han tagit ansvar, fördelat\nbollen och styrt spelet. Han har inte tänkt så mycket, bara varit där,\nnärvarande i varje moment. Matchen är viktig, men han känner sig som en del av\nlaget. De anfaller och försvarar tillsammans, och han känner glädjen i att\nspela.\n\nMatchen är jämn, men i slutminuterna får hans lag en straff som kan avgöra allt. Plötsligt hänger allt på honom. Han börjar tänka att det är nu det gäller, och att han måste sätta den. Han sneglar mot tränaren på sidlinjen och känner hur pressen växer. Tankarna börjar rusa: \"Bara jag inte missar, bara jag inte gör bort mig, bara jag inte sviker laget.\"\n\nHan börjar tveka på vart han ska placera straffen. Ska han slå högt eller lågt, till vänster eller höger? Han tänker på tidigare straffar han missat och hur lagkamraterna då blivit besvikna på honom. Ju mer han tänker, desto längre bort känns det han brukar drivas av – att spela för laget. Det är som att det bara är han, bollen och de kletiga tankarna."}, {"type": "video", "title": "Anders analyserar Fotbollsspelaren - Tankar", "videoId": "1097582005"}, {"type": "text", "title": "Efter film och innan modell", "content": "Här ser du analysen från filmen med hjälp av den mentala tuffhetsmodellen."}, {"type": "callout", "variant": "insight", "content": "Mental tuffhetsmodell: Fotbollsspelarens mentala tuffhetsmodell"}, {"type": "text", "title": "Kletiga tankar", "content": "Vissa tankar är kletiga. De liksom fastnar på ett helt annat sätt än andra. De kan till och med ta över hela ens beteende så man börjar agera enligt sina tankar. Föreställ dig tanken “Usch vad tidigt det är, jag kommer att dö om jag går upp nu” och reaktionerna den medför. Sannolikt inte så mycket. Du konstaterar bara att det är tidigt, att du är trött och går sedan upp och lagar frukost. Föreställ dig sedan tankarna ”tänk om jag gör fel”, “tänk om jag gör tränaren besviken”, “tänk om jag ramlar”, “tänk om jag gör bort mig”, “det måste bli perfekt”, “jag är lat” eller “jag är värdelös”. Visst är dessa tankar svårare att distansera sig ifrån? Det är som att de kletar sig fast vid en. Att man krokas fast i och uppslukas av dem. Sådana här tankar kan medföra stora hinder när det gäller att leva eller prestera som man vill."}, {"type": "text", "title": "Kletiga tankar forts", "content": "Kletiga\ntankar påverkar hur vi agerar.  Vi börjar ofta bete oss som våra kletiga\ntankarna säger att vi ska bete oss. \n\nTa\nsom exempel en fotbollsspelare som just missat en passning och efter det tänker\natt han är värdelös. Han börjar då agera som att han är värdelös, t.ex. gömmer\nsig i passningsskugga, hänger med huvudet och slutar att vifta efter bollen.\nAllt för att slippa få bollen igen. Beteendet blir funktionellt eller anpassat\ntill det han tänker på kort sikt, men inte utifrån det han egentligen vill göra\npå fotbollsplanen. Mer om detta i nästa modul.\n\nVanliga\nkletiga tankar som idrottare brottas med är:\n\n • Du är egentligen värdelös.\n\n • Fasen vad dålig du var i den matchsekvensen.\n\n • Allt måste vara perfekt.\n\n • Det får inte bli fel.\n\n • Du är egentligen lat.\n\n • Du borde gjort ifrån dig mycket bättre.\n\nNär allt\ndäremot fungerar och du presterar och agerar som du vill brukar det inte vara\nså mycket tankar involverade. Du bara gör. Kom ihåg hur snabb motorcortex\när.  Oftast tänker du mer när det inte går så bra. När du underpresterar."}, {"type": "text", "title": "Kletiga tankar", "content": "3. Kletiga tankar\n\nFundera över vilka tankar som dyker upp i ditt huvud och i vilka sammanhang de dyker upp under veckan som kommer. Notera också vilka tankar som dyker upp under dina träningspass."}]'::jsonb,
    'published'
  ) RETURNING id INTO les_189_id;

  -- Lesson: Vilka kletiga tankar har du? (section 190)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod3_id,
    'Vilka kletiga tankar har du?',
    4,
    'exercise',
    '[{"type": "text", "title": "Definiera dina hinder - intro", "content": "Nu är det dags att förbereda nästa steg i bygget av din personliga tuffhetsmodell. Vi börjar med några övningar, sedan kommer du få beskriva vilka tankar som kan utgöra hinder för dig i ditt idrottsutövande."}, {"type": "text", "title": "Övning: Dina tankar och apa dansar bra tillsammans", "content": "• Slut ögonen och tänk dig tillbaka till den bästa tävling eller match du någonsin genomfört.\n\n        • Tänk på hur du var där, hur du utförde rörelserna och hur prestationen blev exakt så som du tänkt dig.\n\n        • Tänk dig att du är tillbaka i den situationen. Njut av att vara där igen.\n\n    \n\nHur kändes det i kroppen? Kände du hur hela din kropp påverkades av att tänka på den situationen och hur det var då?\n\n    \n\n        • Tänk nu tillbaka på en match eller tävling som inte funkade alls. Hur jobbigt det var och hur det du gjorde inte alls blev som du tänkt dig.\n\n    \n\nHur kändes det?"}, {"type": "text", "title": "Dina tankar och apa dansar - outro", "content": "Så bara genom att tänka på olika prestationer i vårt förflutna går apan och apans kroppsliga symptom igång. Tankar och apan påverkar varandra och kan ha stor inverkan på hur vi genomför en prestation.\n\nVisst hade det varit bra om vi kunde stänga av det där tankemaskineriet - eller åtminstone bara ha kvar de positiva tankarna? Ska vi göra ett försök?\n\nJag vill att du nu sitter stilla i 30 sekunder. Det enda du inte får göra är att tänka på en rosa elefant. Vad som helst, förutom just en rosa elefant. Starta nu!"}, {"type": "text", "title": "`Rosa elefanten - outro", "content": "Troligen märker du att när du försöker tänka på något annat så kommer den rosa elefanten ändå. Det beror på att din hjärna vet att du försöker att inte tänka på den rosa elefanten när du försöker tänka på annat.\n\nHjärnan har svårt för att inte tänka på det du inte vill. Paradoxalt ökar det vår tendens att fokusera på det vi inte vill fokusera på. Om du till exempel försöker fokusera på att somna när du inte kan sova, så  brukar det istället resultera i sömnlöshet.\n\nAtt i ett idrottssammanhang fokusera på att inte göra misstag eller inte göra fel leder även det till fel fokus. Till exempel, om du spelar tennis och vid breakbollen efter en missad förstaserve tänker \"vad du än gör, gör inget dubbelfel\"... vad tror du händer då?"}, {"type": "text", "title": "Intro hitta dina kletiga tankar", "content": "Du ska nu ta reda på vilka kletiga tankar du har och hur de låter. I prestationssammanhang brukar de dyka upp när du ska ta dig an utmaningar eller när det inte går riktigt som du tänkt dig. När du underpresterar."}, {"type": "exercise_text", "prompt": "l vilka situationer brukar det inte gå som du tänkt dig, d.v.s. när underpresterar du?", "placeholder": "Skriv ditt svar här..."}, {"type": "exercise_text", "prompt": "Vilka tankar brukar du brottas med när det inte går som du tänkt dig?", "placeholder": "Skriv ditt svar här..."}, {"type": "exercise_text", "prompt": "Vilka är dina mest jobbiga tankar?", "placeholder": "Skriv ditt svar här..."}, {"type": "text", "title": "Dina vanligaste hinder - outro", "content": "Nu har du förhoppningsvis koll på hur dina kletiga tankar låter och hur de kan utgöra hinder när du ska prestera. De kletiga tankarna kan nästan upplevas som automatiska och ibland kan de vara så inkletade att du uppfattar dem som en del av dig själv. Att tankarna är du. Principer kan vara ett exempel på tankar som är fastkletade. \n\nDet kan ta lite tid att upptäcka kletiga tankar, när de kommer och hur de påverkar ditt utförande. I takt med att du blir bättre på att fokusera kommer du förhoppningsvis upptäcka fler situationer där de dyker upp."}]'::jsonb,
    'published'
  ) RETURNING id INTO les_190_id;

  -- Lesson: Strategier för att hantera kletiga tankar (section 191)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod3_id,
    'Strategier för att hantera kletiga tankar',
    5,
    'text',
    '[{"type": "video", "title": "Henrik fördjupar tankar", "videoId": "1097585782"}, {"type": "text", "title": "Ta bort kletet - låt tankarna vara där men lyssna inte så noga", "content": "I filmen beskriver Henrik vad \"paralysis by analysis\" innebär, och att när vi övertänker så försämras vår prestation istället för att vi bara gör. \n\nMen som du vet är det svårt att bara stänga av tankar. En bättre metod är att försöka få bort kletet runt tanken så att tanken inte påverkar prestationen så mycket."}, {"type": "text", "title": "Kletiga tankar 3-4", "content": "En viktig komponent i att ta bort klet är att släppa tankar och låta dem vara just det de är - tankar. \n\nAtt inte ge kletiga tankar bränsle genom att agera som om de är sanna. Nästa övning handlar om att försöka acceptera att tankarna är där och släppa dem. Även de kletiga."}, {"type": "text", "title": "Övning: Släppa tankar", "content": "• Tänk dig att du står och tittar på en parad. I paraden kommer olika människor med plakat och festliga bilar. Förbi passerar massor av människor, intryck och budskap. Vissa inslag i paraden är roliga, andra är mindre roliga och vissa är bara tråkiga. Du står där och tittar. \n• Plötsligt är det som att en del av paraden fångar ditt intresse mer än något annat. Du liksom slutar titta på resten av paraden. Följer den delen av paraden intensivt. Du bökar dig fram mellan alla åhörare och följer bara den delen. Allt annat försvinner och du ser inget annat av paraden. \n• Tänk dig nu att det är dina tankar som kommer i paraden. Massor av olika tankar med olika innehåll i en strid ström. Men plötsligt kommer ett plakat där det står ”Jag är lat. Jag får inte misslyckas nu”.  Med ens är det som att du kletar dig fast i den och du tappar intrycken från allt annat som sker runt om dig. Du blir genast inkletad i tanken. Du följer med den. Du blir den. Tricket för att bli mindre inkletad i tankarna är att kunna släppa taget om dem - låta dem vara där och låta dem passera."}, {"type": "text", "title": "Ett accepterande och tillåtande förhållningssätt", "content": "Tankar är tankar och utförande är utförande. Tankar och utförande behöver inte vara ihopkletade med varandra. Genom att acceptera och tillåta de där kletiga tankarna att komma, utan att behöva se dem som ett hot, har du möjlighet att göra det du ska göra. \n\nDu skapar små kilar mellan situationer som uppstår, kletiga tankar som kommer och ditt agerande. Kilar som ger dig marginaler för att välja tt göra.\n\nFokusövningar är nycklar till att bli bra på att upptäcka klet. Så fortsätt med dem!"}]'::jsonb,
    'published'
  ) RETURNING id INTO les_191_id;

  -- Lesson: Sammanfatta dina hinder (section 192)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod3_id,
    'Sammanfatta dina hinder',
    6,
    'exercise',
    '[{"type": "text", "title": "Apan och tankar", "content": "En idrottares väg mot den optimala prestationen är kantad av hinder och svårigheter att övervinna. Mentala hinder brukar oftast bestå av kletiga tankar och situationer där apan blir för uppretad. \n\nHur du agerar när apan och hinder dyker upp kan vara problematiskt. Detta kommer vi titta på i nästa modul."}, {"type": "exercise_text", "prompt": "Beskriv med några korta meningar eller ord vilka dina vanligaste hinder är nu (både i form av apan och kletiga tankar).", "placeholder": "Skriv ditt svar här..."}]'::jsonb,
    'published'
  ) RETURNING id INTO les_192_id;

  -- Lesson: Din uppdaterade tuffhetsmodell (section 193)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod3_id,
    'Din uppdaterade tuffhetsmodell',
    7,
    'text',
    '[{"type": "callout", "variant": "insight", "content": "Mental tuffhetsmodell: Din uppdaterade tuffhetsmodell"}]'::jsonb,
    'published'
  ) RETURNING id INTO les_193_id;

  -- Lesson: Analysera dina tränings- och tävlingsbeteenden (section 194)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod4_id,
    'Analysera dina tränings- och tävlingsbeteenden',
    0,
    'video',
    '[{"type": "video", "title": "Modul 4 - Intro", "videoId": "1097598224"}]'::jsonb,
    'published'
  ) RETURNING id INTO les_194_id;

  -- Lesson: Analys genom 5 steg (section 195)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod4_id,
    'Analys genom 5 steg',
    1,
    'text',
    '[{"type": "text", "title": "Intro", "content": "Du börjar du bli bekant med din mentala tuffhetsmodell. Du kan bli ännu vassare på att analysera din prestation. När du förstår vad du gör, och varför du gör som du gör, kan du bli mentalt starkare. Analysen och förståelsen är grunden till att agera och prestera bättre. \n\nTvå situationer som är särskilt viktiga i fotboll för att bli mentalt tuff är:\n\n• Vad du gör efter misstag eller vid motgång\n• Hur du gör din lagkompis bättre\n\nDessa situationer ska vi göra en plan för nu."}, {"type": "text", "title": "Mental tuffhet", "content": "Du börjar du bli bekant med din mentala tuffhetsmodell. Du kan bli ännu vassare på att analysera din prestation. När du förstår vad du gör, och varför du gör som du gör, kan du bli mentalt starkare. Analysen och förståelsen är grunden till att agera och prestera bättre. \n\nMental tuffhet är möjligheten att göra det du vill göra i enlighet med din värderingar och mål, även om och speciellt om du upplever situationer, tankar eller känslor som du i enlighet med den mänskliga naturen vill undvika, ta bort eller reducera och skapar agerande i motsatt riktning. \n\nDen mentala tuffhetsmodellen använder du för att analysera din prestation genom fem steg. De första två är du bekant med:\n\n• Din värderade riktning\n• Definiera hinder. Svåra situationer där kletiga tankar uppstår. \n\nI den här modulen skall vi fortsätta fokusera på vad du gör vid mentalt svåra situationer som när du tappar bollen, när du känner dig trött eller när motståndaren precis har gjort mål."}, {"type": "text", "title": "Tuffhetsmodellen 5 steg", "content": "Den mentala tuffhetsmodellen använder du för att analysera din prestation genom dessa fem steg:\n\nDet är i det sista steget, där du beskriver beteenden som du gör för mycket och för lite av, som det börjar bli riktigt intressant. Det är där du får en klar bild av det du måste göra mindre av och det du måste göra mer av."}]'::jsonb,
    'published'
  ) RETURNING id INTO les_195_id;

  -- Lesson: Vad gör du vid misstag? (section 196)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod4_id,
    'Vad gör du vid misstag?',
    2,
    'text',
    '[{"type": "video", "title": "Apan och kletiga tankar", "videoId": "1100640318"}, {"type": "text", "title": "Situation - Apan - Aktion ", "content": "Det är lätt att göra som Apan eller\nkletiga tankar säger när de skriker i ens huvud. Kan du känna igen dig i några\nav följande situationer?"}, {"type": "text", "title": "Förklaring bild", "content": "Att agera som apan och tankar säger\när naturligt. För när vi gör som dem säger tystnar dem kortvarigt. Det är skönt\natt vara i passningsskugga och slippa ha bollen ett tag. Det är tacksamt att\nskylla på orken och inte ta löpningen. Och ibland är det väldigt skönt att\nskrika på sina medspelare. \n\nMen något väldigt viktigt händer\nsamtidigt som vi gör det som Apan och tankarna säger: Vi tappar\nvår värderade riktning, vårt varför, vår meningsfullhet och\nvår drivkraft."}]'::jsonb,
    'published'
  ) RETURNING id INTO les_196_id;

  -- Lesson: Läktaraktioner (section 197)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod4_id,
    'Läktaraktioner',
    3,
    'exercise',
    '[{"type": "text", "title": "Läktaraktioner ", "content": "Att göra som apan och kletiga tankarna säger i knepiga situationer kallar vi för läktaragerande. Eller läktaraktioner. \n\nDet kan vara skönt uppe på läktaren. Dels för att apan och tankarna lugnar sig lite. Och dels för att du inte riskerar något där uppe. OM du till exempel missat en passning och gömmer dig i passningsskugga i sekvenserna efteråt kan det vara ganska skönt. Du liksom slipper att ta tag i det jobbiga. \n\nEller efter att du tappat en boll, bli förbannad på sig själv, kanske skrika högt, hänga med huvudet och gestikulera mot domaren eller medspelarna är aktioner som kan vara sköna att utföra.\n\nProblemet med läktaraktioner är att de sällan gör dig till en bättre spelare. Snarare tvärtom. Men inte bara det, den där värderade riktningen kan minska. Alltså om du egentligen vill vara en spelare som ger allt men blir passivt stående i passningsskugga kommer det inte att kännas bra på längre sikt. \n\nDet är kortsiktigt skönt på läktaren men ganska snabbt blir det fel."}, {"type": "text", "title": "Skönt på läktaren? ", "content": "Det kan vara\nganska skönt att kliva upp på den där läktaren ibland. När vi undviker saker\nslipper vi kortsiktigt obehag. Fotbollsspelaren undviker att testa tanken om\natt han inte är tillräckligt bra. På samma sätt som det kan kännas skönt att inte ta\nden där extra löpningen när benen är tunga, eller att inte våga skjuta när du\nhar chansen, för att du är rädd att missa.\n\nVi människor\när generellt bra på att hitta kortsiktiga lösningar som hjälper oss att undvika\nobehag, även om de inte leder oss dit vi egentligen vill. Vi gör det mesta för\natt slippa känna oss osäkra, rädda eller ifrågasatta. Men på lång sikt tappar\nvi riktningen mot det vi verkligen vill uppnå.\n\nDet är just\ndetta som är mental tuffhet: Att våga gå i riktning mot det du vill, även när\ntankar, känslor och apan skriker att du ska undvika och backa undan.\n\nHär är några vanliga läktaraktioner: \n\n• \"Jag blir tyst och slutar kommunicera.\"\n• \"Jag fastnar i tankar om att jag inte duger.\"\n• \"Jag slår ut med armarna och gnäller istället för att fokusera på nästa aktion.\"\n• \"Jag börjar spela försiktigt och tar inga risker.\"\n• \"Jag letar efter enkla lösningar istället för att hålla fast vid min spelstil.\""}, {"type": "text", "title": "Övning-dåligt", "content": "Tänk dig tillbaka till en match där det inte gick som du tänkt. Du kanske stötte på något av de hindren som du beskrev i modul 3?\n\n[[obstacle]]"}, {"type": "exercise_text", "prompt": "När du gör ett misstag eller när något går emot dig i matchen – vad GÖR du då? Hur ser ditt kroppsspråk ut? Hur påverkas din kommunikation och dina beslut?", "placeholder": "Skriv ditt svar här..."}, {"type": "exercise_text", "prompt": "När något går emot dig, vad säger apan? Vilka tankar tar över? Vad börjar du fokusera på istället för spelet?", "placeholder": "Skriv ditt svar här..."}, {"type": "exercise_text", "prompt": "Om du ser dig själv utifrån – vilka beteenden upprepar du som du vet inte hjälper dig? Vad gör du för mycket av när spelet går emot dig", "placeholder": "Skriv ditt svar här..."}]'::jsonb,
    'published'
  ) RETURNING id INTO les_197_id;

  -- Lesson: Nyckelaktioner (section 198)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod4_id,
    'Nyckelaktioner',
    4,
    'text',
    '[{"type": "video", "title": "Nyckelaktioner", "videoId": "1100443289"}, {"type": "text", "title": "Intro nyckelaktioner", "content": "Nyckelaktioner\när nycklar för att prestera på topp. Det är saker du gör som får dig att\nutvecklas och bli en bättre spelare. Aktioner som tar dig närmare din värderade\nriktning. \n\nMen de är\ninte alltid så lätta att göra. Det gäller liksom att göra tvärt om vad tankar\noch apa säger.\n\nNedan följer några vanliga situationer på fotbollsplanen. Klicka dig runt på tuffhetsmodellerna"}, {"type": "callout", "variant": "insight", "content": "Mental tuffhetsmodell: Efter missad passning"}, {"type": "callout", "variant": "insight", "content": "Mental tuffhetsmodell: Efter att ha blivit avdribblad"}, {"type": "callout", "variant": "insight", "content": "Mental tuffhetsmodell: Känner sig trött i slutet på matchen"}, {"type": "callout", "variant": "insight", "content": "Mental tuffhetsmodell: Efter baklängesmål"}]'::jsonb,
    'published'
  ) RETURNING id INTO les_198_id;

  -- Lesson: Hur gör du din lagkompis bättre? (section 199)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod4_id,
    'Hur gör du din lagkompis bättre?',
    5,
    'exercise',
    '[{"type": "text", "title": "Fotboll är en lagsport", "content": "Fotboll är\nen lagsport – och ditt sätt att agera på planen påverkar alltid dina\nlagkamrater, både positivt och negativt. Genom att förstå vilka beteenden som\nlyfter laget och vilka som drar ner det, kan du aktivt bidra till en bättre\nprestation och utveckling för både dig själv och andra.\n\nAtt göra\nsina lagkamrater bättre handlar om att ta ansvar, både i medgång och motgång.\nDet är lätt att ge energi när spelet flyter, men den stora skillnaden sker när\ndu fortsätter att stötta, styra och lyfta andra även när matchen går emot er.\nGenom att ersätta läktaraktioner med nyckelaktioner kan du inte bara påverka\nlagets prestation – du blir också en mer värdefull spelare.\n\nAtt hjälpa andra gynnar dig själv\n\nAtt hjälpa\nandra betyder inte att du glömmer din egen utveckling – tvärtom. Genom att göra\ndina lagkamrater bättre skapar du en starkare tränings- och matchmiljö, där du\nsjälv får bättre förutsättningar att utvecklas och prestera på topp. Det\nhandlar om att vara den spelare som andra vill ha i sitt lag – en spelare som\nlyfter, pushar och skapar en vinnande lagkultur.\n\nDu är i vid det här laget väl bekant med tuffhetsmodellen. Än en gång är det dina aktioner som är avgörande, i detta avsnitt dina aktioner som lagkamrat.\n\n❌ Läktaraktioner som lagkamrat – de saker vi gör för mycket av som sänker laget, t.ex. att bli tyst, sluta visa sig eller skylla på andra.\n✅ Nyckelaktioner som lagkamrat – de handlingar vi gör för lite av men som hjälper laget, t.ex. att kommunicera tydligt, lyfta medspelare och vara en förebild med din arbetsinsats."}, {"type": "text", "title": "Grupprocesser och lagkultur", "content": "Ditt\nbeteende påverkar laget\n\nHur du\nagerar på planen påverkar inte bara din egen prestation utan hela laget. Grupprocesser –\nhur spelare kommunicerar, samarbetar och tar ansvar – avgör hur väl ett lag\nfungerar tillsammans. När spelare lyfter varandra skapas\nsynergieffekter där laget presterar bättre än summan av sina individuella\nspelare. Hur ni samarbetar, kommunicerar och tar ansvar påverkar\ndirekt er prestation. En stark gruppdynamik kan göra att 1+1=3, medan en\nnegativ lagkultur gör att laget presterar sämre än sin potential."}, {"type": "text", "title": "Grupprocesser", "content": "1.\nAnsvarstagande – Är du en ledare eller en passagerare?\n\nI stora\ngrupper är det lätt att bli passiv och låta andra ta ansvar. Fenomenet\nkallas social maskning – ju fler personer, desto mindre ansvar känner\nvarje individ.\n\n  Exempel på social maskning i fotboll:\n\n❌ När laget ligger under och vissa spelare\nslutar ta löpningar eller kämpa fullt ut.\n\n❌ När ingen vågar säga något i ett lagmöte\neftersom de förlitar sig på att andra ska prata.\n\n✅ Nyckelaktioner:\n\n • Ta\n     ansvar, även när andra inte gör det. Om alla gör sitt jobb fullt ut blir\n     laget bättre.\n\n • Våga\n     uttrycka dina idéer och åsikter, även om andra är tysta.\n\n2. Trygghet\n- vågar du ta initiativ?\n\nOm en\nspelare är rädd för att göra misstag, vågar han eller hon inte ta initiativ. Trygghet i ett lag är känslan av att kunna uttrycka sig och agera utan att\nvara rädd för negativa konsekvenser.\n\n  Tecken på låg trygghet i ett\nlag:\n\n❌ Spelare håller igen och tar inte den svårare\npassningen.\n\n❌ Lagkamrater hånar varandra eller suckar vid\nmisstag.\n\n✅ Nyckelaktioner:\n\n • Skapa\n     en trygg miljö genom att ge positiv och konkret feedback.\n\n • Ge stöd\n     till lagkamrater som misslyckas – \"Bra försök! Fortsätt våga!\"\n\n3. Normer –\nVad är ”rätt” i ditt lag?\n\nNormer är\noskrivna regler som formar kulturen i ett lag. I vissa lag är det en\nsjälvklarhet att peppa varandra, träna extra och plocka upp material – i andra\nlag är det lika självklart att slarva, klaga eller ha en negativ attityd.\n\n   Exempel på positiva normer:\n\n✅ Att ge\nberöm och konstruktiv feedback till varandra.\n\n✅ Att alla spelare städar upp efter sig i\nomklädningsrummet.\n\n   Exempel på negativa normer:\n\n❌\nAtt sucka när någon gör ett misstag.\n\n❌ Att vissa spelare alltid kommer för sent\ntill träning utan att det får konsekvenser.\n\n4. Samarbete - Synkade spelare presterar bättre\n\nHar du\nspelat i ett lag där allt flöt på och du kände att ni \"hittade\nvarandra\" på planen? Då var ni synkade i spelets olika skeden.\nEtt starkt samarbete bygger på att spelarna vet vad som ska göras och\nhur de kan hjälpa varandra.\n\n  Exempel på hur spelare kan skapa\nbättre samarbete:\n\n✅ Prata med\nlagkamrater om hur ni vill ha bollen (”Jag vill ha den i djupled”).\n\n✅ Ta initiativ till att diskutera spelet med\ndina närmsta lagkamrater på planen."}, {"type": "exercise_text", "prompt": "Vad kan du göra för att påverka ditt lag i en positiv riktning?", "placeholder": "Skriv ditt svar här..."}]'::jsonb,
    'published'
  ) RETURNING id INTO les_199_id;

  -- Lesson: Hitta dina nyckelaktioner (section 200)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod4_id,
    'Hitta dina nyckelaktioner',
    6,
    'exercise',
    '[{"type": "text", "title": "Hitta nyckelbeteenden - intro", "content": "Nu är det din tur. Du ska börja med att göra en analys av vad som händer och hur du agerar när allt går som du tänkt och funkar som det ska. När allt flyter."}, {"type": "text", "title": "Övning_beteenden_intro", "content": "Tänk dig en match där allt funkar, allt flyter, där du är i zonen och allt bara sker och går med lätthet. Om vi hade en film från det ögonblicket, vad skulle den visa? Svara på frågorna nedan."}, {"type": "exercise_text", "prompt": "När du har din bästa match, vad gör du då? Hur ser dina rörelser ut? Hur agerar du med och utan pucken? Vad gör du i defensiven och offensiven?", "placeholder": "Skriv ditt svar här..."}, {"type": "exercise_text", "prompt": "När något går emot dig i matchen – hur tar du dig direkt tillbaka? Hur ser ditt kroppsspråk ut? Vad säger du till dig själv? Vad gör du i nästa aktion?", "placeholder": "Skriv ditt svar här..."}, {"type": "exercise_text", "prompt": "Vilka beteenden hos dig lyfter laget? Hur pratar du med dina lagkamrater? Hur visar du energi och närvaro?", "placeholder": "Skriv ditt svar här..."}, {"type": "text", "title": "Nyckelbeteenden_outro", "content": "När allt funkar behövs inga psykologer eller prestationsprogram. Då är det bara att gå ut och njuta. Du gör ju det du ska göra. Det är de andra fallen vi måste ha beredskap och strategier för att hantera.\n\nMental tuffhet återfinns i aktionen efter misstag eller baklängesmål. Mental styrka är att fortsätta göra det du vill och skall göra. Fokus på nästa aktion."}]'::jsonb,
    'published'
  ) RETURNING id INTO les_200_id;

  -- Lesson: Din personliga tuffhetsmodell (section 201)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod4_id,
    'Din personliga tuffhetsmodell',
    7,
    'text',
    '[{"type": "text", "title": "DIn uppdaterade tuffhetsmodell", "content": "Du har nu en tuffhetsmodell som ser ut såhär:"}, {"type": "callout", "variant": "insight", "content": "Mental tuffhetsmodell: Din personliga tuffhetsmodell"}]'::jsonb,
    'published'
  ) RETURNING id INTO les_201_id;

  -- Lesson: Momentum (section 202)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod5_id,
    'Momentum',
    0,
    'text',
    '[{"type": "text", "title": "Momentum i fotboll", "content": "Momentum i fotboll handlar om känslan av att ett lag har övertaget i matchen – att spelet flyter, självförtroendet växer och laget känns ostoppbart. Det kan vara en period där allt klickar: passningarna sitter, spelarna tar bättre beslut, och energin är hög. På samma sätt kan negativt momentum innebära att ett lag fastnar i en negativ spiral av misstag och osäkerhet."}, {"type": "video", "title": "Momentum", "videoId": "1100604948"}, {"type": "exercise_text", "prompt": "När ditt lag tappar momentum och matchen glider er ur händerna – vad kan du GÖRA för att vända det? Hur påverkar du tempot, kommunikationen och lagets energi för att ta tillbaka kontrollen?", "placeholder": "Skriv ditt svar här..."}]'::jsonb,
    'published'
  ) RETURNING id INTO les_202_id;

  -- Lesson: Sammanfattning (section 203)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod5_id,
    'Sammanfattning',
    1,
    'text',
    '[{"type": "text", "title": "Sammanfattning", "content": "För att kunna bli en bättre spelare är det viktigt att man utvärderar sina prestationer. I det här programmet bryr vi oss inte det minsta om hur väl du presterar på plan. Det enda som är viktigt för oss är att du går enligt din värderade riktning och känner glädje med din idrott. \n\nNu är du verkligen på god väg. Att göra den mentala tuffhetsanalysen är som du redan märkt inte lätt, utan kräver både engagemang och noggrannhet. Du har nu tagit det första steget och börjat förstå hur ditt utförande ser ut när allt går bra och hur ditt utförande ser ut när det inte går bra. Du har förhoppningsvis också ökat din förståelse för hur viktigt det är att vara en bra lagkamrat, både för laget och för dig själv."}, {"type": "text", "title": "Studera dig själv", "content": "1. Studera dig själv\n\nStudera din senaste match. Använd ett anteckningsblock eller skriv anteckningar på telefonen. Notera vilka nyckelaktioner (bra beteenden) du utför under matchen och räkna gärna hur många gånger du gör dem. Gör samma sak med dina läktaraktioner (dåliga beteenden). Vilken spalt är längst? \n\n2. Var en bra lagkompis\n\n1. Se till att gå ur din comfort zone och ta ansvar på träningarna i veckan. \n2. Ge beröm och konstruktiv feedback till dina lagkamrater. \n3. Bidra till en bra kultur i just ditt lag."}]'::jsonb,
    'published'
  ) RETURNING id INTO les_203_id;

  -- Lesson: Din mentala tuffhetsmodell (section 204)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod5_id,
    'Din mentala tuffhetsmodell',
    2,
    'video',
    '[{"type": "video", "title": "Modul 5 - Intro", "videoId": "1097600603"}]'::jsonb,
    'published'
  ) RETURNING id INTO les_204_id;

  -- Lesson: Att bli mentalt starkare (section 205)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod5_id,
    'Att bli mentalt starkare',
    3,
    'text',
    '[{"type": "video", "title": "Anders förklarar verktyg för förändring", "videoId": "1097603378"}, {"type": "text", "title": "Tre principer vid hinder ", "content": "Exponering\n\nExponering\n    går ut på att du närmar dig situationer som du känner obehag eller rädsla inför. Exponering fungerar bäst om närmandet sker stegvis, under så kontrollerade omständigheter som möjligt och där situationen är lagom svår.\n\nMed andra ord - ta apan i handen och gå tillsammans mot det du och apan är rädda för!\n\nAcceptans\n\nAtt acceptera tankar, känslor och apan har vi redan pratat om i programmet. När du driver dig själv mot dina värden och det du vill göra kommer du att känna känslor, som t.ex. oro och obehag. Det är naturligt och bra för din prestation att känna allt detta när du\n    utmanar dig själv. \n\nAtt låta tankar och känslor komma utan att agera på det sätt som de vill att du ska agera är en nyckel till att fortsätta växa, utvecklas och nå din fulla potential."}, {"type": "video", "title": "Henrik fördjupar acceptans", "videoId": "1097605377"}, {"type": "text", "title": "Agera", "content": "Agera\n\nAnvänd dig av ditt agerande för att trygga både apan och tankarna. Rak rygg och fast blick, trots att du helst vill göra tvärt om.\n\n• Apan blir trygg av att se dig agera tryggt.\n• Genom att agera tvärtom skapar du bättre förutsättningar för att apan och tankarna ska lära sig nya saker om dig och hur världen utanför hjärnan funkar. Det kanske inte var så farligt att göra det där misstaget, eller ta det där jobbiga samtalet med coachen?"}]'::jsonb,
    'published'
  ) RETURNING id INTO les_205_id;

  -- Lesson: Fokus på nästa aktion (section 206)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod5_id,
    'Fokus på nästa aktion',
    4,
    'text',
    '[{"type": "text", "title": "Nästa aktion", "content": "Nyckelaktioner\nkräver en plan. Alltså att du vet var du skall göra vid svåra och pressade\nsituationer. För du måste Exponera dig för Apa och Tankar, Du måste Acceptera\natt dom är där och du måste Agera på ett annat sätt än vad dom säger. \n\nMental\ntuffhet sitter i nästa aktion. Vad du gör när det är jobbigt. Nyckelaktionen är\nnyckeln ur det jobbiga."}, {"type": "text", "title": "Fokus på nästa aktion – att agera direkt, oavsett omständigheter", "content": "Att alltid\nfokusera på nästa aktion är en av de mest avgörande färdigheterna för en\nfotbollsspelare. Det är lätt att fastna i vad som redan hänt – en missad\npassning, ett insläppt mål eller en dålig touch. Men den enda situation du kan\npåverka är den som kommer nu.\n\nOm du vore\nen robot skulle du kunna programmeras att reagera perfekt i varje situation,\noavsett vad som händer runtomkring dig. Oavsett om planen är tung, domaren gör\nmisstag eller du känner press att prestera. En robot hade aldrig tvekat, aldrig\nblivit påverkad av känslor och aldrig grubblat över en tidigare aktion.\n\nMen du är\ningen robot – du är en människa med tankar, känslor och en kropp som påverkas\nav trötthet och yttre omständigheter. Fotboll är dessutom en av de mest\noförutsägbara sporterna. En perfekt passning kan brytas av en oväntad\nbrytning, en bra löpning kan vara förgäves om en lagkamrat väljer en annan\nlösning, och en domarsituation kan förändra matchbilden på en sekund.\n\n• Att fokusera på nästa aktion är en färdighet – något du kan träna och\nbli bättre på.\n• Det handlar om att göra rätt sak även när\ndet känns svårt, tufft eller obekvämt.\n• Genom att träna på detta målmedvetet kan\ndu utveckla en mentalitet där du snabbt lämnar det som hänt bakom dig och\nagerar direkt. \n\nDen bästa\nspelaren är inte den som aldrig gör misstag – utan den som hanterar dem\nsnabbast och direkt fokuserar på vad som ska göras härnäst."}, {"type": "text", "title": "Strategier för hinder", "content": "För att verkligen kunna fokusera på nästa aktion,\nbehöver du ha en strategi för att hantera de hinder som uppstår. Här är tre\nnyckelstrategier:\n\n1. Agera med\nnyckelaktioner \n\nGör det du\nskall göra oavsett känsla, tidigare miss eller tankar.\n\n2.  Exponera\ntillsammans med Apan\n\nIstället för att kämpa emot dina tankar och\nkänslor, låt dem vara där medan du agerar. Testa vad som händer när du\naccepterar Apans närvaro men ändå gör det du ska\n\n3. Acceptera\nrädsla, tvivel och oro\n\nKänslor är\nen del av fotboll. Låt det va det och fokusera på nästa nyckelaktion.\n\nFör att hantera svåra och pressade situationer behöver du en plan. Du måste Exponera dig för Apan och dina tankar, Acceptera att de finns där – och Agera på ett sätt som tar dig i rätt riktning."}]'::jsonb,
    'published'
  ) RETURNING id INTO les_206_id;

  -- Lesson: Acceptans för känslor (section 207)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod5_id,
    'Acceptans för känslor',
    5,
    'text',
    '[{"type": "text", "title": "Känslor och idrott= sant", "content": "Tänker vi\noss tillbaka till savannen hade den lyckliga, problemfria människan inte\növerlevt speciellt\nlänge. Att känna oro eller rädsla, sorg eller ledsamhet har\nalltid varit och är fortfarande viktigt för oss för vår överlevnads skull.\n\nKänslor är en stor del av fotbollen. När du vinner eller förlorar, när du kämpar med laget eller ska slå en en avgörande straff - känslorna gör sporten levande och viktiga. \n\nKänslor är\nockså signaler. Ibland visar de exakt vad som händer, men ibland kan de kännas\nförvirrande eller komma från gamla upplevelser.\n\n • Ledsenhet visar att något eller någon\n     betyder mycket för dig, t.ex att vinna.\n\n • Ilska ger kraft att kämpa när något\n     känns fel, t.ex när du blir kapad av en motståndare.\n\n • Oro kan få dig att förbereda dig bättre."}, {"type": "text", "title": "Acceptans för känslor", "content": "Du har märkt\natt om du försöker jaga bort jobbiga tankar – och apan – så gör det ofta saken\nvärre? Det är samma med känslor. Att kämpa emot dem tar energi och gör dem ofta\nännu starkare.\n\nIstället kan\ndu träna på att acceptera känslorna och låta dem finnas där. Tänk dig att du\ngår hand i hand med dem, samtidigt som du fortsätter göra det du vill – som att\nprestera på planen. Det handlar inte om att ignorera eller bita ihop, utan att\nge känslorna plats och använda din energi för att fokusera framåt.\n\nMental\nstyrka handlar om att ibland använda känslorna och åka med känslorna som dyker\nupp. Men ibland handlar det om att göra tvärt om. Vad tar dig vidare mot dit du\nvill. \n\nTill exempel\nkan det ibland vara svårt att släppa en match efter en förlust. Du kanske ältar\neller grämer dig för misstag. Då kan det faktiskt vara klokt att ställa en\nklocka. Efter 45 min är matchen stängd. Då gäller det att fokusera framåt.\nDetta är speciellt viktigt på cuper eller slutspel när tiden mellan matcher är\nknapp och återhämtningen viktig."}]'::jsonb,
    'published'
  ) RETURNING id INTO les_207_id;

  -- Lesson: Strategier för att hantera hinder (section 208)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod5_id,
    'Strategier för att hantera hinder',
    6,
    'text',
    '[{"type": "text", "title": "Sammanfattning av strategier", "content": "De strategier som du kan ha användning för vid olika hinder kan sammanfattas på följande sätt:\n\nExponera - Röra dig mot apan. Lära apan att det kanske inte är så farligt. Ta den i handen.\n\nAcceptera - Acceptera tankar och känslor som dyker upp. Låta dem vara där utan att lyssna så mycket på dem.\n\nAgera - Fokusera på att agera med hjälp av nyckelaktioner."}, {"type": "text", "title": "Skutan på havet", "content": "Tänk dig att du är kapten på en båt. I lasten har du massor av monster och dryga odjur. De håller sig ganska lugna när ni är ute på öppet hav. Ni seglar lite vind för våg. Men så dyker det upp fartyg som alla är på väg in mot land. In mot kusten. Du\nkollar kartan och kompassen och ser att de leder till städer och hamnar som du gärna vill besöka. Du börjar styra skutan mot land. Men så fort du börjar svänga rusar alla monster och odjur upp på däck. Skriker och gormar om att du inte alls ska dit. De\nhotar dig att det kommer bli livsfarligt och att du inte alls kan göra det du vill göra. Så du vänder skutan utåt igen. Driver vind för våg. Då blir det lugnt igen. Monstren och odjuren lugnar sig.\n\nMen så dyker det upp skepp igen och du blir återigen sugen på de där städerna. Du styr in mot kusten. Monstren kommer fram och hotar, men du fortsätter. Håller ratten i ett stadigt grepp och fortsätter styra enligt kompassriktningen.  Du låter dem\n    skrika och hota och fortsätter mot din kust och dit du vill. Du märker att när monstren inte blir bönhörda, så blir de lite mer beskedliga. De liksom lugnar sig lite. Du stävar med skutan in mot land och tar dig dit du vill."}]'::jsonb,
    'published'
  ) RETURNING id INTO les_208_id;

  -- Lesson: Driva utveckling med nästa aktion (section 209)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod5_id,
    'Driva utveckling med nästa aktion',
    7,
    'exercise',
    '[{"type": "text", "title": "Fokus på utförande, inte på resultat", "content": "Detta är viktigt. Utförandefokus före resultat. Viktigt, men riktigt svårt. Detta är speciellt viktigt när du tränar på din våga-lista, när du alltså övar på att bli mentalt tuffare. Att byta strategi mentalt kan vara lika svårt som att byta en viss teknik i\n    din idrott. Det gäller att öva och öva ännu mer. Ge dig själv lite extra tålamod och öka möjligheten att öva in nya beteendemönster.  Fokusera på att utförandet av nyckelbeteendena blir bra. Resultatet kommer att komma senare."}, {"type": "text", "title": "Tänk långsiktigt", "content": "För att bli en bättre spelare måste du utsätta sig för situationer som kan kännas jobbiga i stunden, men som får positiva konsekvenser på lägre sikt. Tänk på det när du skriver din våga lista. Nedan följer 2 exempel: \n\n• Du är inte bekväm i 1 -1 spel defensivt - Väljer att utsätta sig för det i träning.  Kortsiktigt, du kanske misslyckas ett par gånger på träning. Långsiktigt, du blir en bättre försvarsspelare. \n• Du hatar att springa intervaller - Väljer att löpa extra. Kortsiktigt, jobbigt i stunden. Långsiktigt, du får en bättre fysik."}, {"type": "text", "title": "Nästa match", "content": "Du har nu\nbra koll på vad som driver dig, vilka situationer som är svåra för dig, vilka\ndina läktaraktioner och nyckelaktioner är. Din Mentala tuffhetsmodell är\nkomplett. \n\nTill nästa match vill vi att du gör en Våga-lista. En lista med saker att utsätta sig för, som kanske kommer att kännas obehagligt i stunden, men som kommer gynna dig över tid."}, {"type": "text", "title": "Dina nyckelaktioner & läktaraktioner", "content": "Om du vill kan du ta hjälp av dina definierade beteenden när du gör din våga-lista. \n\nTidigare nyckelaktioner\n\n[[Nyckelaktioner]]\n\n[[Nyckelaktioner2]]\n\n[[Nyckelaktioner3]]\n\nTidigare läktaraktioner\n\n[[Dåligabeteenden]]\n\n[[Dåligabeteenden2]]\n\n[[Dåligabeteenden3]]"}, {"type": "exercise_text", "prompt": "Skriv 3 situationer jag skall våga agera med nyckelaktioner", "placeholder": "Skriv ditt svar här..."}, {"type": "text", "title": "Veckans träningsprogram", "content": "Skriv ned din våga-lista på telefonen så att du har dem lättillgängliga. Utsätt dig själv för situationerna du identifierat under veckan som kommer."}]'::jsonb,
    'published'
  ) RETURNING id INTO les_209_id;

  -- Lesson: Din förmåga att fokusera (section 210)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod6_id,
    'Din förmåga att fokusera',
    0,
    'text',
    '[{"type": "video", "title": "Modul 6", "videoId": "1100677431"}, {"type": "text", "title": "Öva upp din fokusförmåga", "content": "1. Öva upp din fokusförmåga\n\nFokus den här veckan är att öva upp din fokusförmåga. \n\n1. Gör övningen \"Fokustävling\" minst varannan dag.\n\nJu mer du tränar på fokusering, desto bättre effekt får du. Ett sätt att öka sannolikheten att övningen blir av är att planera in när du ska göra dina övningar, att schemalägga dem. Sätt påminnelser i mobilen för att i vardagen stanna upp och samla fokus, t.ex. med övningen \"Tio andetag\"."}]'::jsonb,
    'published'
  ) RETURNING id INTO les_210_id;

  -- Lesson: Arbeta vidare med din mentala tuffhetsmodell (section 211)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod6_id,
    'Arbeta vidare med din mentala tuffhetsmodell',
    1,
    'video',
    '[{"type": "video", "title": "Anders instruerar om fokus", "videoId": "1097612921"}]'::jsonb,
    'published'
  ) RETURNING id INTO les_211_id;

  -- Lesson: Vikten av fokus (section 212)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod6_id,
    'Vikten av fokus',
    2,
    'text',
    '[{"type": "text", "title": "Fotbollsspelaren med fokus", "content": "Fotbollsspelaren har jobbat hårt med sin mentala tuffhet. Tidigare försökte hon undvika sin nervositet genom att isolera sig och lyssna på musik innan match. Under spelet använde hon mantran som \"var stark\", men hennes tankar kretsade ändå kring rädslan att misslyckas och svika laget.\n\nNär spelet flöt på kände hon självförtroende, men vid misstag föll hon snabbt in i negativa tankar. Hennes kroppsspråk förändrades – hon hängde med huvudet, slog ut med armarna och spelade plötsligt försiktigt. Hon blev sina tankar, och prestationerna föll.\n\nHon insåg att hennes strategier inte fungerade och började träna med Next Acts mentala program. Genom analys förstod hon att försöken att undvika nervositet snarare begränsade henne. Hon började istället träna på närvaro och uppmärksamhet, och insåg att hon knappt registrerat musiken hon brukade lyssna på.\n\nInför match släppte hon kampen mot nervositeten. Istället för att trycka bort tankar som \"tänk om jag gör bort mig\", lät hon dem finnas utan att agera på dem. Hon gick ut med blicken högt, fokuserade på sina aktioner och var helt närvarande i övningarna.\n\nNär matchen började var hon fullt inne i spelet. Hon slutade förutse varje situation och reagerade istället naturligt och snabbt. Det kändes nästan som om hon visste var bollen skulle hamna innan det faktiskt skedde."}, {"type": "video", "title": "Henrik fördjupar syftet med fokus", "videoId": "1097615120"}, {"type": "text", "title": "Fokus på det du gör här och nu", "content": "Fokusering är en avgörande mental färdighet. Som Henrik beskriver är refokusering, eller återfokusering, en nyckelkomponent. Du kommer bli störd av konkurrenter eller situationer som är utmanande. Knepet är att refokusera på uppgiften och utförandet.\n\nDu kommer i denna modul få fler övningar att göra för att öva upp din förmåga att fokusera. För det går att träna upp! Med hjälp av närvaroträning går det att öva upp förmågan att välja fokus. Som för fotbollsspelaren vi just fick lära känna. När du övar upp din förmåga att fokusera och refokusera skapar du lite marginal mellan kletiga tankar och ett kletigt agerande."}]'::jsonb,
    'published'
  ) RETURNING id INTO les_212_id;

  -- Lesson: Öva upp din förmåga att fokusera (section 213)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod6_id,
    'Öva upp din förmåga att fokusera',
    3,
    'text',
    '[{"type": "text", "title": "Att behålla fokus – en avgörande mental färdighet", "content": "Att vara fullständigt fokuserad på en enda sak är en utmaning – hjärnan är helt enkelt inte designad för det. Den är ständigt aktiv, registrerar intryck, analyserar och söker ny information. Just därför är en av de viktigaste mentala färdigheterna inom idrott att kunna notera när fokus glider iväg – och sedan snabbt och effektivt återföra det till uppgiften.\n\nI övningen Fokustävling tränar du på just detta: att upptäcka när du tappar koncentrationen och, utan att döma eller fastna i frustrationen, direkt återvända till det du ska fokusera på. Ju snabbare och smidigare du kan skifta tillbaka, desto bättre blir din förmåga att hålla rätt mental närvaro i avgörande ögonblick."}, {"type": "callout", "variant": "tip", "content": "Ljudövning: Fokustävling"}, {"type": "text", "title": "Vad fokusträning inte är", "content": "Vad\nfokusträning inte är\n\nDet är\nviktigt att förstå vad fokusträning inte handlar om. Även om det kan kännas\navslappnande att göra fokusövningar är inte avslappning målet. Syftet är heller\ninte att försöka rensa bort alla tankar eller stänga av hjärnan.\n\nTankar\nkommer alltid att dyka upp\n\nHjärnan är\naldrig helt tyst – den är byggd för att skapa tankar och lösa problem. Oavsett\nhur mycket du tränar kommer du att bli distraherad. Men själva träningen\nhandlar inte om att undvika distraktioner, utan om att medvetet upptäcka dem\noch sedan flytta tillbaka uppmärksamheten dit den ska vara.\n\nEtt\nanvändbart förhållningssätt är att acceptera och till och med välkomna\ndistraktionen istället för att motarbeta den. När du märker att ditt fokus har\nglidit iväg, notera det, tacka hjärnan för påminnelsen – och för sedan tillbaka\nuppmärksamheten till uppgiften. På så sätt bygger du din uppmärksamhetsmuskel\noch gör det lättare att snabbt återfokusera när det verkligen gäller.\n\nHjärnan – en\ntidsmaskin som ofta drar oss bort från nuet\n\nEn av\nhjärnans mest fascinerande egenskaper är dess förmåga att resa i tiden. Den\nhjälper oss att reflektera över det förflutna och att planera för framtiden –\nmen den kan också bli en fälla.\n\nBarn har en\nnaturlig förmåga att vara närvarande i nuet, medan vuxnas hjärnor ständigt\nkastar oss framåt och bakåt i tiden. Vi ältar gamla misstag eller oroar oss för\nframtida misslyckanden. Och medan hjärnan drar iväg på dessa tidsresor\nfortsätter livet, matchen eller prestationen här och nu – där du faktiskt har\nmöjlighet att påverka.\n\nOm ditt\nfokus fastnar i det förflutna eller i rädslan för vad som kan hända, blir det\nsvårt att prestera på din högsta nivå. Det gör det också svårare att i\nefterhand känna dig nöjd med din insats. Genom att aktivt träna på att\nåtervända till nuet kan du ge dig själv den bästa chansen att prestera fullt ut\n– och njuta av det du gör medan du gör det."}, {"type": "text", "title": "Fokusträning tar tid", "content": "Väldigt många som börjar med fokusträning, eller mindfullness, slutar snabbt. En stor anledning till detta är för att många förväntar sig snabba resultat. Resultatet av övningarna kommer inte märkas av över en natt, men med tiden så kommer det ge effekter. Visserligen har forskning visat att bara några några minuter kan ha positivt utfall, men skall du ha mer långtgående effekt behövs mer tålamod. För att få resultat måste du vara ihärdig, åtminstone 8-10 veckor. Men det ger effekter på prestation!"}]'::jsonb,
    'published'
  ) RETURNING id INTO les_213_id;

  -- Lesson: Fokusövningar leder till nyckelaktioner (section 216)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod6_id,
    'Fokusövningar leder till nyckelaktioner',
    4,
    'text',
    '[{"type": "text", "title": "Fler övningar", "content": "Syfte med fokusövningar är att enklare kunna utföra nyckelaktioner trots tankar och Apa.  Att lättare göra nästa aktion bättre och att fortsätta göra lagkompisarna bättre. Att välja att agera som du vill oavsett läge känsla eller tankar. Fokusövningar gör det lättare för dig att utföra dessa.\n\nDet finns fler bra appar som kan hjälpa dig med din fokusträning. Här är några vi rekommenderar:\n\n- Balance \n- Headspace \n- Calm \n\nAlla appar kan hjälpa dig att komma igång och fortsätta med din fokusträning. Du kan också hitta ljudspår på Spotify för att komma igång. Sök på mindfulness  eller guidad meditation. Det spelar ingen större roll vilken sida eller ljudspår du väljer, funktionen är densamma - träna hjärnan att återfokusera. Det viktigaste är att du gör det regelbundet och litar på processen."}, {"type": "text", "title": "Skapa rutiner", "content": "• I bussen till matchen eller träningen. Ta 5 min och fokusera på andningen. Ställ en klocka annars blir det inte av. \n• I omklädningsrummet. fokus på andningen i 1 minut\n• I spelargången in på plan - 3 andetag fokus på andningen. \n• I halvtid - 5 andetag med fokus på andningen.\n\nDet spelar ingen roll när du gör dina övningar. Testa att skapa dina rutiner för detta."}, {"type": "text", "title": "Hur jobbar de bästa?", "content": "Elitidrott är små marginaler och det skiljer inte mycket mellan de allra bästa inom olika idrotter. Intressant att notera är att några av världens mest framstående inom sina sporter aktivt jobbade med mindfullness och fokusträning. Här är några exempel på De bästa genom alla tider. \n\nMichael Jordan (Basket): Jordan, ofta ansedd som en av de största basketspelarna genom tiderna, har varit öppen om sin användning av mental träning. Han jobbade med mental coachning under sin karriär, där framförallt mindfulness och var en viktig del. Hans förmåga att vara fokuserad under stressiga situationer, särskilt i avgörande moment, kopplas ofta till hans mentala träning.\n\nSerena Williams (Tennis): Serena Williams har varit en förespråkare för mindfulness och mental träning, och hon har talat om hur det har hjälpt henne att hantera pressen och återhämta sig mentalt efter förluster. Hennes mentala styrka, särskilt i avgörande matcher, har ofta nämnts som en avgörande faktor i hennes framgång.\n\nCristiano Ronaldo (Fotboll): Ronaldo har blivit känd för sitt engagemang för fysisk och mental hälsa. Han har nämnt att han gör olika övningar för att förbättra sin mentala förberedelse, inklusive mindfulness. Hans förmåga att hålla sig fokuserad och hantera press i viktiga ögonblick är något han tillskriver sitt mentala arbete.\n\nKobe Bryant (Basket): Bryant var en annan framstående idrottare som använde mental träning för att stärka sitt spel. Han var känd för sin dedikation till \"Mamba Mentality\", som innefattade mindfulness och en stark inre mental styrka för att prestera på högsta nivå. Bryant var en förespråkare för att kombinera fysisk träning med mental träning.\n\nVirgil van Dijk (Fotboll): Van Dijk är känd för sin lugn och stabilitet på planen. Han har talat om hur han använder mental träning för att hantera stressiga situationer och behålla sitt fokus. Hans förmåga att vara närvarande och hålla ett kallt huvud under press har varit en viktig del av hans framgång."}]'::jsonb,
    'published'
  ) RETURNING id INTO les_216_id;

  -- Lesson: Fler knep för fokus (section 217)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod6_id,
    'Fler knep för fokus',
    5,
    'text',
    '[{"type": "text", "title": "Fler knep för att hitta fokus", "content": "• Fokus på nyckelaktioner och prestationsmål\nAtt fokusera på utförandet av dina nyckelaktioner hjälper dig att bibehålla fokus under situationer där du lätt kan bli distraherad, som t.ex. motståndare som försöker psyka dig eller har medgången\n        på sin sida. Det kan också vara när tankar kommer om att du inte får göra fel eller att du håller på att vinna eller när avgörandet i matchen ska ske och din nervositet och apa gör sig påminda. Att bibehålla fokus tillsammans med det du\n        upplever riktar din uppmärksamhet mot det du vill göra, det du kan, och där du har kontroll.\n\n    • Rutiner före matchen\nRutiner före matcher, under matcher och efter misstag är ett annat sätt att återta fokus och öka din förmåga att koncentrera dig. Även här har du det arbete du lagt ner i din mentala tuffhetsmodell att utgå ifrån, t.ex.\n        rutiner för när du gör misstag, där fokus alltid ska hamna på dina nyckelaktioner. Att inför matcher skapa rutiner för fokusövningar och närvaro är också ett bra sätt att öka din fokuseringsgrad, likaså att visualisera utförande av nyckelaktioner inför matcher. Det finns dock ett par fallgropar att se upp för. Rutinerna ska inte vara ett sätt att ta bort nervositet eller tankar, utan ett sätt att ta in och acceptera dem.  Vidskeplighet kan också bli problematiskt då det är i utförandet\n        som din framgång sitter.\n\n    • In och ur fokus\nEn match varierar ofta i intensitet, vilket kan göra det svårt att bibehålla ett jämnt fokus. Då är det bra att skapa rutiner för att gå in och ur fokus. Att medvetet koppla bort\n        tävlingsfokuset och förflytta uppmärksamheten till något annat kan vara bra. Även att skapa en bra rutin, för att i god tid koppla på fokus igen.\n        \n\nEn fallgrop som är värd att se upp för är att under perioder med mindre behov av fokus hamna i tankar om din senaste prestation. Att utvärdera, älta och ha tankar om att det går dåligt är viktigt att uppmärksamma för att istället fokusera\n        på andra saker. Det är bättre med en kort analys och att sedan släppa saken."}, {"type": "text", "title": "Idrottsfokus", "content": "Gör en fokusövning minst varannan dag\n\nDu kan söka efter egna övningar eller använda de som finns i programmet. Det viktiga är att de blir av."}]'::jsonb,
    'published'
  ) RETURNING id INTO les_217_id;

  -- Lesson: 7. Avslutning (section 218)
  INSERT INTO public.lessons (module_id, title, "order", lesson_type, content, status)
  VALUES (
    mod7_id,
    '7. Avslutning',
    0,
    'text',
    '[{"type": "video", "title": "Modul 7 - Avslutning", "videoId": "1097617371"}, {"type": "text", "title": "En sista grej..", "content": "Bra jobbat de senaste veckorna! Du har under programmets gång fått en ökat kunskap om hur du ska bedriva din elitsatsning på ett hållbart och mer framgångsrikt sätt. Du har skapat en personlig tuffhetsmodell där du fått identifiera din värderade riktning, dina största hinder, dina läktaraktioner och dina nyckelaktioner. Som ett sista steg i det här programmet ska vi nu skapa en Gameplan som du alltid kan ha med dig. Gameplanen kan du se här nedan. Den är ett resultat av dina nyckelaktioner när du stöter på hinder och vad du gör för att vända momentum i matcherna. En praktisk guide, så att du alltid har en väg tillbaka in i matchen, oavsett utmaning."}, {"type": "text", "title": "Din Gameplan", "content": "När du stöter på hinder kan du alltid använda dig av dina nyckelaktioner:\n\n[[Nyckelaktioner]]\n\n[[Nyckelaktioner2]]\n\n[[Nyckelaktioner3]]\n\nNär du vill vända negativt momentum ska du göra följande:\n\n[[Momentum]]"}, {"type": "text", "title": "Mer hjälp", "content": "Din Gameplan skickas till din mail. Se till att spara den på telefonen så att du alltid har den nära!\n\nÖnskar du ytterligare stöd, kontakta oss på kontakt@nextact.se så hjälper vi dig. \n\nGrymt jobbat med programmet!"}]'::jsonb,
    'published'
  ) RETURNING id INTO les_218_id;

END $$;

-- =============================================================================
-- Verify the migration
-- =============================================================================
DO $$
DECLARE
  module_count int;
  lesson_count int;
BEGIN
  SELECT COUNT(*) INTO module_count FROM public.modules m
    JOIN public.programs p ON p.id = m.program_id WHERE p.title = 'Fotboll';
  SELECT COUNT(*) INTO lesson_count FROM public.lessons l
    JOIN public.modules m ON m.id = l.module_id
    JOIN public.programs p ON p.id = m.program_id WHERE p.title = 'Fotboll';
  RAISE NOTICE 'Fotboll program: % modules, % lessons', module_count, lesson_count;
  IF module_count != 8 THEN RAISE EXCEPTION 'Expected 8 modules, got %', module_count; END IF;
  IF lesson_count != 42 THEN RAISE EXCEPTION 'Expected 42 lessons, got %', lesson_count; END IF;
END $$;