// Project Models
import 'package:sfrigola/models/category.dart';
import 'package:sfrigola/models/meal.dart';

// ---------------------------------------------------------------------------
// Categories  (12 total)
// ---------------------------------------------------------------------------

const availableCategories = [
  Category(id: 'c1', title: 'Italian', icon: '🍕'),
  Category(id: 'c2', title: 'Quick & Easy', icon: '⚡'),
  Category(id: 'c3', title: 'Street Food', icon: '🍔'),
  Category(id: 'c4', title: 'German', icon: '🥨'),
  Category(id: 'c5', title: 'Light & Healthy', icon: '🥗'),
  Category(id: 'c6', title: 'Exotic', icon: '🌴'),
  Category(id: 'c7', title: 'Breakfast', icon: '🍳'),
  Category(id: 'c8', title: 'Asian', icon: '🍜'),
  Category(id: 'c9', title: 'French', icon: '🥐'),
  Category(id: 'c10', title: 'Summer', icon: '☀️'),
  Category(id: 'c11', title: 'Desserts', icon: '🍰'),
  Category(id: 'c12', title: 'Mediterranean', icon: '🫒'),
];

// ---------------------------------------------------------------------------
// Meals  (30 total)
// ---------------------------------------------------------------------------

const availableMeals = [
  // ── m1: Spaghetti Carbonara ────────────────────────────────────────────
  Meal(
    id: 'm1',
    categories: ['c1'],
    title: 'Spaghetti Carbonara',
    subtitle: 'L\'originale romano: cremoso senza panna',
    description:
        'La vera carbonara non conosce panna. Tuorli d\'uovo, guanciale croccante, '
        'Pecorino Romano e il grasso della padella creano la più vellutata delle salse.',
    imageUrl:
        'https://images.unsplash.com/photo-1612874742237-6526221588e3?auto=format&fit=crop&w=800&q=80',
    duration: 25,
    servings: 2,
    complexity: Complexity.challenging,
    affordability: Affordability.affordable,
    ingredients: [
      '200 g spaghetti',
      '100 g guanciale',
      '3 tuorli d\'uovo + 1 uovo intero',
      '60 g Pecorino Romano grattugiato',
      '30 g Parmigiano Reggiano grattugiato',
      'Pepe nero macinato fresco q.b.',
      'Sale grosso per l\'acqua di cottura',
    ],
    steps: [
      'Tagliare il guanciale a listarelle e rosolarlo in padella a fuoco medio senza aggiungere olio, '
          'finché è dorato e croccante. Tenere da parte il fondo di cottura.',
      'In una ciotola sbattere i tuorli e l\'uovo intero con il Pecorino e il Parmigiano. '
          'Aggiungere abbondante pepe nero.',
      'Cuocere gli spaghetti in abbondante acqua salata al dente. '
          'Raccogliere 2 mestoli di acqua di cottura prima di scolare.',
      'Scolare la pasta e versarla nella padella col guanciale (a fuoco spento). '
          'Mescolare bene per fare assorbire il grasso.',
      'Aggiungere il composto di uova e formaggi mescolando rapidamente. '
          'Allungare con l\'acqua di cottura poco alla volta fino a ottenere una crema lucida.',
      'Servire subito con altro Pecorino e una macinata generosa di pepe.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: false,
    rate: 4.9,
  ),

  // ── m2: Pizza Margherita ───────────────────────────────────────────────
  Meal(
    id: 'm2',
    categories: ['c1'],
    title: 'Pizza Margherita',
    subtitle: 'L\'impasto perfetto per una pizza napoletana',
    description:
        'Cornicione alveolato, salsa di pomodoro San Marzano, fior di latte e un filo d\'olio '
        'evo. La semplicità elevata ad arte.',
    imageUrl:
        'https://images.unsplash.com/photo-1574071318508-1d37ea6e4c2b?auto=format&fit=crop&w=800&q=80',
    duration: 90,
    servings: 2,
    complexity: Complexity.challenging,
    affordability: Affordability.affordable,
    ingredients: [
      '300 g farina 00 (o Manitoba)',
      '200 ml acqua tiepida',
      '7 g lievito di birra fresco',
      '8 g sale',
      '5 g zucchero',
      '20 ml olio extravergine d\'oliva',
      '250 g pelati San Marzano',
      '200 g fior di latte',
      'Foglie di basilico fresco',
    ],
    steps: [
      'Sciogliere il lievito nell\'acqua tiepida con lo zucchero. '
          'Attendere 5 minuti finché fa le bolle.',
      'Mescolare la farina e il sale in una ciotola capiente. '
          'Aggiungere il liquido con il lievito e l\'olio, impastare per 10 minuti '
          'fino a ottenere un panetto liscio ed elastico.',
      'Coprire con pellicola e lasciare lievitare 1 ora a temperatura ambiente '
          '(o tutta la notte in frigo per un risultato migliore).',
      'Stendere la pasta su carta forno con le mani, allargandola dal centro verso '
          'i bordi per creare il cornicione.',
      'Schiacciare i pelati a mano e distribuirli sulla base. '
          'Condire con sale e un filo d\'olio.',
      'Cuocere a 250 °C per 8–10 minuti, poi aggiungere il fior di latte a pezzetti '
          'e cuocere altri 3–4 minuti.',
      'Sfornare, aggiungere le foglie di basilico fresco e un giro d\'olio evo.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
    rate: 4.8,
  ),

  // ── m3: Risotto ai Funghi Porcini ──────────────────────────────────────
  Meal(
    id: 'm3',
    categories: ['c1'],
    title: 'Risotto ai Funghi Porcini',
    subtitle: 'Il profumo del bosco in cinque stelle',
    description:
        'Riso Carnaroli mantecato con burro e Parmigiano, funghi porcini secchi '
        'reidratati e freschi di stagione. Un piatto che sa di autunno.',
    imageUrl:
        'https://images.unsplash.com/photo-1476124369491-e7addf5db371?auto=format&fit=crop&w=800&q=80',
    duration: 40,
    servings: 4,
    complexity: Complexity.challenging,
    affordability: Affordability.pricey,
    ingredients: [
      '320 g riso Carnaroli',
      '30 g funghi porcini secchi',
      '200 g funghi porcini freschi (o misti)',
      '1 scalogno',
      '1 spicchio d\'aglio',
      '100 ml vino bianco secco',
      '1 l brodo vegetale caldo',
      '60 g burro',
      '60 g Parmigiano Reggiano grattugiato',
      'Prezzemolo fresco, sale, pepe',
    ],
    steps: [
      'Reidratare i porcini secchi in acqua tiepida per 20 minuti. '
          'Filtrare il liquido e tenerlo da parte.',
      'Saltare i porcini freschi con l\'aglio e un filo d\'olio a fuoco vivo. '
          'Sfumare con un goccio di vino e cuocere 5 minuti. Tenere da parte.',
      'In una casseruola soffriggere lo scalogno tritato con 20 g di burro. '
          'Aggiungere il riso e tostarlo 2 minuti finché traslucido.',
      'Sfumare con il vino bianco e lasciare evaporare completamente.',
      'Aggiungere i porcini secchi strizzati e il loro liquido filtrato. '
          'Procedere aggiungendo il brodo caldo mestolo per mestolo, '
          'aspettando che venga assorbito prima di aggiungerne altro.',
      'Dopo 16–18 minuti il riso dovrà essere al dente. Spegnere il fuoco. '
          'Mantecare con il restante burro freddo e il Parmigiano, mescolando energicamente.',
      'Aggiungere i funghi saltati, cospargere di prezzemolo e servire subito.',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
    rate: 4.7,
  ),

  // ── m4: Penne all'Arrabbiata ───────────────────────────────────────────
  Meal(
    id: 'm4',
    categories: ['c1', 'c2'],
    title: 'Penne all\'Arrabbiata',
    subtitle: 'Piccante al punto giusto, pronta in 20 minuti',
    description:
        'Salsa di pomodoro con aglio, peperoncino e olio buono. '
        'Uno dei grandi classici della cucina romana, semplicissimo e irresistibile.',
    imageUrl:
        'https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?auto=format&fit=crop&w=800&q=80',
    duration: 20,
    servings: 4,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: [
      '400 g penne rigate',
      '400 g polpa di pomodoro',
      '3 spicchi d\'aglio',
      '2–3 peperoncini rossi secchi',
      '4 cucchiai olio extravergine di oliva',
      'Prezzemolo fresco',
      'Sale',
    ],
    steps: [
      'Scaldare l\'olio in una padella capiente a fuoco medio. '
          'Aggiungere l\'aglio schiacciato e i peperoncini sbriciolati e rosolare 2 minuti.',
      'Aggiungere la polpa di pomodoro, salare e cuocere scoperta a fuoco medio-alto '
          'per 10–12 minuti, finché la salsa si addensa.',
      'Nel frattempo cuocere le penne in abbondante acqua salata. '
          'Scolare al dente tenendo un mestolo d\'acqua di cottura.',
      'Versare la pasta nella padella con la salsa, mescolare a fuoco vivace '
          'per un minuto aggiungendo un goccio di acqua di cottura se necessario.',
      'Cospargere di prezzemolo fresco tritato e servire.',
    ],
    isGlutenFree: false,
    isVegan: true,
    isVegetarian: true,
    isLactoseFree: true,
    rate: 4.5,
  ),

  // ── m5: Lasagna al Forno ───────────────────────────────────────────────
  Meal(
    id: 'm5',
    categories: ['c1'],
    title: 'Lasagna al Forno',
    subtitle: 'La domenica incomincia con la lasagna',
    description:
        'Sfoglie di pasta all\'uovo con ragù alla bolognese, besciamella vellutata '
        'e Parmigiano: il piatto del cuore dell\'Emilia-Romagna.',
    imageUrl:
        'https://images.unsplash.com/photo-1574894709920-11b28e7367e3?auto=format&fit=crop&w=800&q=80',
    duration: 120,
    servings: 6,
    complexity: Complexity.hard,
    affordability: Affordability.pricey,
    ingredients: [
      '250 g sfoglie di lasagna (fresche o secche)',
      '400 g carne macinata mista (manzo + maiale)',
      '150 g pancetta tesa',
      '1 cipolla, 1 carota, 1 gambo di sedano',
      '200 ml vino rosso',
      '400 g passata di pomodoro',
      '500 ml latte intero',
      '50 g burro',
      '50 g farina 00',
      'Noce moscata',
      '100 g Parmigiano Reggiano grattugiato',
      'Sale, pepe, olio evo',
    ],
    steps: [
      'RAGÙ: tritare finemente cipolla, carota e sedano (soffritto). '
          'Rosolare con olio e pancetta a dadini per 5 minuti.',
      'Aggiungere la carne macinata e rosolare ben sgranata. '
          'Sfumare con il vino rosso e lasciare evaporare.',
      'Aggiungere la passata, salare, incoperchiare e cuocere a fuoco basso '
          'almeno 45 minuti (aggiungere acqua se si asciuga troppo).',
      'BESCIAMELLA: sciogliere il burro in un pentolino, aggiungere la farina '
          'in una volta e mescolare velocemente. Versare il latte caldo poco alla volta, '
          'mescolando per evitare grumi. Cuocere fino ad addensamento, salare e aggiungere noce moscata.',
      'ASSEMBLARE: ungere una teglia, stendere un velo di besciamella sul fondo. '
          'Alternare strati di sfoglia, ragù, besciamella e Parmigiano. '
          'Terminare con besciamella e abbondante Parmigiano.',
      'Coprire con foglio alluminio e cuocere a 180 °C per 35 minuti. '
          'Scoprire e cuocere altri 15 minuti per la crosticina dorata.',
      'Lasciare riposare 10 minuti prima di tagliare.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: false,
    rate: 4.9,
  ),

  // ── m6: Tiramisù ─────────────────────────────────────────────────────
  Meal(
    id: 'm6',
    categories: ['c1', 'c11'],
    title: 'Tiramisù Classico',
    subtitle: 'Il dessert che ti solleva sempre il morale',
    description:
        'Savoiardi imbevuti di caffè espresso, crema al mascarpone con tuorli e albumi montati. '
        'Il dolce più amato d\'Italia.',
    imageUrl:
        'https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?auto=format&fit=crop&w=800&q=80',
    duration: 30,
    servings: 6,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: [
      '300 g mascarpone',
      '4 uova fresche (tuorli e albumi separati)',
      '100 g zucchero semolato',
      '200 g savoiardi',
      '300 ml caffè espresso freddo',
      '20 ml Marsala secco (opzionale)',
      'Cacao amaro in polvere q.b.',
    ],
    steps: [
      'Preparare il caffè espresso e lasciarlo raffreddare completamente. '
          'Aggiungere il Marsala se gradito.',
      'Montare i tuorli con lo zucchero fino a ottenere un composto chiaro e spumoso.',
      'Incorporare il mascarpone ai tuorli montati, mescolando delicatamente con una spatola.',
      'Montare gli albumi a neve ferma con un pizzico di sale. '
          'Incorporarli al composto di mascarpone con movimenti dal basso verso l\'alto.',
      'Inzuppare velocemente i savoiardi nel caffè (un secondo per lato) '
          'e disporli in uno strato in una pirofila.',
      'Coprire con metà della crema al mascarpone. '
          'Fare un secondo strato di savoiardi e coprire con la crema rimanente.',
      'Spolverare con cacao amaro, coprire con pellicola e '
          'refrigerare almeno 4 ore (idealmente tutta la notte).',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
    rate: 4.9,
  ),

  // ── m7: Pancakes americani ─────────────────────────────────────────────
  Meal(
    id: 'm7',
    categories: ['c2', 'c7'],
    title: 'Pancakes Americani',
    subtitle: 'La colazione che meriti ogni mattina',
    description:
        'Soffici, gonfi e dorati: con sciroppo d\'acero, burro e frutti di bosco freschi '
        'fanno della colazione un momento magico.',
    imageUrl:
        'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?auto=format&fit=crop&w=800&q=80',
    duration: 20,
    servings: 2,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: [
      '190 g farina 00',
      '200 ml latte intero',
      '1 uovo',
      '2 cucchiai di zucchero',
      '1 cucchiaino lievito in polvere',
      '1/2 cucchiaino bicarbonato',
      '1 cucchiaino succo di limone (o aceto di mele)',
      '30 g burro fuso',
      'Un pizzico di sale',
    ],
    steps: [
      'Mescolare il latte con il succo di limone e lasciare riposare 5 minuti '
          '(si ottiene il buttermilk).',
      'In una ciotola unire farina, zucchero, lievito, bicarbonato e sale.',
      'Aggiungere agli ingredienti secchi l\'uovo, il latte acido e il burro fuso. '
          'Mescolare fino ad amalgamare senza lavorare troppo (qualche grumo va bene).',
      'Scaldare una padella antiaderente a fuoco medio-basso e ungere leggermente con burro.',
      'Versare circa 60 ml di pastella per ogni pancake. '
          'Cuocere finché compaiono le bolle in superficie (circa 2 minuti), '
          'poi girare e cuocere altri 90 secondi.',
      'Servire subito con sciroppo d\'acero, burro e frutti di bosco.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
    rate: 4.6,
  ),

  // ── m8: Overnight Oats ────────────────────────────────────────────────
  Meal(
    id: 'm8',
    categories: ['c2', 'c5', 'c7'],
    title: 'Overnight Oats',
    subtitle: 'Prepara la sera, gusta la mattina',
    description:
        'Fiocchi d\'avena lasciati in ammollo tutta la notte nel latte. '
        'Il mattino dopo sono cremosi e pronti, da arricchire con frutta e semi.',
    imageUrl:
        'https://images.unsplash.com/photo-1517673400267-0251440c45dc?auto=format&fit=crop&w=800&q=80',
    duration: 5,
    servings: 1,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: [
      '60 g fiocchi d\'avena',
      '150 ml latte (vaccino o vegetale)',
      '100 g yogurt greco',
      '1 cucchiaio semi di chia',
      '1 cucchiaio miele o sciroppo d\'acero',
      'Frutta fresca a scelta (banana, mirtilli, fragole)',
      'Granola e noci per guarnire',
    ],
    steps: [
      'In un barattolo o ciotola unire l\'avena, il latte, lo yogurt, i semi di chia '
          'e il miele. Mescolare bene.',
      'Coprire e riporre in frigorifero per almeno 8 ore (o tutta la notte).',
      'Al mattino, mescolare e aggiungere un goccio di latte se troppo denso.',
      'Guarnire con frutta fresca, granola e noci.',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
    rate: 4.3,
  ),

  // ── m9: Avocado Toast ─────────────────────────────────────────────────
  Meal(
    id: 'm9',
    categories: ['c2', 'c5', 'c7'],
    title: 'Avocado Toast',
    subtitle: 'Il brunch più instagrammabile che ci sia',
    description:
        'Pane tostato con avocado schiacciato, uovo in camicia e semi: '
        'colorato, nutriente e pronto in dieci minuti.',
    imageUrl:
        'https://images.unsplash.com/photo-1541519227354-08fa5d50c820?auto=format&fit=crop&w=800&q=80',
    duration: 10,
    servings: 1,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: [
      '2 fette di pane integrale (o sourdough)',
      '1 avocado maturo',
      '2 uova fresche',
      '1 cucchiaino succo di limone',
      'Sale, peperoncino in scaglie',
      'Semi di sesamo o di zucca',
      'Olio extravergine d\'oliva',
    ],
    steps: [
      'Tostare le fette di pane in un tostapane o in padella a secco.',
      'Tagliare l\'avocado a metà, rimuovere il nocciolo e raccogliere la polpa. '
          'Schiacciarla con una forchetta con il succo di limone e un pizzico di sale.',
      'Portare a ebollizione acqua con aceto. Girare delicatamente l\'acqua '
          'con un cucchiaio e rompere l\'uovo al centro del vortice. '
          'Cuocere 3 minuti per un tuorlo morbido.',
      'Spalmare l\'avocado sul pane tostato. Adagiare l\'uovo in camicia sopra.',
      'Condire con olio, peperoncino e semi.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: true,
    rate: 4.4,
  ),

  // ── m10: Toast Hawaii ─────────────────────────────────────────────────
  Meal(
    id: 'm10',
    categories: ['c2'],
    title: 'Toast Hawaii',
    subtitle: 'Dolce, salato e pronto in 10 minuti',
    description:
        'L\'irresistibile combinazione di prosciutto cotto, ananas e formaggio '
        'filante su pane tostato croccante.',
    imageUrl:
        'https://images.unsplash.com/photo-1484723091739-30746204efd4?auto=format&fit=crop&w=800&q=80',
    duration: 10,
    servings: 2,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: [
      '4 fette di pane in cassetta',
      '4 fette di prosciutto cotto',
      '4 fettine di ananas (sciroppate o fresche)',
      '4 fette di emmentaler o edamer',
      'Burro q.b.',
    ],
    steps: [
      'Imburrare leggermente un lato di ciascuna fetta di pane.',
      'Sul lato non imburrato distribuire una fetta di prosciutto, '
          'una di ananas ben sgocciolata e una di formaggio.',
      'Cuocere in forno a 200 °C per 8–10 minuti finché il formaggio è filante '
          'e il bordo del pane è dorato.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: false,
    rate: 3.8,
  ),

  // ── m11: Classic Cheeseburger ─────────────────────────────────────────
  Meal(
    id: 'm11',
    categories: ['c3'],
    title: 'Classic Cheeseburger',
    subtitle: 'Il re degli street food, fatto in casa',
    description:
        'Polpetta di manzo succosa, cheddar filante, cipolla croccante e '
        'salsa speciale su un panino brioche tostato.',
    imageUrl:
        'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=800&q=80',
    duration: 30,
    servings: 2,
    complexity: Complexity.simple,
    affordability: Affordability.pricey,
    ingredients: [
      '300 g carne macinata di manzo (80/20)',
      '2 panini brioche per burger',
      '2 fette di cheddar',
      '1 cipolla rossa',
      '2 foglie di lattuga iceberg',
      '1 pomodoro a fette',
      'Ketchup, senape, maionese',
      'Sale, pepe nero',
    ],
    steps: [
      'Dividere la carne in 2 polpette da 150 g. Schiacciarle leggermente '
          'con le mani fino a formare dischi spessi circa 1,5 cm. '
          'Condire ambo i lati con sale e pepe.',
      'Scaldare una padella in ghisa o griglia a fuoco alto fino a che è fumante.',
      'Cuocere le polpette 2–3 minuti per lato (cottura media). '
          'Nell\'ultimo minuto adagiare il cheddar sulla polpetta e coprire per farlo fondere.',
      'Tostare i panini tagliati a metà nella stessa padella per 1 minuto.',
      'Assemblare: spalmare la base del panino con maionese e senape, '
          'aggiungere lattuga, pomodoro, cipolla ad anelli, la polpetta e ketchup sul coperchio.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: false,
    rate: 4.5,
  ),

  // ── m12: Fish & Chips ────────────────────────────────────────────────
  Meal(
    id: 'm12',
    categories: ['c3'],
    title: 'Fish & Chips',
    subtitle: 'Il comfort food britannico per eccellenza',
    description:
        'Filetti di merluzzo in pastella di birra, croccanti fuori e '
        'morbidi dentro, con patatine fritte spesse in stile pub.',
    imageUrl:
        'https://images.unsplash.com/photo-1559847844-5315695dadae?auto=format&fit=crop&w=800&q=80',
    duration: 50,
    servings: 2,
    complexity: Complexity.challenging,
    affordability: Affordability.affordable,
    ingredients: [
      '400 g filetti di merluzzo (o passera)',
      '4 patate medie a pasta gialla',
      '150 g farina 00',
      '200 ml birra chiara fredda',
      '1 uovo',
      'Sale, pepe',
      'Olio di arachidi per friggere',
      'Limone e tartara per servire',
    ],
    steps: [
      'Pelare le patate e tagliarle a bastoncini spessi. Sciacquarle, asciugarle bene '
          'e friggere a 160 °C per 5 minuti (pre-cottura). Scolare e mettere da parte.',
      'Preparare la pastella mescolando farina, uovo e birra fino ad ottenere '
          'una consistenza liscia e densa. Salare e pepare.',
      'Asciugare bene i filetti di pesce con carta assorbente. '
          'Infarinarli leggermente, poi immergerli nella pastella.',
      'Friggere i filetti a 180 °C finché la pastella è dorata e croccante (circa 4–5 minuti). '
          'Scolare su carta assorbente.',
      'Alzare la temperatura dell\'olio a 190 °C e friggere le patatine in seconda cottura '
          'per 2–3 minuti finché dorate e croccanti.',
      'Servire subito con spicchi di limone e salsa tartara.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
    rate: 4.2,
  ),

  // ── m13: Veggie Wrap ──────────────────────────────────────────────────
  Meal(
    id: 'm13',
    categories: ['c3', 'c5'],
    title: 'Veggie Wrap Colorato',
    subtitle: 'Pranzo veloce, leggero e bellissimo',
    description:
        'Tortilla integrale ripiena di hummus, avocado, verdure grigliate e '
        'germogli: un pasto completo che si prepara in 15 minuti.',
    imageUrl:
        'https://images.unsplash.com/photo-1626700051175-6818013e1d4f?auto=format&fit=crop&w=800&q=80',
    duration: 15,
    servings: 2,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: [
      '2 tortilla di farina integrale (grandi)',
      '4 cucchiai di hummus',
      '1 avocado',
      '1 peperone giallo arrosto a listarelle',
      '1 zucchina grigliata',
      'Una manciata di spinacino fresco',
      'Germogli di alfalfa',
      'Succo di limone, sale, peperoncino',
    ],
    steps: [
      'Scaldare le tortilla in padella asciutta per 30 secondi per lato.',
      'Spalmare 2 cucchiai di hummus al centro di ciascuna tortilla.',
      'Disporre le verdure grigliate, l\'avocado a fette, gli spinacini e i germogli.',
      'Condire con limone, sale e peperoncino.',
      'Arrotolare la tortilla strettamente, tagliare in diagonale e servire.',
    ],
    isGlutenFree: false,
    isVegan: true,
    isVegetarian: true,
    isLactoseFree: true,
    rate: 4.1,
  ),

  // ── m14: Wiener Schnitzel ────────────────────────────────────────────
  Meal(
    id: 'm14',
    categories: ['c4'],
    title: 'Wiener Schnitzel',
    subtitle: 'Croccante fuori, tenero dentro',
    description:
        'La cotoletta viennese nella sua forma più autentica: vitello finissimo, '
        'panatura dorata nel burro chiarificato e limone fresco.',
    imageUrl:
        'https://images.pexels.com/photos/3807517/pexels-photo-3807517.jpeg?auto=compress&cs=tinysrgb&w=800',
    duration: 40,
    servings: 4,
    complexity: Complexity.challenging,
    affordability: Affordability.luxurious,
    ingredients: [
      '4 fettine di vitello (120 g caduna)',
      '2 uova',
      '100 g pangrattato finissimo',
      '80 g farina 00',
      '200 g burro chiarificato (o olio di girasole)',
      'Sale, limone',
    ],
    steps: [
      'Battere le fettine di vitello tra due fogli di pellicola fino a mezzo centimetro '
          'di spessore. Salare su entrambi i lati.',
      'Preparare tre piatti: farina, uova sbattute e pangrattato.',
      'Passare ogni fettina nella farina (eliminare l\'eccesso), nell\'uovo, '
          'poi nel pangrattato, premendo leggermente per farlo aderire.',
      'Scaldare abbondante burro chiarificato in un\'ampia padella a 170 °C. '
          'Friggere le cotolette 2–3 minuti per lato, muovendo continuamente la padella '
          'per far "ondeggiare" il grasso e creare la panatura soffice.',
      'Scolare su carta assorbente. Servire con spicchi di limone e prezzemolo fritto.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: false,
    rate: 4.7,
  ),

  // ── m15: Pretzel con Obatzda ─────────────────────────────────────────
  Meal(
    id: 'm15',
    categories: ['c4'],
    title: 'Bretzel con Obatzda',
    subtitle: 'L\'aperitivo bavarese per la tua Oktoberfest casalinga',
    description:
        'Soffici bretzel fatti in casa con la crosta scura, serviti con '
        'l\'Obatzda: la crema speziata di camembert e burro tipica bavarese.',
    imageUrl:
        'https://images.unsplash.com/photo-1548369937-47519962c11a?auto=format&fit=crop&w=800&q=80',
    duration: 90,
    servings: 6,
    complexity: Complexity.hard,
    affordability: Affordability.affordable,
    ingredients: [
      '500 g farina di forza (W280)',
      '300 ml acqua tiepida',
      '7 g lievito di birra secco',
      '10 g sale',
      '1 cucchiaio di malto d\'orzo',
      '2 l acqua per il bagno',
      '60 g bicarbonato di sodio',
      'Fiocchi di sale grosso',
      '200 g camembert maturo',
      '100 g burro morbido',
      '1 cipolla piccola tritata fine',
      'Paprika dolce, cumino, sale, pepe',
    ],
    steps: [
      'Mescolare farina, lievito, sale e malto. Aggiungere l\'acqua tiepida e impastare '
          '8 minuti fino ad ottenere un impasto liscio. Coprire e fare lievitare 1 ora.',
      'Dividere l\'impasto in 8 pezzi. Formare cordoni da 60 cm, più spessi al centro. '
          'Dare la forma a bretzel (un giro e mezzo a incrocio).',
      'Portare a ebollizione l\'acqua con il bicarbonato (ATTENZIONE: schiuma). '
          'Immergere i bretzel 30 secondi per lato. Scolare bene.',
      'Adagiare su teglia con carta forno, incidere la parte spessa e '
          'cospargere con sale grosso. Cuocere a 220 °C per 15–18 minuti.',
      'OBATZDA: lavorare il camembert a pezzetti con il burro fino ad amalgamare. '
          'Aggiungere la cipolla, paprika, cumino, sale e pepe. Mescolare bene.',
      'Servire i bretzel tiepidi con l\'Obatzda.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
    rate: 4.6,
  ),

  // ── m16: Quinoa Bowl con Avocado ─────────────────────────────────────
  Meal(
    id: 'm16',
    categories: ['c5', 'c12'],
    title: 'Buddha Bowl alla Quinoa',
    subtitle: 'Nutrimento completo in una ciotola',
    description:
        'Quinoa con verdure arrostite, ceci speziati, avocado, feta e tahini: '
        'proteine, fibre e colori in un piatto da fotografare.',
    imageUrl:
        'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=800&q=80',
    duration: 35,
    servings: 2,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: [
      '150 g quinoa',
      '1 lattina di ceci (240 g sgocciolati)',
      '1 zucchina',
      '1 peperone rosso',
      '1 avocado',
      '60 g feta sbriciolata',
      '2 cucchiai tahini',
      '1 cucchiaio succo di limone',
      'Paprika affumicata, cumino, olio evo, sale',
    ],
    steps: [
      'Risciacquare la quinoa e cuocerla in 300 ml di acqua salata per 15 minuti. '
          'Lasciare riposare coperta 5 minuti poi sgranare con una forchetta.',
      'Tagliare zucchina e peperone a dadini. Condire con olio, paprika e sale. '
          'Arrostire in forno a 200 °C per 20 minuti.',
      'Sciacquare i ceci, asciugarli bene e condire con olio, cumino e sale. '
          'Rosolare in padella a fuoco vivo per 8 minuti finché croccanti.',
      'Preparare la salsa tahini: mescolare tahini, succo di limone, '
          '2–3 cucchiai d\'acqua e un pizzico di sale.',
      'Assemblare la bowl: quinoa come base, poi verdure arrostite, ceci, '
          'avocado a fette e feta sbriciolata. Irrorare con il dressing al tahini.',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
    rate: 4.4,
  ),

  // ── m17: Insalata Greca ───────────────────────────────────────────────
  Meal(
    id: 'm17',
    categories: ['c5', 'c10', 'c12'],
    title: 'Insalata Greca',
    subtitle: 'L\'estate del Mediterraneo nel tuo piatto',
    description:
        'Pomodori maturi, cetriolo, olive Kalamata, cipolla di Tropea, origano '
        'fresco e un grande cubo di feta: semplicità mediterranea al massimo.',
    imageUrl:
        'https://images.unsplash.com/photo-1540420773420-3450ac2483bb?auto=format&fit=crop&w=800&q=80',
    duration: 10,
    servings: 4,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: [
      '4 pomodori grandi maturi',
      '1 cetriolo',
      '1 peperone verde',
      '1/2 cipolla di Tropea',
      '150 g olive Kalamata',
      '200 g feta in blocco',
      '4 cucchiai olio extravergine d\'oliva',
      'Origano essiccato, sale, pepe',
    ],
    steps: [
      'Tagliare i pomodori a spicchi, il cetriolo a mezze lune spesse 1 cm, '
          'il peperone a listarelle e la cipolla ad anelli sottili.',
      'Disporre tutte le verdure in un piatto ampio o in una ciotola capiente. '
          'Aggiungere le olive.',
      'Adagiare il blocco di feta sopra le verdure (tradizionalmente non si sbriciola).',
      'Condire con olio extravergine, origano abbondante, sale e pepe.',
      'Servire subito con pane pita o casereccio.',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
    rate: 4.5,
  ),

  // ── m18: Smoothie Bowl ────────────────────────────────────────────────
  Meal(
    id: 'm18',
    categories: ['c5', 'c7'],
    title: 'Smoothie Bowl ai Frutti di Bosco',
    subtitle: 'Una ciotola di colore che inizia la giornata',
    description:
        'Frullato denso di frutti di bosco e banana con granola croccante, '
        'cocco rapé e frutta fresca: bellissima da fotografare, buonissima da mangiare.',
    imageUrl:
        'https://images.unsplash.com/photo-1511690656952-34342bb7c2f2?auto=format&fit=crop&w=800&q=80',
    duration: 10,
    servings: 1,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: [
      '150 g frutti di bosco surgelati (mirtilli, lamponi, fragole)',
      '1 banana matura (congelata per consistenza più densa)',
      '80 ml latte di mandorla',
      '2 cucchiai yogurt greco',
      'TOPPING: granola, mirtilli freschi, fettine di banana, '
          'cocco rapé, semi di chia, miele',
    ],
    steps: [
      'Frullare i frutti di bosco surgelati, la banana congelata, il latte di mandorla '
          'e lo yogurt greco fino ad ottenere un composto denso e cremoso. '
          'Se necessario aggiungere pochissimo liquido.',
      'Versare nella ciotola.',
      'Disporre i topping a file parallele: granola, frutta fresca, cocco e '
          'semi di chia. Finire con un filo di miele.',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
    rate: 4.3,
  ),

  // ── m19: Thai Green Curry ────────────────────────────────────────────
  Meal(
    id: 'm19',
    categories: ['c6', 'c8'],
    title: 'Thai Green Curry',
    subtitle: 'Un viaggio di profumi ed erbe aromatiche',
    description:
        'Pollo con latte di cocco, pasta di curry verde fatta in casa, '
        'melanzane thai e basilico: armonico, speziato e profumato.',
    imageUrl:
        'https://images.unsplash.com/photo-1565557623262-b51c2513a641?auto=format&fit=crop&w=800&q=80',
    duration: 40,
    servings: 4,
    complexity: Complexity.challenging,
    affordability: Affordability.pricey,
    ingredients: [
      '600 g petto di pollo a bocconcini',
      '400 ml latte di cocco',
      '3 cucchiai pasta curry verde (Thai Kitchen o simile)',
      '200 g melanzane thai (o zucchine)',
      '100 g piselli',
      '2 foglie di lime kaffir',
      '1 gambo di lemongrass',
      '2 cucchiai salsa di pesce (nam pla)',
      '1 cucchiaino zucchero di palma (o di canna)',
      'Basilico thai fresco',
      'Riso basmati per servire',
    ],
    steps: [
      'In un wok o padella capiente scaldare 2 cucchiai di parte solida del latte '
          'di cocco a fuoco medio-alto fino a che "sfrigola".',
      'Rosolare la pasta di curry per 1–2 minuti finché molto profumata.',
      'Aggiungere il pollo e rosolare 3 minuti a fuoco alto.',
      'Versare il restante latte di cocco, le foglie di lime, il lemongrass schiacciato, '
          'la salsa di pesce e lo zucchero. Portare a ebollizione.',
      'Aggiungere le melanzane e i piselli. Cuocere a fuoco medio 10–12 minuti.',
      'Aggiustare il sapore: deve essere equilibrato tra piccante, '
          'acido, salato e dolce.',
      'Servire sul riso basmati cospargendo di foglie di basilico thai.',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
    rate: 4.7,
  ),

  // ── m20: Shakshuka ────────────────────────────────────────────────────
  Meal(
    id: 'm20',
    categories: ['c6', 'c7', 'c12'],
    title: 'Shakshuka',
    subtitle: 'Uova al pomodoro e spezie del Medio Oriente',
    description:
        'Uova cotte direttamente in una salsa speziata di pomodori arrostiti, '
        'peperoni e cumino: colazione o cena, sempre perfetta.',
    imageUrl:
        'https://images.unsplash.com/photo-1590846406792-0adc7f938f1d?auto=format&fit=crop&w=800&q=80',
    duration: 30,
    servings: 2,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: [
      '4 uova fresche',
      '400 g pelati',
      '1 peperone rosso',
      '1 cipolla',
      '3 spicchi d\'aglio',
      '1 cucchiaino cumino in polvere',
      '1 cucchiaino paprika affumicata',
      '1/2 cucchiaino peperoncino Cayenna',
      '2 cucchiai olio evo',
      'Prezzemolo o coriandolo fresco',
      'Feta sbriciolata (opzionale)',
      'Pane pita per servire',
    ],
    steps: [
      'Scaldare l\'olio in una padella larga con coperchio. '
          'Soffriggere cipolla e peperone a cubetti per 7–8 minuti a fuoco medio.',
      'Aggiungere l\'aglio tritato e le spezie. Cuocere 1 minuto mescolando.',
      'Aggiungere i pelati schiacciati con le mani, salare e cuocere scoperto '
          '12–15 minuti finché la salsa si addensa.',
      'Con un cucchiaio creare 4 piccole conche nella salsa. '
          'Rompere un uovo in ciascuna conca.',
      'Coprire e cuocere a fuoco basso 5–7 minuti: l\'albume deve essere rappreso '
          'ma il tuorlo ancora morbido.',
      'Cospargere di prezzemolo e feta. Servire direttamente dalla padella con pita.',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: true,
    rate: 4.6,
  ),

  // ── m21: Mango Sticky Rice ───────────────────────────────────────────
  Meal(
    id: 'm21',
    categories: ['c6', 'c11'],
    title: 'Mango Sticky Rice',
    subtitle: 'Il dessert tailandese che ti conquista al primo morso',
    description:
        'Riso glutinoso al vapore con latte di cocco dolce, mango fresco maturo '
        'e sesamo tostato: tre ingredienti, perfezione assoluta.',
    imageUrl:
        'https://images.unsplash.com/photo-1562802378-063ec186a863?auto=format&fit=crop&w=800&q=80',
    duration: 45,
    servings: 4,
    complexity: Complexity.challenging,
    affordability: Affordability.affordable,
    ingredients: [
      '300 g riso glutinoso (sweet rice)',
      '400 ml latte di cocco',
      '80 g zucchero semolato',
      '1/2 cucchiaino sale',
      '2 mango maturi',
      '1 cucchiaio sesamo tostato',
      '2 cucchiai latte di cocco (per la salsa finale)',
    ],
    steps: [
      'Sciacquare il riso più volte e tenerlo in ammollo in acqua fredda almeno 2 ore '
          '(o tutta la notte).',
      'Cuocere il riso al vapore per 20–25 minuti '
          '(in vaporiera o con uno scolapasta su pentola con acqua bollente), '
          'finché tenero e traslucido.',
      'In un pentolino sciogliere 350 ml di latte di cocco con lo zucchero e il sale '
          'a fuoco basso (non bollire). Versare sul riso caldo, mescolare bene e '
          'coprire per 20 minuti così che il riso assorba.',
      'Preparare la salsa: scaldare i restanti 50 ml di latte di cocco con '
          'un pizzico di sale e un cucchiaino di zucchero.',
      'Pelare il mango e tagliarlo a fettine sottili.',
      'Impiattare: modellare il riso in uno stampo o a mano, affiancare il mango, '
          'versare la salsa al cocco e cospargere di sesamo tostato.',
    ],
    isGlutenFree: true,
    isVegan: true,
    isVegetarian: true,
    isLactoseFree: true,
    rate: 4.8,
  ),

  // ── m22: Omelette Française ──────────────────────────────────────────
  Meal(
    id: 'm22',
    categories: ['c7', 'c9'],
    title: 'Omelette Française',
    subtitle: 'La tecnica francese che vale un corso di cucina',
    description:
        'Uova sbattute, padella calda, movimento costante e la piega perfetta: '
        'l\'omelette francese è gialla, morbida e impeccabile.',
    imageUrl:
        'https://images.unsplash.com/photo-1525351484163-7529414344d8?auto=format&fit=crop&w=800&q=80',
    duration: 10,
    servings: 1,
    complexity: Complexity.challenging,
    affordability: Affordability.affordable,
    ingredients: [
      '3 uova freschissime',
      '15 g burro',
      'Sale, pepe bianco',
      'Erbe fini (ciboulette, prezzemolo) — opzionale',
      'Emmentaler o chèvre per il ripieno — opzionale',
    ],
    steps: [
      'Sbattere le uova con sale e pepe bianco. Non montarle eccessivamente: '
          'basta che tuorli e albumi siano omogenei.',
      'Scaldare una padella antiaderente piccola (20 cm) a fuoco medio-alto. '
          'Aggiungere il burro e aspettare che smetta di schiuma.',
      'Versare le uova in padella. Con un forchettone, muovere continuamente le uova '
          'con piccoli movimenti circolari velocissimi, come per fare uno strapazzato.',
      'Non appena le uova iniziano a rapprendersi ma sono ancora lucide e morbide, '
          'smettere di mescolare. Radunare tutta l\'omelette su un lato della padella.',
      'Con un colpo secco del polso, iniziare a piegare l\'omelette su se stessa. '
          'Scivolare sul piatto con la "piega" in basso.',
      'L\'omelette deve essere dorata esternamente e leggermente baveuse all\'interno. '
          'Servire immediatamente con erbe fini.',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
    rate: 4.5,
  ),

  // ── m23: Pad Thai ────────────────────────────────────────────────────
  Meal(
    id: 'm23',
    categories: ['c8'],
    title: 'Pad Thai con Gamberi',
    subtitle: 'Il wok a casa tua, autentico come Bangkok',
    description:
        'Noodles di riso saltati con gamberi, uovo strapazzato, germogli di soia, '
        'salsa di tamarindo e arachidi sbriciolate: il fast food più buono d\'Asia.',
    imageUrl:
        'https://images.unsplash.com/photo-1569050467447-ce54b3bbc37d?auto=format&fit=crop&w=800&q=80',
    duration: 30,
    servings: 2,
    complexity: Complexity.challenging,
    affordability: Affordability.pricey,
    ingredients: [
      '200 g noodles di riso piatti (10 mm)',
      '200 g gamberi sgusciati',
      '2 uova',
      '100 g germogli di soia',
      '3 cipollotti a rondelle',
      '60 g arachidi non salate tostate',
      '3 cucchiai concentrato di tamarindo',
      '2 cucchiai salsa di pesce',
      '1 cucchiaio salsa di ostriche',
      '1 cucchiaino zucchero di palma (o di canna)',
      '2 cucchiai olio di arachidi',
      'Lime, peperoncino in polvere, coriandolo',
    ],
    steps: [
      'Reidratare i noodles in acqua tiepida per 30 minuti, poi scolare.',
      'Mescolare tamarindo, salsa di pesce, salsa di ostriche e zucchero: '
          'assaggiare per equilibrio acido/salato/dolce.',
      'Scaldare il wok a fuoco altissimo fino a che fuma. '
          'Aggiungere olio e rosolare i gamberi 2 minuti. Togliere dal wok.',
      'Nella stessa padella aggiungere i noodles scolati e la salsa. '
          'Saltare mescolando con pinze da cucina per 2–3 minuti.',
      'Spostare i noodles su un lato, strapazzare le uova nel wok vuoto, '
          'poi mescolare tutto insieme.',
      'Aggiungere i gamberi, i germogli di soia e metà dei cipollotti. '
          'Saltare 1 minuto.',
      'Impiattare e guarnire con arachidi tritate, cipollotti, coriandolo, '
          'lime e peperoncino.',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
    rate: 4.6,
  ),

  // ── m24: Salmon Sushi Rolls ──────────────────────────────────────────
  Meal(
    id: 'm24',
    categories: ['c8'],
    title: 'Salmon Maki Rolls',
    subtitle: 'Sushi casalingo: più facile di quanto credi',
    description:
        'Riso da sushi al tonno bianco, salmone fresco e avocado arrotolati '
        'nel nori: fresco, elegante e appagante.',
    imageUrl:
        'https://images.unsplash.com/photo-1553361371-9b22f78e8b1d?auto=format&fit=crop&w=800&q=80',
    duration: 60,
    servings: 2,
    complexity: Complexity.hard,
    affordability: Affordability.pricey,
    ingredients: [
      '200 g riso per sushi (giapponese a chicco corto)',
      '240 ml acqua',
      '3 cucchiai aceto di riso',
      '1 cucchiaio zucchero',
      '1/2 cucchiaino sale',
      '150 g salmone fresco sashimi-grade',
      '1/2 avocado',
      '4 fogli di alga nori',
      'Salsa di soia, wasabi, zenzero marinato',
    ],
    steps: [
      'Sciacquare il riso fino ad acqua limpida. Cuocere con 240 ml di acqua '
          'a fuoco basso coperto per 12 minuti, poi spegnere e lasciare riposare 10 minuti.',
      'Sciogliere zucchero e sale nell\'aceto di riso caldo. '
          'Versare sul riso caldo, mescolare con delicatezza con un\'spatola e '
          'raffreddare a temperatura ambiente (non in frigo).',
      'Tagliare il salmone a listarelle di 1 cm e l\'avocado a fettine.',
      'Su un tappetino di bambu avvolto in pellicola, adagiare un foglio di nori '
          '(lato lucido in sotto). Stendere il riso lasciando 2 cm liberi in cima.',
      'Posizionare salmone e avocado su una linea orizzontale al centro del riso. '
          'Arrotolare strettamente aiutandosi con il tappetino, premendo fermamente.',
      'Con un coltello molto affilato e bagnato tagliare il roll in 8 pezzi. '
          'Servire con salsa di soia, wasabi e zenzero.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
    rate: 4.5,
  ),

  // ── m25: Tonkotsu Ramen ──────────────────────────────────────────────
  Meal(
    id: 'm25',
    categories: ['c8'],
    title: 'Tonkotsu Ramen',
    subtitle: 'Il brodo ricco che scalda l\'anima',
    description:
        'Brodo di ossa di maiale cremoso e profumato, noodles di frumento, '
        'chashu pork burroso, uovo marjinato e nori. Il comfort food giapponese definitivo.',
    imageUrl:
        'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?auto=format&fit=crop&w=800&q=80',
    duration: 240,
    servings: 4,
    complexity: Complexity.hard,
    affordability: Affordability.pricey,
    ingredients: [
      '1 kg ossa di maiale (trottola + costine)',
      '300 g pancetta di maiale (per il chashu)',
      '4 nidi di noodles ramen (o spaghetti di grano duro)',
      '4 uova sode marinate (ajitsuke tamago)',
      '4 cucchiai tare (brodo concentrato): miso + mirin + salsa di soia',
      'Olio di sesamo, aglio, zenzero',
      'Cipollotto, nori, mais dolce, burro per guarnire',
    ],
    steps: [
      'BRODO: bollire le ossa in acqua 3 minuti, scolare e sciacquare. '
          'Rimettere in pentola con acqua fredda, aglio e zenzero. '
          'Portare a ebollizione poi cuocere a fuoco medio-alto per 3–4 ore, '
          'scoperta, fino ad ottenere un brodo bianco e cremoso.',
      'CHASHU: arrotolare la pancetta strettamente e legarla con spago. '
          'Rosolare da tutti i lati, poi brasare in 100 ml salsa di soia, '
          '100 ml mirin e 50 ml sake per 45 minuti a fuoco basso. '
          'Lasciare raffreddare nel liquido, poi affettare.',
      'UOVA: cuocere 6 minuti in acqua bollente, raffreddare in acqua ghiacciata, '
          'sgusciare e marinare in 3 parti salsa di soia + 1 parte mirin per 4 ore.',
      'ASSEMBLARE: scaldare il brodo filtrato a ebollizione. '
          'Cuocere i noodles separatamente. In ogni ciotola mettere il tare, '
          'versare il brodo bollente, i noodles, il chashu affettato, '
          'l\'uovo dimezzato, nori e cipollotto.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
    rate: 4.9,
  ),

  // ── m26: Salmon Teriyaki ─────────────────────────────────────────────
  Meal(
    id: 'm26',
    categories: ['c8', 'c5'],
    title: 'Salmon Teriyaki',
    subtitle: 'Dolce, salato e lucente come lacca',
    description:
        'Filetto di salmone laccato con salsa teriyaki fatta in casa, riso al vapore '
        'ed edamame: cena leggera e raffinata in 20 minuti.',
    imageUrl:
        'https://images.unsplash.com/photo-1467003909585-2f8a72700288?auto=format&fit=crop&w=800&q=80',
    duration: 20,
    servings: 2,
    complexity: Complexity.simple,
    affordability: Affordability.pricey,
    ingredients: [
      '2 filetti di salmone (180 g caduno)',
      '3 cucchiai salsa di soia',
      '2 cucchiai mirin',
      '1 cucchiaio sake (o vino bianco secco)',
      '1 cucchiaino zucchero di canna',
      '1 cucchiaino amido di mais (per addensare)',
      'Semi di sesamo, cipollotto',
      'Riso al vapore e edamame per servire',
    ],
    steps: [
      'Mescolare salsa di soia, mirin, sake e zucchero in un pentolino. '
          'Scaldare a fuoco basso. Sciogliere l\'amido in 1 cucchiaio di acqua fredda '
          'e aggiungere alla salsa, mescolando finché si addensa. Tenere da parte.',
      'Asciugare bene i filetti di salmone con carta da cucina.',
      'Scaldare un filo d\'olio in una padella antiaderente a fuoco medio-alto. '
          'Cuocere il salmone lato pelle giù per 4 minuti, finché la pelle è croccante.',
      'Girare il filetto e cuocere altri 2 minuti. '
          'Versare la salsa teriyaki nella padella laccare il pesce da tutti i lati '
          'con un pennello da cucina.',
      'Servire sul riso, cospargere di sesamo e cipollotto. Affiancare gli edamame.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
    rate: 4.6,
  ),

  // ── m27: Crème Brûlée ────────────────────────────────────────────────
  Meal(
    id: 'm27',
    categories: ['c9', 'c11'],
    title: 'Crème Brûlée',
    subtitle: 'Il crack dello zucchero che aspetti tutto il pasto',
    description:
        'Crema alla vaniglia Bourbon stracotta nel forno a bagnomaria, '
        'con una superficie di zucchero caramellato bruciato al cannello.',
    imageUrl:
        'https://images.unsplash.com/photo-1615937657715-bc7b4b7962c1?auto=format&fit=crop&w=800&q=80',
    duration: 60,
    servings: 4,
    complexity: Complexity.challenging,
    affordability: Affordability.affordable,
    ingredients: [
      '500 ml panna fresca',
      '6 tuorli',
      '100 g zucchero semolato',
      '1 baccello di vaniglia Bourbon',
      'Zucchero di canna (per caramellare)',
    ],
    steps: [
      'Aprire il baccello di vaniglia e raschiare i semi. '
          'Scaldare la panna con baccello e semi fino a quasi ebollizione. '
          'Far riposare 15 minuti per infusione.',
      'Sbattere i tuorli con lo zucchero finché chiari e spumosi. '
          'Aggiungere lentamente la panna calda (senza baccello), mescolando.',
      'Filtrare il composto con un colino. Distribuire nelle ramequin.',
      'Mettere le ramequin in una teglia profonda. Versare acqua calda nella teglia '
          'fino a metà delle ramequin (bagnomaria). '
          'Cuocere a 150 °C per 35–40 minuti: la crema deve essere rappresa ai bordi '
          'e ancora leggermente tremolante al centro.',
      'Raffreddare a temperatura ambiente poi refrigerare almeno 2 ore.',
      'Prima di servire, cospargere con uno strato uniforme di zucchero di canna '
          'e caramellare con il cannello da cucina fino a ottenere una crosta ambrata.',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
    rate: 4.8,
  ),

  // ── m28: Croissant al Burro ──────────────────────────────────────────
  Meal(
    id: 'm28',
    categories: ['c9'],
    title: 'Croissant al Burro',
    subtitle: 'Friabile, sfogliato, burroso: il croissant perfetto',
    description:
        'Il re della boulangerie francese: impasto incassato 27 volte con burro '
        'AOC, una luna di sfoglia fragrante che ha il sapore del Paradiso.',
    imageUrl:
        'https://images.unsplash.com/photo-1555507036-ab1f4038808a?auto=format&fit=crop&w=800&q=80',
    duration: 480,
    servings: 8,
    complexity: Complexity.hard,
    affordability: Affordability.affordable,
    ingredients: [
      '500 g farina di forza (W320)',
      '280 ml latte intero',
      '10 g lievito di birra fresco',
      '10 g sale',
      '50 g zucchero',
      '40 g burro morbido (per l\'impasto)',
      '280 g burro di qualità per la sfogliatura (82% di grassi)',
      '1 tuorlo + 1 cucchiaio di latte per la doratura',
    ],
    steps: [
      'Impastare farina, latte tiepido, lievito, zucchero, sale e 40 g di burro '
          'per 8 minuti. Formare un rettangolo, coprire con pellicola e '
          'refrigerare tutta la notte.',
      'Mallare il burro da sfogliatura tra due fogli di carta forno formando '
          'un quadrato di 20 cm. Raffreddare.',
      'Stendere l\'impasto in un rettangolo doppio del burro. '
          'Avvolgere il burro nell\'impasto come una busta e sigillare i bordi.',
      'Stendere e piegare a tre (piega semplice): fare 3 volte, '
          'refrigerando 30 minuti tra una piega e l\'altra.',
      'Stendere a 4 mm di spessore, tagliare triangoli isosceli allungati (10 × 20 cm). '
          'Incidere la base e arrotolare strettamente verso la punta.',
      'Piegare le estremità verso l\'interno per dare la forma a mezzaluna. '
          'Adagiare su teglia con carta forno, coprire e lievitare 2–3 ore '
          '(devono quasi raddoppiare e sembrare tremolanti).',
      'Spennellare delicatamente con tuorlo e latte. '
          'Cuocere a 180 °C per 18–20 minuti finché dorati e gonfi.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
    rate: 4.9,
  ),

  // ── m29: Gazpacho ────────────────────────────────────────────────────
  Meal(
    id: 'm29',
    categories: ['c10', 'c12'],
    title: 'Gazpacho Andaluz',
    subtitle: 'La zuppa fredda più rinfrescante dell\'estate',
    description:
        'Pomodori maturi, cetriolo, peperone rosso, aglio e pane bagnato: '
        'frullato, filtrato e ghiacciato. La Spagna in un bicchiere.',
    imageUrl:
        'https://images.unsplash.com/photo-1540189549336-e11a5f4a7ea9?auto=format&fit=crop&w=800&q=80',
    duration: 20,
    servings: 4,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: [
      '1 kg pomodori maturi (varietà cuore di bue o roma)',
      '1 cetriolo',
      '1 peperone rosso',
      '2 spicchi d\'aglio',
      '60 g pane raffermo',
      '5 cucchiai olio extravergine di alta qualità',
      '2 cucchiai aceto di Jerez (o aceto bianco)',
      'Sale e pepe',
      'Ghiaccio per servire',
    ],
    steps: [
      'Spezzettare grossolanamente il pane e bagnarlo in acqua fredda per 5 minuti.',
      'Tagliare a pezzi grossolani i pomodori, il cetriolo (sbucciato), '
          'il peperone, l\'aglio. Mettere tutto nel frullatore.',
      'Aggiungere il pane strizzato, l\'olio, l\'aceto e il sale.',
      'Frullare a velocità massima per 2–3 minuti fino ottenere una crema liscia.',
      'Passare al colino a maglie medie premendo con un cucchiaio per estrarre tutto il succo. '
          'Scartare i residui.',
      'Assaggiare e aggiustare di sale, aceto e olio.',
      'Refrigerare almeno 2 ore. Servire freddissimo con cubetti di ghiaccio '
          'e una guarnizione di verdure tritate finissime come il "tropezón".',
    ],
    isGlutenFree: false,
    isVegan: true,
    isVegetarian: true,
    isLactoseFree: true,
    rate: 4.4,
  ),

  // ── m30: Caprese ─────────────────────────────────────────────────────
  Meal(
    id: 'm30',
    categories: ['c1', 'c5', 'c10'],
    title: 'Caprese al Profumo di Basilico',
    subtitle: 'Rosso, bianco, verde: l\'Italia in tre colori',
    description:
        'Fette di pomodoro cuore di bue e mozzarella di bufala, basilico fresco '
        'e il miglior olio evo che hai in casa. Perfetta.',
    imageUrl:
        'https://images.unsplash.com/photo-1592417817098-8fd3d2eb2e17?auto=format&fit=crop&w=800&q=80',
    duration: 10,
    servings: 2,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: [
      '4 pomodori cuore di bue maturi',
      '250 g mozzarella di bufala campana',
      'Foglie di basilico fresco abbondante',
      'Olio extravergine di oliva di alta qualità',
      'Sale di Maldon (o sale grosso)',
      'Pepe nero macinato fresco',
      'Aceto balsamico di Modena (opzionale)',
    ],
    steps: [
      'Togliere la mozzarella dal siero e tamponarla con carta assorbente.',
      'Tagliare i pomodori a fette di 1 cm. Fare lo stesso con la mozzarella.',
      'Alternare le fette di pomodoro e mozzarella in modo sovrapposto '
          'su un piatto da portata.',
      'Cospargere generosamente di foglie di basilico fresco.',
      'Condire con olio extravergine, sale di Maldon e pepe. '
          'Se piace, aggiungere un filo di aceto balsamico.',
      'Lasciare riposare 5 minuti a temperatura ambiente prima di servire '
          '(non mettere in frigorifero: rovinerebbe la consistenza della mozzarella).',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
    rate: 4.7,
  ),

  // ── m31: Hummus con Pita ─────────────────────────────────────────────
  Meal(
    id: 'm31',
    categories: ['c2', 'c12'],
    title: 'Hummus Fatto in Casa',
    subtitle:
        'Cremoso, profumato e infinitamente migliore di quello in vasetto',
    description:
        'Ceci lessati, tahini, aglio, limone e ghiaccio: il segreto dell\'hummus '
        'vellutato del Libano è nella semplicità degli ingredienti di qualità.',
    imageUrl:
        'https://images.unsplash.com/photo-1604313030930-edd544c5db50?auto=format&fit=crop&w=800&q=80',
    duration: 20,
    servings: 6,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: [
      '400 g ceci lessati (o una lattina)',
      '60 g tahini',
      '2 spicchi d\'aglio',
      '50 ml succo di limone fresco',
      '50 ml acqua ghiacciata',
      '1/2 cucchiaino cumino in polvere',
      'Sale',
      'Paprika affumicata, olio evo, prezzemolo per guarnire',
      'Pane pita per servire',
    ],
    steps: [
      'Se usi i ceci in lattina: sciacquarli bene. '
          'Per un risultato ancora più vellutato, lessarli 10 minuti extra e '
          'rimuovere la pellicina esterna sfregandoli tra le mani.',
      'Nel frullatore, mettere l\'aglio, il succo di limone e il tahini. '
          'Frullare 1 minuto: la miscela diventerà bianca e cremosa.',
      'Aggiungere i ceci, il cumino, il sale e l\'acqua ghiacciata. '
          'Frullare a velocità massima per 2–3 minuti, aggiungendo altra acqua '
          'se troppo denso.',
      'Assaggiare e correggere di sale e limone.',
      'Impiattare in una ciotola, creare un avvallamento al centro con un cucchiaio, '
          'versare olio evo, cospargere di paprika e prezzemolo.',
      'Servire con pita calda o verdure crude.',
    ],
    isGlutenFree: true,
    isVegan: true,
    isVegetarian: true,
    isLactoseFree: true,
    rate: 4.5,
  ),

  // ── m32: Chocolate Lava Cake ─────────────────────────────────────────
  Meal(
    id: 'm32',
    categories: ['c11'],
    title: 'Chocolate Lava Cake',
    subtitle: 'Il vulcano di cioccolato che ti fa perdere la testa',
    description:
        'Tortino al cioccolato fondente 70% con cuore liquido caldo: crosta '
        'sottile e fondente, centro che cola lentamente nel piatto.',
    imageUrl:
        'https://images.unsplash.com/photo-1578985545062-e79f13d0be54?auto=format&fit=crop&w=800&q=80',
    duration: 25,
    servings: 4,
    complexity: Complexity.challenging,
    affordability: Affordability.affordable,
    ingredients: [
      '150 g cioccolato fondente 70%',
      '100 g burro',
      '3 uova + 3 tuorli',
      '100 g zucchero a velo',
      '40 g farina 00',
      'Burro e cacao per gli stampi',
      'Gelato alla vaniglia per servire',
    ],
    steps: [
      'Ungere 4 stampini da 150 ml con burro e spolverare di cacao, '
          'eliminare l\'eccesso. Refrigerare.',
      'Sciogliere cioccolato e burro a bagnomaria (o microonde a 800W in intervalli '
          'di 30 secondi). Mescolare fino a crema liscia e lucida. Lasciare intiepidire.',
      'In una ciotola capiente sbattere uova, tuorli e zucchero a velo '
          'fino ad ottenere un composto chiaro e spumoso.',
      'Incorporare il cioccolato fuso, poi la farina setacciata, '
          'mescolando con una spatola.',
      'Distribuire il composto negli stampini (non riempire oltre i 3/4). '
          'Refrigerare 30 minuti (possono rimanere in frigo fino a 24 ore).',
      'Cuocere a 200 °C per 10–12 minuti: i bordi devono essere solidi '
          'e il centro ancora mosso. Capovolgere subito sul piatto.',
      'Servire immediatamente con una pallina di gelato alla vaniglia.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
    rate: 4.9,
  ),

  // ── m33: Chicken Tikka Masala ────────────────────────────────────────
  Meal(
    id: 'm33',
    categories: ['c6'],
    title: 'Chicken Tikka Masala',
    subtitle: 'Il curry più famoso del mondo, a casa tua',
    description:
        'Pollo marinato nello yogurt, grigliato allo skewer e poi immerso '
        'in una salsa creosa di pomodoro, panna e spezie indiane tostate.',
    imageUrl:
        'https://images.unsplash.com/photo-1565557623262-b51c2513a641?auto=format&fit=crop&w=800&q=80',
    duration: 60,
    servings: 4,
    complexity: Complexity.challenging,
    affordability: Affordability.pricey,
    ingredients: [
      '700 g petto di pollo a bocconcini',
      '150 g yogurt intero',
      '2 cucchiai tandoori masala (in polvere)',
      '2 cucchiai garam masala',
      '1 cucchiaino curcuma',
      '1 cipolla grande',
      '4 spicchi d\'aglio',
      '2 cm radice di zenzero fresco',
      '400 g pelati',
      '150 ml panna fresca',
      '2 cucchiai burro chiarificato (ghee)',
      'Coriandolo fresco, riso basmati',
    ],
    steps: [
      'Marinare il pollo nel mix di yogurt, tandoori masala, 1 cucchiaino di garam masala, '
          'curcuma e sale. Coprire e refrigerare almeno 2 ore (meglio tutta la notte).',
      'Grigliare il pollo marinato in forno a 220 °C o in padella grill '
          'a fuoco alto finché leggermente carbonizzato sui bordi. Tenere da parte.',
      'Sciogliere il ghee in una casseruola. Rosolare la cipolla tritata finemente '
          '10 minuti a fuoco medio. Aggiungere aglio e zenzero grattugiato, cuocere 2 minuti.',
      'Aggiungere il garam masala restante e cuocere le spezie 1 minuto mescolando.',
      'Versare i pelati, schiacciare e cuocere 15 minuti.',
      'Frullare parzialmente la salsa per renderla più liscia, poi aggiungere la panna. '
          'Cuocere altri 5 minuti.',
      'Unire il pollo grigliato alla salsa e cuocere 5 minuti. '
          'Servire sul riso basmati con foglie di coriandolo.',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: false,
    rate: 4.8,
  ),

  // ── m34: Banana Bread ────────────────────────────────────────────────
  Meal(
    id: 'm34',
    categories: ['c2', 'c7', 'c11'],
    title: 'Banana Bread',
    subtitle: 'Il modo più goloso di usare le banane mature',
    description:
        'Pane dolce umido e profumato con banane nere, noci pecan e un tocco di '
        'cannella: la colazione che profuma tutta la casa.',
    imageUrl:
        'https://images.unsplash.com/photo-1558961363-fa8fdf82db35?auto=format&fit=crop&w=800&q=80',
    duration: 70,
    servings: 8,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: [
      '3 banane molto mature (con buccia nera)',
      '190 g farina 00',
      '120 g zucchero di canna',
      '2 uova',
      '80 ml olio di semi di girasole',
      '1 cucchiaino lievito in polvere',
      '1/2 cucchiaino bicarbonato',
      '1 cucchiaino cannella',
      '1 pizzico di sale',
      '80 g noci o noci pecan tritate',
    ],
    steps: [
      'Preriscaldare il forno a 175 °C. Ungere e infarinare uno stampo da plumcake.',
      'In una ciotola grande schiacciare le banane con una forchetta '
          'fino ad ottenere una purea con qualche grumo.',
      'Aggiungere uova, olio e zucchero alle banane. Mescolare bene.',
      'Setacciare farina, lievito, bicarbonato, cannella e sale sugli ingredienti umidi. '
          'Mescolare il minimo indispensabile per amalgamare (non lavorare troppo).',
      'Incorporare le noci tritate. Versare nello stampo.',
      'Cuocere 55–60 minuti. Verificare la cottura inserendo uno stecchino al centro: '
          'deve uscire pulito. Se la superficie si scurisce troppo, coprire con foglio di alluminio.',
      'Lasciare raffreddare nello stampo 10 minuti prima di sformare.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: true,
    rate: 4.6,
  ),
];
