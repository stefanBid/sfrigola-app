// AUTO-GENERATED — do not edit manually.
// Run:  python scripts/generate_dummy_data.py

// Project Models
import 'package:sfrigola/core/models/category.dart';
import 'package:sfrigola/core/models/meal.dart';

// ---------------------------------------------------------------------------
// Categories  (12 total)
// ---------------------------------------------------------------------------

const availableCategories = [
  Category(id: 'c1', title: 'Italian', icon: '🍕'),
  Category(id: 'c2', title: 'Street Food', icon: '🍔'),
  Category(id: 'c3', title: 'German', icon: '🥨'),
  Category(id: 'c4', title: 'Light & Healthy', icon: '🥗'),
  Category(id: 'c5', title: 'Exotic', icon: '🌴'),
  Category(id: 'c6', title: 'Breakfast', icon: '🥞'),
  Category(id: 'c7', title: 'Asian', icon: '🍜'),
  Category(id: 'c8', title: 'French', icon: '🥐'),
  Category(id: 'c9', title: 'Summer', icon: '☀️'),
  Category(id: 'c10', title: 'Desserts', icon: '🎂'),
  Category(id: 'c11', title: 'Mediterranean', icon: '🫒'),
];

// ---------------------------------------------------------------------------
// Meals  (auto-generated from TheMealDB — www.themealdb.com)
// ---------------------------------------------------------------------------

const availableMeals = [
  // ── m1: Chilli prawn linguine
  Meal(
    id: 'm1',
    categories: ['c1'],
    title: 'Chilli prawn linguine',
    subtitle: 'Ricetta di Italian — autentica e collaudata',
    description:
        'Un piatto di Italian dalla tradizione pasta: Chilli prawn linguine preparato '
        'con ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/usywpp1511189717.jpg',
    duration: 56,
    servings: 3,
    complexity: Complexity.challenging,
    affordability: Affordability.pricey,
    ingredients: [
      '280g Linguine Pasta',
      '200g Sugar Snap Peas',
      '2 tblsp Olive Oil',
      '2 cloves chopped Garlic Clove',
      '1 large Red Chilli',
      '24 Skinned King Prawns',
      '12 Cherry Tomatoes',
      'Handful Basil Leaves',
      'Leaves Lettuce',
      'to serve Bread',
    ],
    steps: [
      'Mix the dressing ingredients in a small bowl and season with salt and '
          'pepper. Set aside.',
      'Cook the pasta according to the packet instructions. Add the sugar snap peas '
          'for the last minute or so of cooking time.',
      'Meanwhile, heat the oil in a wok or large frying pan, toss in the garlic and '
          'chilli and cook over a fairly gentle heat for about 30 seconds without '
          'letting the garlic brown. Tip in the prawns and cook over a high heat, '
          'stirring frequently, for about 3 minutes until they turn pink.',
      'Add the tomatoes and cook, stirring occasionally, for 3 minutes until they '
          'just start to soften. Drain the pasta and sugar snaps well, then toss into '
          'the prawn mixture. Tear in the basil leaves, stir, and season with salt and '
          'pepper.',
      'Serve with salad leaves drizzled with the lime dressing, and warm crusty '
          'bread.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
    rate: 4.1,
  ),

  // ── m2: Fettuccine Alfredo
  Meal(
    id: 'm2',
    categories: ['c1'],
    title: 'Fettuccine Alfredo',
    subtitle: 'Ricetta di Italian — autentica e collaudata',
    description:
        'Un piatto di Italian dalla tradizione pasta: Fettuccine Alfredo preparato '
        'con ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/0jv5gx1661040802.jpg',
    duration: 46,
    servings: 2,
    complexity: Complexity.challenging,
    affordability: Affordability.affordable,
    ingredients: [
      '1 lb Fettuccine',
      '1/2 cup Heavy Cream',
      '1/2 cup Butter',
      '1/2 cup Parmesan',
      '2 tbsp Parsley',
      'Black Pepper',
    ],
    steps: [
      'Cook pasta according to package instructions in a large pot of boiling water '
          'and salt.',
      'Add heavy cream and butter to a large skillet over medium heat until the '
          'cream bubbles and the butter melts.',
      'Whisk in parmesan and add seasoning (salt and black pepper).',
      'Let the sauce thicken slightly and then add the pasta and toss until coated '
          'in sauce.',
      'Garnish with parsley, and it\'s ready.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
    rate: 4.3,
  ),

  // ── m3: Fettucine alfredo
  Meal(
    id: 'm3',
    categories: ['c1'],
    title: 'Fettucine alfredo',
    subtitle: 'Ricetta di Italian — autentica e collaudata',
    description:
        'Un piatto di Italian dalla tradizione pasta: Fettucine alfredo preparato con '
        'ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/uquqtu1511178042.jpg',
    duration: 30,
    servings: 2,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: [
      '227g Clotted Cream',
      '25g Butter',
      '1 tsp Corn Flour',
      '100g Parmesan Cheese',
      'Grated Nutmeg',
      '250g Fettuccine',
      'Chopped Parsley',
    ],
    steps: [
      'In a medium saucepan, stir the clotted cream, butter and cornflour over a '
          'low-ish heat and bring to a low simmer. Turn off the heat and keep warm.',
      'Meanwhile, put the cheese and nutmeg in a small bowl and add a good grinding '
          'of black pepper, then stir everything together (don’t add any salt at this '
          'stage).',
      'Put the pasta in another pan with 2 tsp salt, pour over some boiling water '
          'and cook following pack instructions (usually 3-4 mins). When cooked, scoop '
          'some of the cooking water into a heatproof jug or mug and drain the pasta, '
          'but not too thoroughly.',
      'Add the pasta to the pan with the clotted cream mixture, then sprinkle over '
          'the cheese and gently fold everything together over a low heat using a '
          'rubber spatula. When combined, splash in 3 tbsp of the cooking water. At '
          'first, the pasta will look wet and sloppy: keep stirring until the water is '
          'absorbed and the sauce is glossy. Check the seasoning before transferring to '
          'heated bowls. Sprinkle over some chives or parsley, then serve immediately.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
    rate: 4.3,
  ),

  // ── m4: Grilled Mac and Cheese Sandwich
  Meal(
    id: 'm4',
    categories: ['c2', 'c3'],
    title: 'Grilled Mac and Cheese Sandwich',
    subtitle: 'Ricetta di American — autentica e collaudata',
    description:
        'Un piatto di American dalla tradizione pasta: Grilled Mac and Cheese '
        'Sandwich preparato con ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/xutquv1505330523.jpg',
    duration: 82,
    servings: 4,
    complexity: Complexity.hard,
    affordability: Affordability.affordable,
    ingredients: [
      '8 ounces (230 grams) Macaroni',
      '1/3 cup Plain Flour',
      '3/4 teaspoon Mustard Powder',
      '1/2 teaspoon Garlic powder',
      '1/2 teaspoon Kosher salt',
      '1/2 teaspoon Black pepper',
      '1/8 teaspoon Cayenne pepper',
      '6 tablespoons (85 grams) Butter',
      '1 1/2 cups (360 milliliters) Whole Milk',
      '1 cup (240 milliliters) Heavy Cream',
    ],
    steps: [
      'Make the mac and cheese.',
      'Bring a medium saucepan of generously salted water (you want it to taste '
          'like seawater) to a boil. Add the pasta and cook, stirring occasionally, '
          'until al dente, 8 to 10 minutes, or according to the package directions. The '
          'pasta should be tender but still chewy.',
      'While the pasta is cooking, in a small bowl, whisk together the flour, '
          'mustard powder, garlic powder, salt, black pepper, and cayenne pepper.',
      'Drain the pasta in a colander. Place the empty pasta pan (no need to wash '
          'it) over low heat and add the butter. When the butter has melted, whisk in '
          'the flour mixture and continue to cook, whisking frequently, until the '
          'mixture is beginning to brown and has a pleasant, nutty aroma, about 1 '
          'minute. Watch carefully so it does not scorch on the bottom of the pan.',
      'Slowly whisk the milk and cream into the flour mixture until everything is '
          'really well combined. Cook, whisking constantly, until the sauce is heated '
          'through and just begins to thicken, about 2 minutes. Remove from the heat. '
          'Gradually add the cheese while stirring constantly with a wooden spoon or '
          'silicone spatula and keep stirring until the cheese has melted into the '
          'sauce. Then stir in the drained cooked pasta.',
      'Line a 9-by-13-inch (23-by-33-centimeter) rimmed baking sheet with parchment '
          'paper or aluminum foil. Coat the paper or foil with nonstick cooking spray '
          'or slick it with butter. Pour the warm mac and cheese onto the prepared '
          'baking sheet and spread it evenly with a spatula. Coat another piece of '
          'parchment paper with cooking spray or butter and place it, oiled or buttered '
          'side down, directly on the surface of the mac and cheese. Refrigerate until '
          'cool and firm, about 1 hour. Make the grilled cheese.',
      'Heat a large cast-iron or nonstick skillet over medium-low heat.',
      'In a small bowl, stir together the 4 tablespoons (55 grams) butter and '
          'garlic powder until well blended.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
    rate: 4.5,
  ),

  // ── m5: Lasagna Sandwiches
  Meal(
    id: 'm5',
    categories: ['c2', 'c3'],
    title: 'Lasagna Sandwiches',
    subtitle: 'Ricetta di American — autentica e collaudata',
    description:
        'Un piatto di American dalla tradizione pasta: Lasagna Sandwiches preparato '
        'con ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/xr0n4r1576788363.jpg',
    duration: 32,
    servings: 2,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: [
      '1/4 cup Sour Cream',
      '2 tbs Chopped Onion',
      '1/2 tbs Dried Oregano',
      '1/4 tsp Salt',
      '8 slices Bread',
      '8 slices Bacon',
      '8 slices Tomato',
      '4 slices Mozzarella',
      '2 1/2 Tbs Butter',
    ],
    steps: [
      'In a small bowl, combine the first four ingredients; spread on four slices '
          'of bread. Layer with bacon, tomato and cheese; top with remaining bread.',
      'In a large skillet or griddle, melt 2 tablespoons butter. Toast sandwiches '
          'until lightly browned on both sides and cheese is melted, adding butter if '
          'necessary. Nutrition Facts 1 sandwich: 445 calories, 24g fat (12g saturated '
          'fat), 66mg cholesterol, 1094mg sodium, 35g carbohydrate (3g sugars, 2g '
          'fiber), 21g protein.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: false,
    rate: 3.8,
  ),

  // ── m6: Lasagne
  Meal(
    id: 'm6',
    categories: ['c1'],
    title: 'Lasagne',
    subtitle: 'Ricetta di Italian — autentica e collaudata',
    description:
        'Un piatto di Italian dalla tradizione pasta: Lasagne preparato con '
        'ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/wtsvxx1511296896.jpg',
    duration: 59,
    servings: 5,
    complexity: Complexity.challenging,
    affordability: Affordability.affordable,
    ingredients: [
      '1 tblsp Olive Oil',
      '2 Bacon',
      '1 finely chopped Onion',
      '1 Stick Celery',
      '1 medium Carrots',
      '2 cloves chopped Garlic',
      '500g Minced Beef',
      '1 tbls Tomato Puree',
      '800g Chopped Tomatoes',
      '1 tblsp Honey',
    ],
    steps: [
      'Heat the oil in a large saucepan. Use kitchen scissors to snip the bacon '
          'into small pieces, or use a sharp knife to chop it on a chopping board. Add '
          'the bacon to the pan and cook for just a few mins until starting to turn '
          'golden. Add the onion, celery and carrot, and cook over a medium heat for 5 '
          'mins, stirring occasionally, until softened.',
      'Add the garlic and cook for 1 min, then tip in the mince and cook, stirring '
          'and breaking it up with a wooden spoon, for about 6 mins until browned all '
          'over.',
      'Stir in the tomato purée and cook for 1 min, mixing in well with the beef '
          'and vegetables. Tip in the chopped tomatoes. Fill each can half full with '
          'water to rinse out any tomatoes left in the can, and add to the pan. Add the '
          'honey and season to taste. Simmer for 20 mins.',
      'Heat oven to 200C/180C fan/gas 6. To assemble the lasagne, ladle a little of '
          'the ragu sauce into the bottom of the roasting tin or casserole dish, '
          'spreading the sauce all over the base. Place 2 sheets of lasagne on top of '
          'the sauce overlapping to make it fit, then repeat with more sauce and '
          'another layer of pasta. Repeat with a further 2 layers of sauce and pasta, '
          'finishing with a layer of pasta.',
      'Put the crème fraîche in a bowl and mix with 2 tbsp water to loosen it and '
          'make a smooth pourable sauce. Pour this over the top of the pasta, then top '
          'with the mozzarella. Sprinkle Parmesan over the top and bake for 25–30 mins '
          'until golden and bubbling. Serve scattered with basil, if you like.',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
    rate: 4.4,
  ),

  // ── m7: Bread omelette
  Meal(
    id: 'm7',
    categories: ['c6'],
    title: 'Bread omelette',
    subtitle: 'Ricetta di Indian — autentica e collaudata',
    description:
        'Un piatto di Indian dalla tradizione breakfast: Bread omelette preparato con '
        'ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/hqaejl1695738653.jpg',
    duration: 24,
    servings: 5,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: ['2 Bread', '2 Egg', '0.5 Salt'],
    steps: ['Make and enjoy'],
    isGlutenFree: false,
    isVegan: true,
    isVegetarian: true,
    isLactoseFree: true,
    rate: 4.0,
  ),

  // ── m8: Breakfast Potatoes
  Meal(
    id: 'm8',
    categories: ['c7'],
    title: 'Breakfast Potatoes',
    subtitle: 'Ricetta di Canadian — autentica e collaudata',
    description:
        'Un piatto di Canadian dalla tradizione breakfast: Breakfast Potatoes '
        'preparato con ingredienti genuini e tecnica consolidata.',
    imageUrl: 'https://www.themealdb.com/images/media/meals/1550441882.jpg',
    duration: 85,
    servings: 2,
    complexity: Complexity.hard,
    affordability: Affordability.affordable,
    ingredients: [
      '3 Medium Potatoes',
      '1 tbs Olive Oil',
      '2 strips Bacon',
      'Minced Garlic Clove',
      '1 tbs Maple Syrup',
      'Garnish Parsley',
      'Pinch Salt',
      'Pinch Pepper',
      'To taste Allspice',
    ],
    steps: [
      'Before you do anything, freeze your bacon slices that way when you\'re ready '
          'to prep, it\'ll be so much easier to chop!',
      'Wash the potatoes and cut medium dice into square pieces. To prevent any '
          'browning, place the already cut potatoes in a bowl filled with water.',
      'In the meantime, heat 1-2 tablespoons of oil in a large skillet over '
          'medium-high heat. Tilt the skillet so the oil spreads evenly.',
      'Once the oil is hot, drain the potatoes and add to the skillet. Season with '
          'salt, pepper, and Old Bay as needed.',
      'Cook for 10 minutes, stirring the potatoes often, until brown. If needed, '
          'add a tablespoon more of oil.',
      'Chop up the bacon and add to the potatoes. The bacon will start to render '
          'and the fat will begin to further cook the potatoes. Toss it up a bit! The '
          'bacon will take 5-6 minutes to crisp.',
      'Once the bacon is cooked, reduce the heat to medium-low, add the minced '
          'garlic and toss. Season once more. Add dried or fresh parsley. Control heat '
          'as needed.',
      'Let the garlic cook until fragrant, about one minute.',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
    rate: 4.1,
  ),

  // ── m9: Dutch poffertjes (mini pancakes)
  Meal(
    id: 'm9',
    categories: ['c7'],
    title: 'Dutch poffertjes (mini pancakes)',
    subtitle: 'Ricetta di Dutch — autentica e collaudata',
    description:
        'Un piatto di Dutch dalla tradizione breakfast: Dutch poffertjes (mini '
        'pancakes) preparato con ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/oaqz9f1766593912.jpg',
    duration: 66,
    servings: 6,
    complexity: Complexity.challenging,
    affordability: Affordability.affordable,
    ingredients: [
      '125g Flour',
      '125g Buckwheat Flour',
      '2 Eggs',
      '1 knob Butter',
      '300ml Milk',
      '10g Yeast',
      '1tsp vanilla sugar',
      'To serve Butter',
      'To serve Icing Sugar',
    ],
    steps: [
      'Mix the dry yeast with some of the luke warm milk en stir until dissolved.',
      'Place buckwheat and the flour together in a bowl and make a small circle in '
          'the middle. Add the yeast mixture into it. Add the milk and stir until you '
          'have a smooth batter.',
      'Add the eggs, salt and vanille sugar and stir through. Leave to stand and '
          'rise for about 45 minutes.',
      'Heat the poffertjespan and add a bit of butter into each hole. Fill halfway '
          'with batter and first bake one side until you can see the top dry out a '
          'little. Turn the poffertjes around with a small fork and bake the other side '
          'until cooked and golden brown.',
      'Serve the poffertjes with butter and icing sugar.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
    rate: 4.2,
  ),

  // ── m10: English Breakfast
  Meal(
    id: 'm10',
    categories: ['c7'],
    title: 'English Breakfast',
    subtitle: 'Ricetta di British — autentica e collaudata',
    description:
        'Un piatto di British dalla tradizione breakfast: English Breakfast preparato '
        'con ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/utxryw1511721587.jpg',
    duration: 80,
    servings: 3,
    complexity: Complexity.hard,
    affordability: Affordability.affordable,
    ingredients: [
      '2 Sausages',
      '3 Bacon',
      '2 Mushrooms',
      '2 Tomatoes',
      '1 Slice Black Pudding',
      '2 Eggs',
      '1 Slice Bread',
    ],
    steps: [
      'Heat the flat grill plate over a low heat, on top of 2 rings/flames if it '
          'fits, and brush sparingly with light olive oil.',
      'Cook the sausages first. Add the sausages to the hot grill plate/the coolest '
          'part if there is one and allow to cook slowly for about 15-20 minutes, '
          'turning occasionally, until golden. After the first 10 minutes, increase the '
          'heat to medium before beginning to cook the other ingredients. If you are '
          'struggling for space, completely cook the sausages and keep hot on a plate '
          'in the oven.',
      'Snip a few small cuts into the fatty edge of the bacon. Place the bacon '
          'straight on to the grill plate and fry for 2-4 minutes each side or until '
          'your preferred crispiness is reached. Like the sausages, the cooked bacon '
          'can be kept hot on a plate in the oven.',
      'For the mushrooms, brush away any dirt using a pastry brush and trim the '
          'stalk level with the mushroom top. Season with salt and pepper and drizzle '
          'over a little olive oil. Place stalk-side up on the grill plate and cook for '
          '1-2 minutes before turning and cooking for a further 3-4 minutes. Avoid '
          'moving the mushrooms too much while cooking, as this releases the natural '
          'juices, making them soggy.',
      'For the tomatoes, cut the tomatoes across the centre/or in half lengthways '
          'if using plum tomatoes , and with a small, sharp knife remove the green '
          '\'eye\'. Season with salt and pepper and drizzle with a little olive oil. '
          'Place cut-side down on the grill plate and cook without moving for 2 '
          'minutes. Gently turn over and season again. Cook for a further 2-3 minutes '
          'until tender but still holding their shape.',
      'For the black pudding, cut the black pudding into 3-4 slices and remove the '
          'skin. Place on the grill plate and cook for 1½-2 minutes each side until '
          'slightly crispy.',
      'For \'proper\' fried bread it\'s best to cook it in a separate pan. Ideally, '
          'use bread that is a couple of days old. Heat a frying pan to a medium heat '
          'and cover the base with oil. Add the bread and cook for 2-3 minutes each '
          'side until crispy and golden. If the pan becomes too dry, add a little more '
          'oil. For a richer flavour, add a knob of butter after you turn the slice.',
      'For the fried eggs, break the egg straight into the pan with the fried bread '
          'and leave for 30 seconds. Add a good knob of butter and lightly splash/baste '
          'the egg with the butter when melted. Cook to your preferred stage, season '
          'and gently remove with a fish slice.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
    rate: 4.8,
  ),

  // ── m11: Fruit and Cream Cheese Breakfast Pastries
  Meal(
    id: 'm11',
    categories: ['c2', 'c3'],
    title: 'Fruit and Cream Cheese Breakfast Pastries',
    subtitle: 'Ricetta di American — autentica e collaudata',
    description:
        'Un piatto di American dalla tradizione breakfast: Fruit and Cream Cheese '
        'Breakfast Pastries preparato con ingredienti genuini e tecnica consolidata.',
    imageUrl: 'https://www.themealdb.com/images/media/meals/1543774956.jpg',
    duration: 39,
    servings: 6,
    complexity: Complexity.challenging,
    affordability: Affordability.affordable,
    ingredients: [
      '1 1/4 oz Cream Cheese',
      '1 1/4 cup Sugar',
      '1 teaspoon Vanilla Extract',
      'Flour',
      '2 Puff Pastry',
      'Strawberries',
      'Raspberries',
      'Blackberries',
    ],
    steps: [
      'Preheat oven to 400ºF (200ºC), and prepare two cookie sheets with parchment '
          'paper. In a bowl, mix cream cheese, sugar, and vanilla until fully combined. '
          'Lightly flour the surface and roll out puff pastry on top to flatten. Cut '
          'each sheet of puff pastry into 9 equal squares. On the top right and bottom '
          'left of the pastry, cut an L shape approximately ½ inch (1 cm) from the '
          'edge.',
      'NOTE: This L shape should reach all the way down and across the square, '
          'however both L shapes should not meet at the ends. Your pastry should look '
          'like a picture frame with two corners still intact.',
      'Take the upper right corner and fold down towards the inner bottom corner. '
          'You will now have a diamond shape.',
      'Place 1 to 2 teaspoons of the cream cheese filling in the middle, then place '
          'berries on top.',
      'Repeat with the remaining pastry squares and place them onto the parchment '
          'covered baking sheet.',
      'Bake for 15-20 minutes or until pastry is golden brown and puffed.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
    rate: 4.3,
  ),

  // ── m12: Full English Breakfast
  Meal(
    id: 'm12',
    categories: ['c7'],
    title: 'Full English Breakfast',
    subtitle: 'Ricetta di British — autentica e collaudata',
    description:
        'Un piatto di British dalla tradizione breakfast: Full English Breakfast '
        'preparato con ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/sqrtwu1511721265.jpg',
    duration: 120,
    servings: 3,
    complexity: Complexity.hard,
    affordability: Affordability.affordable,
    ingredients: [
      '4 Sausages',
      '4 Bacon',
      '4 Mushrooms',
      '3 Tomatoes',
      '2 sliced Black Pudding',
      '2 Eggs',
      '1 Slice Bread',
      '100g Baked Beans',
    ],
    steps: [
      'Heat the flat grill plate over a low heat, on top of 2 rings/flames if it '
          'fits, and brush sparingly with light olive oil.',
      'Cook the sausages first. Add the sausages to the hot grill plate/the coolest '
          'part if there is one and allow to cook slowly for about 15-20 minutes, '
          'turning occasionally, until golden. After the first 10 minutes, increase the '
          'heat to medium before beginning to cook the other ingredients. If you are '
          'struggling for space, completely cook the sausages and keep hot on a plate '
          'in the oven.',
      'Snip a few small cuts into the fatty edge of the bacon. Place the bacon '
          'straight on to the grill plate and fry for 2-4 minutes each side or until '
          'your preferred crispiness is reached. Like the sausages, the cooked bacon '
          'can be kept hot on a plate in the oven.',
      'For the mushrooms, brush away any dirt using a pastry brush and trim the '
          'stalk level with the mushroom top. Season with salt and pepper and drizzle '
          'over a little olive oil. Place stalk-side up on the grill plate and cook for '
          '1-2 minutes before turning and cooking for a further 3-4 minutes. Avoid '
          'moving the mushrooms too much while cooking, as this releases the natural '
          'juices, making them soggy.',
      'For the tomatoes, cut the tomatoes across the centre/or in half lengthways '
          'if using plum tomatoes , and with a small, sharp knife remove the green '
          '\'eye\'. Season with salt and pepper and drizzle with a little olive oil. '
          'Place cut-side down on the grill plate and cook without moving for 2 '
          'minutes. Gently turn over and season again. Cook for a further 2-3 minutes '
          'until tender but still holding their shape.',
      'For the black pudding, cut the black pudding into 3-4 slices and remove the '
          'skin. Place on the grill plate and cook for 1½-2 minutes each side until '
          'slightly crispy.',
      'For \'proper\' fried bread it\'s best to cook it in a separate pan. Ideally, '
          'use bread that is a couple of days old. Heat a frying pan to a medium heat '
          'and cover the base with oil. Add the bread and cook for 2-3 minutes each '
          'side until crispy and golden. If the pan becomes too dry, add a little more '
          'oil. For a richer flavour, add a knob of butter after you turn the slice.',
      'For the fried eggs, break the egg straight into the pan with the fried bread '
          'and leave for 30 seconds. Add a good knob of butter and lightly splash/baste '
          'the egg with the butter when melted. Cook to your preferred stage, season '
          'and gently remove with a fish slice.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
    rate: 4.1,
  ),

  // ── m13: Æbleskiver
  Meal(
    id: 'm13',
    categories: ['c11'],
    title: 'Æbleskiver',
    subtitle: 'Ricetta di Norwegian — autentica e collaudata',
    description:
        'Un piatto di Norwegian dalla tradizione dessert: Æbleskiver preparato con '
        'ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/wkhg581762773124.jpg',
    duration: 51,
    servings: 3,
    complexity: Complexity.challenging,
    affordability: Affordability.affordable,
    ingredients: [
      '2 cups Flour',
      '1 teaspoon Salt',
      '2 tblsp Granulated Sugar',
      '1 teaspoon Baking Powder',
      '1/2 teaspoon Cardamom',
      '3 Egg',
      '2 cups Buttermilk',
      'For Greasing Butter',
      'Sprinkling Powdered Sugar',
      '1 scoop Raspberry Jam',
    ],
    steps: [
      'Whisk the flour, salt, sugar, baking soda, and cardamom together in a large '
          'bowl.',
      'Separate the eggs and add the egg yolks to the flour mixture. Pour in the '
          'buttermilk (or cultured milk) and whisk the batter together until smooth. '
          'Cover and refrigerate for about 30 minutes.',
      'Use a hand (or stand) mixer to beat the egg whites until stiff. Carefully '
          'fold into the æbleskiver batter.',
      'Heat the pan on medium heat. Once hot, brush the pan with butter and fill '
          'each æbleskive hole almost full with the batter.',
      'Once the edges become firm use a knitting needle or wooden skewer to turn '
          'the æbleskiver about 1/4. Continue turning until you get round pancake '
          'spheres. They should be golden brown.',
      'Remove the æbleskiver from the pan and serve with powdered sugar and jam.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
    rate: 4.3,
  ),

  // ── m14: Alfajores
  Meal(
    id: 'm14',
    categories: ['c11'],
    title: 'Alfajores',
    subtitle: 'Ricetta di Argentinian — autentica e collaudata',
    description:
        'Un piatto di Argentinian dalla tradizione dessert: Alfajores preparato con '
        'ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/a4kgf21763075288.jpg',
    duration: 42,
    servings: 4,
    complexity: Complexity.challenging,
    affordability: Affordability.affordable,
    ingredients: [
      '300g All purpose flour',
      '200g Cornstarch',
      '200g Butter',
      '100g Sugar',
      '2 Egg Yolks',
      '1 teaspoon Lemon Zest',
      'Dulce de leche',
      'Sprinkling Desiccated Coconut',
    ],
    steps: [
      'Make the Dough: Cream butter and sugar. Add egg yolks and lemon zest. '
          'Gradually mix in flour and cornstarch to form a dough. Chill for 1 hour.',
      'Bake the Cookies: Roll out the dough, cut into circles, and bake at 180°C '
          '(350°F) for 12-15 minutes. Let cool.',
      'Assemble: Spread dulce de leche on one cookie, then sandwich with another. '
          'Roll the edges in coconut flakes.',
      'Chill the dough before rolling it out to make it easier to handle and to '
          'prevent the cookies from spreading too much while baking.',
      'Dip the alfajores in melted chocolate and let them set on a wire rack for an '
          'extra decadent treat.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
    rate: 4.9,
  ),

  // ── m15: Anzac biscuits
  Meal(
    id: 'm15',
    categories: ['c11'],
    title: 'Anzac biscuits',
    subtitle: 'Ricetta di Australian — autentica e collaudata',
    description:
        'Un piatto di Australian dalla tradizione dessert: Anzac biscuits preparato '
        'con ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/q47rkb1762324620.jpg',
    duration: 20,
    servings: 3,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: [
      '85g Porridge oats',
      '85g Desiccated Coconut',
      '100g Plain Flour',
      '100g Caster Sugar',
      '100g Butter',
      '1 tblsp Golden Syrup',
      '1 teaspoon Bicarbonate Of Soda',
    ],
    steps: [
      'step 1 Heat oven to 180C/fan 160C/gas 4. Put the oats, coconut, flour and '
          'sugar in a bowl. Melt the butter in a small pan and stir in the golden '
          'syrup. Add the bicarbonate of soda to 2 tbsp boiling water, then stir into '
          'the golden syrup and butter mixture.',
      'step 2 Make a well in the middle of the dry ingredients and pour in the '
          'butter and golden syrup mixture. Stir gently to incorporate the dry '
          'ingredients.',
      'step 3 Put dessertspoonfuls of the mixture on to buttered baking sheets, '
          'about 2.5cm/1in apart to allow room for spreading. Bake in batches for 8-10 '
          'mins until golden. Transfer to a wire rack to cool.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
    rate: 4.3,
  ),

  // ── m16: Apam balik
  Meal(
    id: 'm16',
    categories: ['c11'],
    title: 'Apam balik',
    subtitle: 'Ricetta di Malaysian — autentica e collaudata',
    description:
        'Un piatto di Malaysian dalla tradizione dessert: Apam balik preparato con '
        'ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg',
    duration: 29,
    servings: 3,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: [
      '200ml Milk',
      '60ml Oil',
      '2 Eggs',
      '1600g Flour',
      '3 tsp Baking Powder',
      '1/2 tsp Salt',
      '25g Unsalted Butter',
      '45g Sugar',
      '3 tbs Peanut Butter',
    ],
    steps: [
      'Mix milk, oil and egg together. Sift flour, baking powder and salt into the '
          'mixture. Stir well until all ingredients are combined evenly.',
      'Spread some batter onto the pan. Spread a thin layer of batter to the side '
          'of the pan. Cover the pan for 30-60 seconds until small air bubbles appear.',
      'Add butter, cream corn, crushed peanuts and sugar onto the pancake. Fold the '
          'pancake into half once the bottom surface is browned.',
      'Cut into wedges and best eaten when it is warm.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
    rate: 3.8,
  ),

  // ── m17: Apple & Blackberry Crumble
  Meal(
    id: 'm17',
    categories: ['c11'],
    title: 'Apple & Blackberry Crumble',
    subtitle: 'Ricetta di British — autentica e collaudata',
    description:
        'Un piatto di British dalla tradizione dessert: Apple & Blackberry Crumble '
        'preparato con ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg',
    duration: 24,
    servings: 6,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: [
      '120g Plain Flour',
      '60g Caster Sugar',
      '60g Butter',
      '300g Braeburn Apples',
      '30g Butter',
      '30g Demerara Sugar',
      '120g Blackberries',
      '¼ teaspoon Cinnamon',
      'to serve Ice Cream',
    ],
    steps: [
      'Heat oven to 190C/170C fan/gas 5. Tip the flour and sugar into a large bowl. '
          'Add the butter, then rub into the flour using your fingertips to make a '
          'light breadcrumb texture. Do not overwork it or the crumble will become '
          'heavy. Sprinkle the mixture evenly over a baking sheet and bake for 15 mins '
          'or until lightly coloured.',
      'Meanwhile, for the compote, peel, core and cut the apples into 2cm dice. Put '
          'the butter and sugar in a medium saucepan and melt together over a medium '
          'heat. Cook for 3 mins until the mixture turns to a light caramel. Stir in '
          'the apples and cook for 3 mins. Add the blackberries and cinnamon, and cook '
          'for 3 mins more. Cover, remove from the heat, then leave for 2-3 mins to '
          'continue cooking in the warmth of the pan.',
      'To serve, spoon the warm fruit into an ovenproof gratin dish, top with the '
          'crumble mix, then reheat in the oven for 5-10 mins. Serve with vanilla ice '
          'cream.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
    rate: 3.8,
  ),

  // ── m18: Apple cake
  Meal(
    id: 'm18',
    categories: ['c11'],
    title: 'Apple cake',
    subtitle: 'Ricetta di Dutch — autentica e collaudata',
    description:
        'Un piatto di Dutch dalla tradizione dessert: Apple cake preparato con '
        'ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/c0gmo31766594751.jpg',
    duration: 117,
    servings: 5,
    complexity: Complexity.hard,
    affordability: Affordability.affordable,
    ingredients: [
      '4 Eggs',
      '200g Sugar',
      '200g Self-raising Flour',
      '200g Melted Butter',
      '1 tsp Vanilla Extract',
      '1 tsp Ground Cinnamon',
      '3 Apples',
      'Pinch Salt',
      'Sprinkling Ground Sugar',
    ],
    steps: [
      'Preheat the oven to 180°C. (350˚F) Grease a cake pan and line it with baking '
          'paper.',
      'In a large bowl, break the four eggs with the sugar and beat until they have '
          'tripled in volume and become fluffy.',
      'Sift the self-rising baking flour and add it to your egg mixture. Fold this '
          'over, preserving as much air as possible. Add the melted (and slightly '
          'cooled) butter and mix until combined.',
      'Add cinnamon, pinch of salt and vanilla extract.',
      'Add the diced apple to the batter and gently fold them into the batter so '
          'that the apple pieces are evenly distributed. You can roll the apple pieces '
          'through some more cinnamon.',
      'Pour the batter into the prepared cake pan and smooth the top with a '
          'spatula.',
      'Place the apple slices on top of the batter and press lightly. Sprinkle '
          'optionally with some almond shavings.',
      'Bake the apple cake in the preheated oven for about 45-50 minutes, or until '
          'a wooden skewer comes out clean when inserted into the center of the cake.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
    rate: 4.8,
  ),

  // ── m19: Arroz con gambas y calamar
  Meal(
    id: 'm19',
    categories: ['c12', 'c10'],
    title: 'Arroz con gambas y calamar',
    subtitle: 'Ricetta di Spanish — autentica e collaudata',
    description:
        'Un piatto di Spanish dalla tradizione seafood: Arroz con gambas y calamar '
        'preparato con ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/jc6oub1763196663.jpg',
    duration: 31,
    servings: 3,
    complexity: Complexity.simple,
    affordability: Affordability.luxurious,
    ingredients: [
      '24 Raw King Prawns',
      '2 tbsp Olive Oil',
      '1 small Onion',
      '1 Bay Leaf',
      '1 pinch Saffron',
      '450g Paella Rice',
      '2 teaspoons Tomato Puree',
      '200ml White Wine',
      '650ml Seafood stock',
      '3 Medium Squid',
    ],
    steps: [
      'step 1 Peel and devein most of the prawns (a fishmonger should be able to do '
          'this for you), keeping a few whole for decoration, if you like. Heat the '
          'olive oil in a large frying pan or shallow flameproof casserole over a '
          'medium-low heat and fry the onion for 5 mins until softened. Add the bay '
          'leaf, saffron, rice and tomato purée, and cook for 1-2 mins more, stirring.',
      'step 2 Pour in the wine and bubble for 1-2 mins, then pour in the seafood '
          'stock and 150ml water. Cook for 5 mins, then add the squid, season well and '
          'stir to combine. Bring to the boil, then cover and reduce the heat to a '
          'gentle simmer. Cook for 12 mins more, adding a little more water if the '
          'mixture starts to look dry.',
      'step 3 Uncover the pan and stir through the peeled prawns, then arrange any '
          'whole prawns on top of the rice mixture. Cover again and simmer for a '
          'further 5-6 mins until the prawns are pink and cooked through. Leave to '
          'stand for a couple of minutes before serving from the pan.',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
    rate: 4.4,
  ),

  // ── m20: Baked salmon with fennel & tomatoes
  Meal(
    id: 'm20',
    categories: ['c12', 'c10'],
    title: 'Baked salmon with fennel & tomatoes',
    subtitle: 'Ricetta di British — autentica e collaudata',
    description:
        'Un piatto di British dalla tradizione seafood: Baked salmon with fennel & '
        'tomatoes preparato con ingredienti genuini e tecnica consolidata.',
    imageUrl: 'https://www.themealdb.com/images/media/meals/1548772327.jpg',
    duration: 104,
    servings: 6,
    complexity: Complexity.hard,
    affordability: Affordability.pricey,
    ingredients: [
      '2 medium Fennel',
      '2 tbs chopped Parsley',
      'Juice of 1 Lemon',
      '175g Cherry Tomatoes',
      '1 tbs Olive Oil',
      '350g Salmon',
      'to serve Black Olives',
    ],
    steps: [
      'Heat oven to 180C/fan 160C/gas 4.',
      'Trim the fronds from the fennel and set aside.',
      'Cut the fennel bulbs in half, then cut each half into 3 wedges.',
      'Cook in boiling salted water for 10 mins, then drain well.',
      'Chop the fennel fronds roughly, then mix with the parsley and lemon zest.',
      'Spread the drained fennel over a shallow ovenproof dish, then add the '
          'tomatoes.',
      'Drizzle with olive oil, then bake for 10 mins.',
      'Nestle the salmon among the veg, sprinkle with lemon juice, then bake 15 '
          'mins more until the fish is just cooked.',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
    rate: 3.9,
  ),

  // ── m21: Bang bang prawn salad
  Meal(
    id: 'm21',
    categories: ['c8'],
    title: 'Bang bang prawn salad',
    subtitle: 'Ricetta di Vietnamese — autentica e collaudata',
    description:
        'Un piatto di Vietnamese dalla tradizione seafood: Bang bang prawn salad '
        'preparato con ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/4xcfai1763765676.jpg',
    duration: 19,
    servings: 2,
    complexity: Complexity.simple,
    affordability: Affordability.pricey,
    ingredients: [
      '140g Rice Noodles',
      '3 tablespoons Peanut Butter',
      '4 tablespoons Coconut Milk',
      '3  tablespoons sweet chilli sauce',
      '3 sliced thinly Spring Onions',
      '1 sliced Cucumber',
      '300g Bean Sprouts',
      '200g Prawns',
    ],
    steps: [
      'step 1 Cook the noodles following pack instructions, then rinse under cold '
          'water and drain thoroughly.',
      'In a small saucepan melt together the peanut butter, coconut milk, sweet '
          'chilli sauce and half the spring onions, adding 1-2 tbsp of water to loosen '
          'the mixture to a drizzling consistency.',
      'step 2 Mix the noodles, cucumber and beansprouts in a serving dish.',
      'Top with the prawns, drizzle over the peanut sauce and scatter over the '
          'remaining spring onions.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: false,
    rate: 3.9,
  ),

  // ── m22: Barramundi with Moroccan spices
  Meal(
    id: 'm22',
    categories: ['c12', 'c10'],
    title: 'Barramundi with Moroccan spices',
    subtitle: 'Ricetta di Australian — autentica e collaudata',
    description:
        'Un piatto di Australian dalla tradizione seafood: Barramundi with Moroccan '
        'spices preparato con ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/4o4wh11761848573.jpg',
    duration: 31,
    servings: 4,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: [
      '2 x 400g barramundi',
      '1/2 teaspoon Ground Cumin',
      '1/2 tsp Coriander',
      'Pinch Paprika',
      'Pinch Chili Powder',
      '2 Garlic Clove',
      'Juice of 1 Lemon',
      '5 tablespoons Olive Oil',
      'Bunch Coriander',
    ],
    steps: [
      'step 1 Tip all the dressing ingredients into a food processor with a pinch '
          'of salt and blitz to a dressing. Slash the fish three times on each side, '
          'coat with half of the dressing, then set aside to marinate for about 30 '
          'mins.',
      'step 2 Heat oven to 220C/fan 200C/gas 7. Place the fish on a roasting tray, '
          'then cook in the oven for 20 mins until the flesh is firm and the eyes have '
          'turned white. Serve the fish with the rest of the dressing and steamed '
          'couscous or rice.',
      'step 3 KNOW HOW: HOW TO COOK IT: Cooking barramundi on the bone, as we have '
          'done here, has its advantages – it will stay more moist during cooking, and '
          'some would say that the flavour is enhanced, too. If you want to take out '
          'the bones they are easy to locate and less likely to be lodged in the fillet '
          'if the fish is cooked whole. Fillets can be simply pan-fried or grilled. If '
          'you like trout, you will really enjoy the flavour of barramundi, which lends '
          'itself to similar ingredients and cooking methods – citrus flavours are '
          'particularly good, as are garlic and wild mushrooms. Simply roasting the '
          'fish with some fresh herbs, olive oil and seasoning is delicious, and in the '
          'summer months you could barbecue it, too. One thing that you mustn’t miss '
          'are the cheeks or ‘pearls’ of the fish, these are simply lovely, moist and '
          'really sweet – well worth leaving the head on for!',
    ],
    isGlutenFree: true,
    isVegan: true,
    isVegetarian: true,
    isLactoseFree: true,
    rate: 4.5,
  ),

  // ── m23: Cajun spiced fish tacos
  Meal(
    id: 'm23',
    categories: ['c3', 'c6'],
    title: 'Cajun spiced fish tacos',
    subtitle: 'Ricetta di Mexican — autentica e collaudata',
    description:
        'Un piatto di Mexican dalla tradizione seafood: Cajun spiced fish tacos '
        'preparato con ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/uvuyxu1503067369.jpg',
    duration: 21,
    servings: 5,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: [
      '2 tbsp cajun',
      '1 tsp cayenne pepper',
      '4 fillets white fish',
      '1 tsp vegetable oil',
      '8 flour tortilla',
      '1 sliced avocado',
      '2 shredded little gem lettuce',
      '4 shredded Spring Onions',
      '1 x 300ml salsa',
      '1 pot sour cream',
    ],
    steps: [
      'Cooking in a cajun spice and cayenne pepper marinade makes this fish super '
          'succulent and flavoursome. Top with a zesty dressing and serve in a tortilla '
          'for a quick, fuss-free main that\'s delightfully summery.',
      'On a large plate, mix the cajun spice and cayenne pepper with a little '
          'seasoning and use to coat the fish all over.',
      'Heat a little oil in a frying pan, add in the fish and cook over a medium '
          'heat until golden. Reduce the heat and continue frying until the fish is '
          'cooked through, about 10 minutes. Cook in batches if you don’t have enough '
          'room in the pan.',
      'Meanwhile, prepare the dressing by combining all the ingredients with a '
          'little seasoning. Soften the tortillas by heating in the microwave for 5-10 '
          'seconds. Pile high with the avocado, lettuce and spring onion, add a '
          'spoonful of salsa, top with large flakes of fish and drizzle over the '
          'dressing.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: false,
    rate: 4.3,
  ),

  // ── m24: Clam, chorizo & white bean stew
  Meal(
    id: 'm24',
    categories: ['c12', 'c10'],
    title: 'Clam, chorizo & white bean stew',
    subtitle: 'Ricetta di Spanish — autentica e collaudata',
    description:
        'Un piatto di Spanish dalla tradizione seafood: Clam, chorizo & white bean '
        'stew preparato con ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/92wbmf1763252334.jpg',
    duration: 29,
    servings: 3,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: [
      '50g Chorizo',
      '1 chopped Onion',
      '1 Garlic Clove',
      'Bunch Parsley',
      '200ml Vegetable Stock',
      '400g Tinned Tomatos',
      '400g Butter Beans',
      '1 teaspoon Sherry vinegar',
      '600g Clams',
      'To serve Crusty Bread',
    ],
    steps: [
      'step 1 Fry the chorizo in a large frying pan with a lid, over a medium heat '
          'until it is starting to crisp up and release its oil. Add the onion and cook '
          'for 5 mins until starting to soften. Then add the garlic and finely chopped '
          'parsley, and fry for 1 min more.',
      'step 2 Pour on the stock and tomatoes. Bring to the boil, reduce the heat, '
          'then add the beans and sherry vinegar. Simmer for 10 mins until the liquid '
          'is slightly reduced.',
      'step 3 Scatter over the clams, cover with the lid and steam for 2-4 mins, '
          'shaking the pan occasionally until the clams are open. Have a little taste '
          'before seasoning, as the clams can be quite salty. Then scatter over the '
          'chopped parsley. Eat with lots of crusty bread.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: false,
    rate: 4.4,
  ),

  // ── m25: Fasoliyyeh Bi Z-Zayt (Syrian Green Beans with Olive Oil)
  Meal(
    id: 'm25',
    categories: ['c5'],
    title: 'Fasoliyyeh Bi Z-Zayt (Syrian Green Beans with Olive Oil)',
    subtitle: 'Ricetta di Syrian — autentica e collaudata',
    description:
        'Un piatto di Syrian dalla tradizione vegan: Fasoliyyeh Bi Z-Zayt (Syrian '
        'Green Beans with Olive Oil) preparato con ingredienti genuini e tecnica '
        'consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/21yc5s1760524759.jpg',
    duration: 149,
    servings: 5,
    complexity: Complexity.hard,
    affordability: Affordability.affordable,
    ingredients: [
      '16 ounces Green Beans',
      '1/4 cup Olive Oil',
      'Dash Salt',
      '1 clove Garlic',
      '1/4 cup Cilantro',
    ],
    steps: [
      'Place the green beans into a large pot, and drizzle with olive oil.',
      'Season with salt to taste, and put the lid on the pot.',
      'Cook over medium-high heat, stirring occasionally, until beans are cooked to '
          'your desired doneness.',
      'Syrians like it cooked until the green beans are turning brownish in color.',
      'The idea is not to saute them, but to let them steam in the moisture '
          'released by the ice crystals.',
      'Add cilantro and garlic to the beans, and continue to cook just until the '
          'cilantro has started to wilt.',
      'Eat as a main course by scooping up with warm pita bread or serve as a side '
          'dish.',
    ],
    isGlutenFree: true,
    isVegan: true,
    isVegetarian: true,
    isLactoseFree: true,
    rate: 4.7,
  ),

  // ── m26: Padron peppers
  Meal(
    id: 'm26',
    categories: ['c12', 'c10'],
    title: 'Padron peppers',
    subtitle: 'Ricetta di Spanish — autentica e collaudata',
    description:
        'Un piatto di Spanish dalla tradizione vegan: Padron peppers preparato con '
        'ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/0ljvc51763248075.jpg',
    duration: 56,
    servings: 6,
    complexity: Complexity.challenging,
    affordability: Affordability.affordable,
    ingredients: ['1 tablespoon Olive Oil', '500g Padron peppers'],
    steps: [
      'step 1 Heat the olive oil in a large frying pan over a high heat, or if '
          'using an air-fryer, heat to 205C for 3 mins.',
      'Fry the peppers, stirring frequently, for 5 mins until blistered and wilted.',
      'The peppers should be soft and slightly charred.',
      'step 2 Transfer the peppers to a serving plate and season with some sea '
          'salt.',
      'Serve with dips or as part of a tapas spread, if you like.',
    ],
    isGlutenFree: true,
    isVegan: true,
    isVegetarian: true,
    isLactoseFree: true,
    rate: 4.9,
  ),

  // ── m27: Red onion pickle
  Meal(
    id: 'm27',
    categories: ['c5'],
    title: 'Red onion pickle',
    subtitle: 'Ricetta di Norwegian — autentica e collaudata',
    description:
        'Un piatto di Norwegian dalla tradizione vegan: Red onion pickle preparato '
        'con ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/ppodrp1762325183.jpg',
    duration: 31,
    servings: 5,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: [
      '3 Large Red Onions',
      '2 tsp Sea Salt',
      '200ml Cider Vinegar',
      '50g Granulated Sugar',
      '1 tsp Black Pepper',
      '4 Bay Leaves',
    ],
    steps: [
      'Peel the onions, cut them in half from top to bottom and finely slice into '
          'half-moon pieces. Put in a colander placed over a bowl and sprinkle with '
          'salt, lightly turning over the onion pieces with your hands so the surfaces '
          'are all covered. Set aside for an hour or so to brine.',
      'Meanwhile put the vinegar, 50ml/2fl oz water and the sugar in a saucepan. '
          'Bring to a simmer, stirring to help the sugar dissolve, and cook for a '
          'couple of minutes. Set aside.',
      'Pack the onions into the sterilised jars, sprinkling in a little pepper as '
          'you go. Cover with the warm vinegar and finish by tucking a couple of bay '
          'leaves down the side of the jars. Seal. The onions are best kept in the '
          'fridge and used within to 4 weeks.',
    ],
    isGlutenFree: true,
    isVegan: true,
    isVegetarian: true,
    isLactoseFree: true,
    rate: 4.8,
  ),

  // ── m28: Roast fennel and aubergine paella
  Meal(
    id: 'm28',
    categories: ['c12', 'c10'],
    title: 'Roast fennel and aubergine paella',
    subtitle: 'Ricetta di Spanish — autentica e collaudata',
    description:
        'Un piatto di Spanish dalla tradizione vegan: Roast fennel and aubergine '
        'paella preparato con ingredienti genuini e tecnica consolidata.',
    imageUrl: 'https://www.themealdb.com/images/media/meals/1520081754.jpg',
    duration: 17,
    servings: 2,
    complexity: Complexity.simple,
    affordability: Affordability.luxurious,
    ingredients: [
      '6 small Baby Aubergine',
      '4 small Fennel',
      '1 thinly sliced Red Pepper',
      '1 medium Courgettes',
      '1 finely chopped Onion',
      '300g Paella Rice',
      '1 tsp Paprika',
      'pinch Saffron',
      '200ml White Wine',
      '700ml Vegetable Stock',
    ],
    steps: [
      '1 Put the fennel, aubergine, pepper and courgette in a roasting tray. Add a '
          'glug of olive oil, season with salt and pepper and toss around to coat the '
          'veggies in the oil. Roast in the oven for 20 minutes, turning a couple of '
          'times until the veg are pretty much cooked through and turning golden.',
      '2 Meanwhile, heat a paella pan or large frying pan over a low– medium heat '
          'and add a glug of olive oil. Sauté the onion for 8–10 minutes until '
          'softened. Increase the heat to medium and stir in the rice, paprika and '
          'saffron. Cook for around 1 minute to start toasting the rice, then add the '
          'white wine. Reduce by about half before stirring in two-thirds of the stock. '
          'Reduce to a simmer and cook for 10 minutes without a lid, stirring a couple '
          'of times.',
      '3 Stir in the peas, add some seasoning, then gently mix in the roasted veg. '
          'Pour over the remaining stock, arrange the lemon wedges on top and cover '
          'with a lid or some aluminium foil. Cook for a further 10 minutes.',
      '4 To ensure you get the classic layer of toasted rice at the bottom of the '
          'pan, increase the heat to high until you hear a slight crackle. Remove from '
          'the heat and sit for 5 minutes before sprinkling over the parsley and '
          'serving.',
    ],
    isGlutenFree: true,
    isVegan: true,
    isVegetarian: true,
    isLactoseFree: true,
    rate: 4.5,
  ),

  // ── m29: Vegan banh mi
  Meal(
    id: 'm29',
    categories: ['c8'],
    title: 'Vegan banh mi',
    subtitle: 'Ricetta di Vietnamese — autentica e collaudata',
    description:
        'Un piatto di Vietnamese dalla tradizione vegan: Vegan banh mi preparato con '
        'ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/sonirb1763782831.jpg',
    duration: 81,
    servings: 3,
    complexity: Complexity.hard,
    affordability: Affordability.affordable,
    ingredients: [
      '150g Raw Vegetables',
      '3  tablespoons Vegan White Wine Vinegar',
      '1 tsp Golden Caster Sugar',
      '1 large Baguette',
      '100g Hummus',
      '175g Tempeh',
      'Handful Coriander',
      'Handful Mint',
      'To serve Hotsauce',
    ],
    steps: [
      'step 1 Put the shredded veg in a bowl and add the vinegar, sugar and 1 tsp '
          'salt.',
      'Toss everything together, then set aside to pickle quickly while you prepare '
          'the rest of the sandwich.',
      'step 2 Heat oven to 180C/160C fan/gas 4.',
      'Cut the baguette into four, then slice each piece horizontally in half.',
      'Put the baguette pieces in the oven for 5 mins until lightly toasted and '
          'warm.',
      'Spread each piece with a layer of hummus, then top four pieces with the '
          'tempeh slices and pile the pickled veg on top.',
      'To serve, sprinkle over the herbs and squeeze over some hot sauce, then top '
          'with the other baguette pieces to make sandwiches.',
    ],
    isGlutenFree: false,
    isVegan: true,
    isVegetarian: true,
    isLactoseFree: true,
    rate: 4.4,
  ),

  // ── m30: Vegan Chocolate Cake
  Meal(
    id: 'm30',
    categories: ['c2', 'c3'],
    title: 'Vegan Chocolate Cake',
    subtitle: 'Ricetta di American — autentica e collaudata',
    description:
        'Un piatto di American dalla tradizione vegan: Vegan Chocolate Cake preparato '
        'con ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/qxutws1486978099.jpg',
    duration: 29,
    servings: 2,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: [
      '1 1/4 cup Self-raising Flour',
      '1/2 cup coco sugar',
      '1/3 cup raw cacao',
      '1 tsp baking powder',
      '2 flax eggs',
      '1/2 cup almond milk',
      '1 tsp vanilla',
      '1/2 cup boiling water',
    ],
    steps: [
      'Simply mix all dry ingredients with wet ingredients and blend altogether.',
      'Bake for 45 min on 180 degrees.',
      'Decorate with some melted vegan chocolate.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
    rate: 4.4,
  ),

  // ── m31: Algerian Kefta (Meatballs)
  Meal(
    id: 'm31',
    categories: ['c4'],
    title: 'Algerian Kefta (Meatballs)',
    subtitle: 'Ricetta di Algerian — autentica e collaudata',
    description:
        'Un piatto di Algerian dalla tradizione beef: Algerian Kefta (Meatballs) '
        'preparato con ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/8rfd4q1764112993.jpg',
    duration: 35,
    servings: 5,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: [
      '1 lb Ground Beef',
      '4 Cloves Crushed Garlic',
      '1/2 cup Onion',
      'To taste Salt',
      'To taste Pepper',
      '3 Plum Tomatoes',
      '1 tsp Parsley',
      '1/2 cup Water',
    ],
    steps: [
      'Combine ground beef with 1/2 of the minced garlic and 1 tablespoon chopped '
          'onion in a large bowl. Mix with your hands until fully incorporated. Shape '
          'meat mixture into 1 1/2-inch oblong patties; you should have 12 to 14 '
          'meatballs.',
      'Heat a large skillet over medium-high heat. Brown patties in batches in the '
          'hot skillet until crispy on both sides and no longer pink in the center, '
          'about 10 minutes. Set meatballs aside in a rimmed serving dish.',
      'Reduce heat to medium and stir remaining chopped onion into drippings in the '
          'skillet. Season with salt and pepper. Cook, stirring constantly, until onion '
          'has softened and turned translucent, about 5 minutes. Stir in remaining '
          'garlic and cook for 30 seconds. Stir in Roma tomatoes, dried parsley, and '
          'ras el hanout. Pour in water. Cook until tomatoes are soft, about 5 minutes.',
      'Pour tomato sauce over meatballs to serve.',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
    rate: 4.4,
  ),

  // ── m32: Arepa Pabellón
  Meal(
    id: 'm32',
    categories: ['c4'],
    title: 'Arepa Pabellón',
    subtitle: 'Ricetta di Venezulan — autentica e collaudata',
    description:
        'Un piatto di Venezulan dalla tradizione beef: Arepa Pabellón preparato con '
        'ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/13fg4j1764441982.jpg',
    duration: 26,
    servings: 3,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: [
      '2 Corn Arepa Filled With Mozarella Cheese',
      '1 Fried Ripe Bananas',
      '1 Can Black Beans',
      '1 Pico De Gallo Sauce',
      '2kg Shredded Meat',
      '1 chopped Tomato',
      'Pinch Salt',
      'Pinch Pepper',
    ],
    steps: [
      'Prepare the meat in a skillet and add salt and pepper to taste, heat the '
          'beans over medium heat in a pan, fry or grill the ripe plantains as '
          'indicated on its package and cut the tomato into small cubes. Reserve these '
          'ingredients until filling.',
      'Preheat the grill or pan and grill the arepa, putting it once on each side '
          'until they are golden brown.',
      'With the help of a knife, open it by the edge through the middle, creating a '
          'space to fill it with the ripe plantain, the beans, meat and chopped tomato.',
      'Serve with a little pico de gallo or guacamole dip sauce.',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
    rate: 4.1,
  ),

  // ── m33: Arepa pelua
  Meal(
    id: 'm33',
    categories: ['c4'],
    title: 'Arepa pelua',
    subtitle: 'Ricetta di Venezulan — autentica e collaudata',
    description:
        'Un piatto di Venezulan dalla tradizione beef: Arepa pelua preparato con '
        'ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/jgl9qq1764437635.jpg',
    duration: 72,
    servings: 2,
    complexity: Complexity.hard,
    affordability: Affordability.affordable,
    ingredients: [
      '500g Beef',
      '1 Onion',
      '1 Red Pepper',
      '2 cloves Garlic',
      '1 tsp Cumin',
      '1 tsp Oregano',
      '1 tsp Paprika',
      '1 L Beef Stock',
      '2 1/2 cups Water',
      'Pinch Salt',
    ],
    steps: [
      'Cook the meat: Place the flank steak in a pot with broth or water and salt. '
          'Cook over low heat for about 2 hours, until tender and easy to shred.',
      'Shred the meat: Once cooked, drain and shred the meat using two forks.',
      'Prepare the vegetables: Sauté chopped onion, bell pepper, and garlic in a '
          'little oil. Add cumin, oregano, paprika, and salt. Stir in the meat and cook '
          'for a few minutes until the flavors are well combined.',
      'Make the dough: In a bowl, mix the cornmeal with warm water and salt until a '
          'soft dough forms. Let it rest for 5 minutes.',
      'Form the arepas: Divide the dough into 6 portions, shape into balls, and '
          'flatten into thick discs.',
      'Cook: Cook the arepas on a griddle or skillet over medium heat for 2–3 '
          'minutes on each side until golden. You can then bake them for a few minutes '
          'if you prefer them crispier.',
      'Fill: Slice the arepas open on one side, fill with the hot shredded beef, '
          'and top with grated cheese.',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
    rate: 4.3,
  ),

  // ── m34: Asado
  Meal(
    id: 'm34',
    categories: ['c4'],
    title: 'Asado',
    subtitle: 'Ricetta di Argentinian — autentica e collaudata',
    description:
        'Un piatto di Argentinian dalla tradizione beef: Asado preparato con '
        'ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/kgfh3q1763075438.jpg',
    duration: 33,
    servings: 6,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: [
      '2kg Mixed Beef Cuts',
      '4 Chorizo',
      '2 Morcilla',
      'To taste Salt',
    ],
    steps: [
      'Prepare the Fire: Start a wood fire in your grill and let it burn down to '
          'coals. Season the Meat: Generously salt the beef cuts. Grill the Meat: Place '
          'the beef on the grill, starting with the thickest cuts farthest from the '
          'coals. Add chorizo and morcilla after the beef has been cooking for a while. '
          'Cook to Perfection: Cook the meat, turning occasionally, until it reaches '
          'your desired doneness. Typically, ribs may take up to 2 hours; thinner cuts '
          'will cook faster. Rest and Serve: Let the meat rest for about 10 minutes '
          'before slicing. Serve with chimichurri sauce and grilled vegetables. Pro '
          'Tips:.',
      'Use a mix of wood and charcoal for a consistent heat source. Wood adds '
          'flavor, while charcoal maintains temperature. Season the meat just before '
          'grilling to ensure it retains its moisture and flavor. Serving Suggestions:.',
      'Serve with a side of chimichurri sauce, a fresh tomato salad, and crusty '
          'bread. Pair with a robust Malbec wine to complement the rich flavors of the '
          'meat.',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
    rate: 4.7,
  ),

  // ── m35: Aussie Burgers
  Meal(
    id: 'm35',
    categories: ['c4'],
    title: 'Aussie Burgers',
    subtitle: 'Ricetta di Australian — autentica e collaudata',
    description:
        'Un piatto di Australian dalla tradizione beef: Aussie Burgers preparato con '
        'ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/44bzep1761848278.jpg',
    duration: 22,
    servings: 6,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: [
      '500g Lean Minced Steak',
      '100g Cooked Beetroot',
      '2 small Naan Bread',
      '50g Rocket',
      '4 tablespoons Soured cream and chive dip',
    ],
    steps: [
      'step 1 Make the burgers: Tip the meat into a bowl and sprinkle over 1 tsp '
          'salt and a good grinding of black pepper.Work with wet hands to mix in the '
          'seasoning. Divide into four with your hands and shape into burgers. (It can '
          'be frozen at this stage.).',
      'step 2 Sort out your ingredients: Slice the beetroot and split the naan '
          'breads.',
      'step 3 Toast the naans: Heat a griddle pan or barbecue. Griddle the naans on '
          'both sides until lightly toasted and set aside. Add the burgers to the grill '
          'or barbecue and cook for 2-3 minutes, then turn and cook the other side for '
          'a further 2-3 minutes.',
      'step 4 Assemble the dish: Set half a toasted naan on each serving plate and '
          'put a pile of rocket on each. Top with a burger, then a few slices of '
          'beetroot and a dollop of soured cream. Sprinkle with salt and freshly ground '
          'black pepper and serve immediately with a big green salad and chips. A glass '
          'of red wine wouldn’t go amiss, either.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: false,
    rate: 4.9,
  ),

  // ── m36: Beef and Broccoli Stir-Fry
  Meal(
    id: 'm36',
    categories: ['c8'],
    title: 'Beef and Broccoli Stir-Fry',
    subtitle: 'Ricetta di Chinese — autentica e collaudata',
    description:
        'Un piatto di Chinese dalla tradizione beef: Beef and Broccoli Stir-Fry '
        'preparato con ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/m0p0j81765568742.jpg',
    duration: 130,
    servings: 6,
    complexity: Complexity.hard,
    affordability: Affordability.affordable,
    ingredients: [
      '1 tsp Soy Sauce',
      '1 tsp Dry sherry',
      '1/2 tsp Cornstarch',
      '1/8 teaspoon Black Pepper',
      '1 lb Sirloin steak',
      '2 tablespoons Oyster Sauce',
      '1 tsp Dry sherry',
      '1 tablespoon Soy Sauce',
      '1/4 cup Chicken Stock',
      '1 lb Broccoli',
    ],
    steps: [
      'Marinate the beef: Stir together the beef marinade ingredients (1 teaspoon '
          'soy sauce, 1 teaspoon Chinese rice wine, 1/2 teaspoon cornstarch, 1/8 '
          'teaspoon black pepper) in a medium bowl.',
      'Add the beef slices and stir until coated. Let stand for 10 minutes.',
      'Prepare the sauce: Stir together the sauce ingredients (2 tablespoons oyster '
          'sauce, 1 teaspoon Chinese rice wine, 1 teaspoon soy sauce, 1/4 cup chicken '
          'broth) in a small bowl. Set aside.',
      'Blanch or steam the broccoli: Bring a pot of water to a boil. Add the '
          'broccoli and cook until crisp-tender, about 2 minutes. Drain thoroughly.',
      'Stir-fry the beef: Heat a large frying pan or wok over high heat until a '
          'bead of water sizzles and instantly evaporates upon contact. Add the cooking '
          'oil and swirl to coat.',
      'Add the beef and immediately spread it out all over the surface of the wok '
          'or pan in a single layer (preferably not touching).',
      'Let the beef fry undisturbed for 1 minute. Flip the beef slices over, add '
          'the garlic to the pan, and fry for an additional 30 seconds to 1 minute '
          'until no longer pink.',
      'Add the sauce, cornstarch, and broccoli: Pour in the sauce and the '
          'cornstarch slurry (1 teaspoon cornstarch dissolved in 1 tablespoon of '
          'water). Stir until the sauce boils and thickens, about 30 seconds. Stir in '
          'the broccoli.',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
    rate: 4.5,
  ),

  // ── m37: 15-minute chicken & halloumi burgers
  Meal(
    id: 'm37',
    categories: ['c2', 'c3'],
    title: '15-minute chicken & halloumi burgers',
    subtitle: 'Ricetta di American — autentica e collaudata',
    description:
        'Un piatto di American dalla tradizione chicken: 15-minute chicken & halloumi '
        'burgers preparato con ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/vdwloy1713225718.jpg',
    duration: 56,
    servings: 4,
    complexity: Complexity.challenging,
    affordability: Affordability.affordable,
    ingredients: [
      '2 Chicken Breasts',
      '1 tbsp Oil',
      '4 tbsp Hotsauce',
      '½ Lemon Juice',
      '2 Buns',
      '250g Cheese',
      '¼ Cabbage',
      '2 tbsp Mayonnaise',
      '4 tbsp Sour Cream',
      '4 leaves Lettuce',
    ],
    steps: [
      'Put the chicken breasts between two pieces of baking parchment and use a '
          'rolling pin to gently bash them until they are approximately 1cm thick. Cut '
          'each chicken breast into two even pieces.',
      'If you\'re using a frying pan, heat two frying pans over medium-high heat, '
          'with one of them containing oil. Fry the chicken in the oiled pan for 3-4 '
          'mins on each side until they are cooked through. Season the chicken, reduce '
          'the heat, drizzle in the chilli sauce and half of the lemon juice, and cook '
          'for an additional 1-2 mins until the sauce is reduced. Remove the chicken '
          'from the heat.',
      'If you\'re using an air-fryer, preheat it to 180C for 4 mins. Add the '
          'chicken to the air-fryer and cook for 12 mins. Drizzle over the chilli sauce '
          'and half the lemon juice and cook for an additional 1-2 mins until the '
          'chicken is cooked through and the sauce is reduced. Remove the chicken and '
          'keep it warm. STEP 4.',
      'While the chicken is cooking, toast the buns in the dry frying pan for 30 '
          'seconds. Transfer them to a plate. If you\'re using an air fryer, put the '
          'buns in the air fryer for 1-2 mins until they are warm. Increase the air '
          'fryer temperature to 200C. Add the halloumi to the air fryer basket and cook '
          'for 10 mins, turning halfway through, until it\'s golden. Toss the cabbage '
          'with the mayo and the remaining lemon juice.',
      'Spoon the hummus (or dip of your choice) into the toasted buns, then top '
          'with the rocket, chilli chicken, halloumi, and peppers. Drizzle with a '
          'little more chilli sauce, spoon over the cabbage, season with black pepper, '
          'and top with the bun lids. Serve with any extra cabbage on the side or a '
          'green salad.',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: false,
    rate: 3.9,
  ),

  // ── m38: Ayam Percik
  Meal(
    id: 'm38',
    categories: ['c2'],
    title: 'Ayam Percik',
    subtitle: 'Ricetta di Malaysian — autentica e collaudata',
    description:
        'Un piatto di Malaysian dalla tradizione chicken: Ayam Percik preparato con '
        'ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/020z181619788503.jpg',
    duration: 107,
    servings: 4,
    complexity: Complexity.hard,
    affordability: Affordability.affordable,
    ingredients: [
      '6 Chicken Thighs',
      '16 Challots',
      '1 1/2 Ginger',
      '6 Garlic Clove',
      '8 Cayenne Pepper',
      '2 tbs Turmeric',
      '1 1/2 Cumin',
      '1 1/2 Coriander',
      '1 1/2 Fennel',
      '2 tbs Tamarind Paste',
    ],
    steps: [
      'In a blender, add the ingredients for the spice paste and blend until '
          'smooth.',
      'Over medium heat, pour the spice paste in a skillet or pan and fry for 10 '
          'minutes until fragrant. Add water or oil 1 tablespoon at a time if the paste '
          'becomes too dry. Don\'t burn the paste. Lower the fire slightly if needed.',
      'Add the cloves, cardamom, tamarind pulp, coconut milk, water, sugar and '
          'salt. Turn the heat up and bring the mixture to boil. Turn the heat to '
          'medium low and simmer for 10 minutes. Stir occasionally. It will reduce '
          'slightly. This is the marinade/sauce, so taste and adjust seasoning if '
          'necessary. Don\'t worry if it\'s slightly bitter. It will go away when '
          'roasting.',
      'When the marinade/sauce has cooled, pour everything over the chicken and '
          'marinate overnight to two days.',
      'Preheat the oven to 425 F.',
      'Remove the chicken from the marinade. Spoon the marinade onto a greased (or '
          'aluminum lined) baking sheet. Lay the chicken on top of the sauce (make sure '
          'the chicken covers the sauce and the sauce isn\'t exposed or it\'ll burn) '
          'and spread the remaining marinade on the chicken. Roast for 35-45 minutes or '
          'until internal temp of the thickest part of chicken is at least 175 F.',
      'Let chicken rest for 5 minutes. Brush the chicken with some of the oil. '
          'Serve chicken with the sauce over steamed rice (or coconut rice).',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
    rate: 4.9,
  ),

  // ── m39: Brown Stew Chicken
  Meal(
    id: 'm39',
    categories: ['c6'],
    title: 'Brown Stew Chicken',
    subtitle: 'Ricetta di Jamaican — autentica e collaudata',
    description:
        'Un piatto di Jamaican dalla tradizione chicken: Brown Stew Chicken preparato '
        'con ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/sypxpx1515365095.jpg',
    duration: 55,
    servings: 2,
    complexity: Complexity.challenging,
    affordability: Affordability.affordable,
    ingredients: [
      '1 whole Chicken',
      '1 chopped Tomato',
      '2 chopped Onions',
      '2 chopped Garlic Clove',
      '1 chopped Red Pepper',
      '1 chopped Carrots',
      '1 Lime',
      '2 tsp Thyme',
      '1 tsp Allspice',
      '2 tbs Soy Sauce',
    ],
    steps: [
      'Squeeze lime over chicken and rub well. Drain off excess lime juice.',
      'Combine tomato, scallion, onion, garlic, pepper, thyme, pimento and soy '
          'sauce in a large bowl with the chicken pieces. Cover and marinate at least '
          'one hour.',
      'Heat oil in a dutch pot or large saucepan. Shake off the seasonings as you '
          'remove each piece of chicken from the marinade. Reserve the marinade for '
          'sauce.',
      'Lightly brown the chicken a few pieces at a time in very hot oil. Place '
          'browned chicken pieces on a plate to rest while you brown the remaining '
          'pieces.',
      'Drain off excess oil and return the chicken to the pan. Pour the marinade '
          'over the chicken and add the carrots. Stir and cook over medium heat for 10 '
          'minutes.',
      'Mix flour and coconut milk and add to stew, stirring constantly. Turn heat '
          'down to minimum and cook another 20 minutes or until tender.',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
    rate: 3.9,
  ),

  // ── m40: Chick-Fil-A Sandwich
  Meal(
    id: 'm40',
    categories: ['c2', 'c3'],
    title: 'Chick-Fil-A Sandwich',
    subtitle: 'Ricetta di American — autentica e collaudata',
    description:
        'Un piatto di American dalla tradizione chicken: Chick-Fil-A Sandwich '
        'preparato con ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/sbx7n71587673021.jpg',
    duration: 149,
    servings: 3,
    complexity: Complexity.hard,
    affordability: Affordability.affordable,
    ingredients: [
      '1 Chicken Breast',
      '1/4 cup Pickle Juice',
      '1 Egg',
      '1/4 cup Milk',
      '1/2 cup Flour',
      '1 tbs Icing Sugar',
      '1/2 tsp Paprika',
      '1/2 tsp Salt',
      '1/4 tsp Black Pepper',
      '1/4 tsp Garlic Powder',
    ],
    steps: [
      'Wrap the chicken loosely between plastic wrap and pound gently with the flat '
          'side of a meat tenderizer until about 1/2 inch thick all around.',
      'Cut into two pieces, as even as possible.',
      'Marinate in the pickle juice for 30 minutes to one hour (add a teaspoon of '
          'Tabasco sauce now for a spicy sandwich).',
      'Beat the egg with the milk in a bowl.',
      'Combine the flour, sugar, and spices in another bowl.',
      'Dip the chicken pieces each into the egg on both sides, then coat in flour '
          'on both sides.',
      'Heat the oil in a skillet (1/2 inch deep) to about 345-350.',
      'Fry each cutlet for 2 minutes on each side, or until golden and cooked '
          'through.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: false,
    rate: 3.8,
  ),

  // ── m41: Chicken & chorizo rice pot
  Meal(
    id: 'm41',
    categories: ['c12', 'c10'],
    title: 'Chicken & chorizo rice pot',
    subtitle: 'Ricetta di Spanish — autentica e collaudata',
    description:
        'Un piatto di Spanish dalla tradizione chicken: Chicken & chorizo rice pot '
        'preparato con ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/fk80jp1763280767.jpg',
    duration: 17,
    servings: 3,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: [
      '1 tblsp Oil',
      '1 whole Chicken',
      '1 Large Chopped Onion',
      '1 chopped Red Pepper',
      '3 Cloves Crushed Garlic',
      '225g Chorizo',
      '1 tblsp Tomato Puree',
      '1 tablespoon chopped Thyme',
      '150ml White Wine',
      '800ml Chicken Stock',
    ],
    steps: [
      'step 1 Heat the oil in a large flameproof casserole dish and brown the '
          'chicken pieces on all sides – you may have to do this in batches. Remove '
          'from the dish and put to one side.',
      'step 2 Lower the heat, add the onion and pepper, and gently cook for 10 mins '
          'until softened. Add the garlic and chorizo, and cook for a further 2 mins '
          'until the chorizo has released some of its oils into the dish. Stir in the '
          'tomato purée and cook for 1 min more.',
      'step 3 Return the chicken pieces to the dish along with the thyme, white '
          'wine and stock. Bring the liquid to a boil, cover the dish with a '
          'tight-fitting lid and lower the heat. Cook for 30 mins.',
      'step 4 Tip in the rice and stir everything together. Cover, set over a low '
          'heat and cook for a further 15 mins, or until the rice is cooked and has '
          'absorbed most of the cooking liquid. Remove from the heat and leave the dish '
          'to sit for 10 mins to absorb any remaining liquid. Season to taste and '
          'scatter with parsley to serve.',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
    rate: 4.1,
  ),

  // ── m42: Chicken & mushroom Hotpot
  Meal(
    id: 'm42',
    categories: ['c2'],
    title: 'Chicken & mushroom Hotpot',
    subtitle: 'Ricetta di British — autentica e collaudata',
    description:
        'Un piatto di British dalla tradizione chicken: Chicken & mushroom Hotpot '
        'preparato con ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/uuuspp1511297945.jpg',
    duration: 64,
    servings: 6,
    complexity: Complexity.challenging,
    affordability: Affordability.affordable,
    ingredients: [
      '50g Butter',
      '1 chopped Onion',
      '100g Mushrooms',
      '40g Plain Flour',
      '1 Chicken Stock Cube',
      'pinch Nutmeg',
      'pinch Mustard Powder',
      '250g Chicken',
      '2 Handfuls Sweetcorn',
      '2 large Potatoes',
    ],
    steps: [
      'Heat oven to 200C/180C fan/gas 6. Put the butter in a medium-size saucepan '
          'and place over a medium heat. Add the onion and leave to cook for 5 mins, '
          'stirring occasionally. Add the mushrooms to the saucepan with the onions.',
      'Once the onion and mushrooms are almost cooked, stir in the flour – this '
          'will make a thick paste called a roux. If you are using a stock cube, '
          'crumble the cube into the roux now and stir well. Put the roux over a low '
          'heat and stir continuously for 2 mins – this will cook the flour and stop '
          'the sauce from having a floury taste.',
      'Take the roux off the heat. Slowly add the fresh stock, if using, or pour in '
          '500ml water if you’ve used a stock cube, stirring all the time. Once all the '
          'liquid has been added, season with pepper, a pinch of nutmeg and mustard '
          'powder. Put the saucepan back onto a medium heat and slowly bring it to the '
          'boil, stirring all the time. Once the sauce has thickened, place on a very '
          'low heat. Add the cooked chicken and vegetables to the sauce and stir well. '
          'Grease a medium-size ovenproof pie dish with a little butter and pour in the '
          'chicken and mushroom filling.',
      'Carefully lay the potatoes on top of the hot-pot filling, overlapping them '
          'slightly, almost like a pie top.',
      'Brush the potatoes with a little melted butter and cook in the oven for '
          'about 35 mins. The hot-pot is ready once the potatoes are cooked and golden '
          'brown.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: false,
    rate: 4.3,
  ),

  // ── m43: Adana kebab
  Meal(
    id: 'm43',
    categories: ['c6', 'c12'],
    title: 'Adana kebab',
    subtitle: 'Ricetta di Turkish — autentica e collaudata',
    description:
        'Un piatto di Turkish dalla tradizione lamb: Adana kebab preparato con '
        'ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/04axct1763793018.jpg',
    duration: 27,
    servings: 3,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: [
      '2 large Romano Pepper',
      '800g Lamb Mince',
      '3  tablespoons Red Pepper Paste',
      '1 tablespoon Pul Biber',
      '3  tablespoons Sunflower Oil',
    ],
    steps: [
      'step 1 Finely chop the peppers in a food processor, then tip them in a sieve '
          'and press into the sieve so that the peppers release all of their juices. '
          'Tip into a bowl along with the mince, red pepper paste, pul biber, 1½ tsp '
          'flaky sea salt, and 2 tbsp of the oil. Mix together, kneading well for at '
          'least 2-3 mins. If you need to, wet your hands with cold water to prevent '
          'the mixture from sticking. The mixture should be sticky when ready. Cover '
          'and chill for at least 2 hrs, or up to 12 hrs.',
      'step 2 When ready to cook, heat the grill to high or an oven to 220C/200C '
          'fan/gas 6. Divide the mixture into 12 equal portions, around 85g each. If '
          'you’d like to skewer them, divide into 8 equal portions and roll into balls. '
          'Using wet hands, thread the balls onto the end of the skewers, massaging the '
          'mixture down the skewers in between the palms of your hands, until evenly '
          'distributed. Ensure that the mixture is fully wrapped tightly around the '
          'skewers without any exposed metal. Alternatively, lay them on a large baking '
          'tray lined with parchment paper if cooking in the oven, or foil if cooking '
          'under the grill. Shape into 20cm-long köfte. Wet your fingers with a little '
          'cold water and make indents all along the köfte for the traditional shape.',
      'step 3 Gently brush each köfte with the remaining 1 tbsp oil and cook under '
          'the grill, on the top shelf for 10-12 mins, turning regularly, or cook in '
          'the oven for 16-18 mins, until crispy on the outside and juicy in the '
          'middle.',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
    rate: 4.6,
  ),

  // ── m44: Chilli ginger lamb chops
  Meal(
    id: 'm44',
    categories: ['c6', 'c12'],
    title: 'Chilli ginger lamb chops',
    subtitle: 'Ricetta di Turkish — autentica e collaudata',
    description:
        'Un piatto di Turkish dalla tradizione lamb: Chilli ginger lamb chops '
        'preparato con ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/8xuvhj1763794991.jpg',
    duration: 64,
    servings: 4,
    complexity: Complexity.challenging,
    affordability: Affordability.affordable,
    ingredients: [
      '4 Cloves Crushed Garlic',
      '1 tblsp Ginger',
      '1 tblsp Lemon Juice',
      '1 tblsp Olive Oil',
      '1/2 tsp Chili Powder',
      '1 tsp Cumin',
      '8 Lamb Loin Chops',
    ],
    steps: [
      'step 1 Put the garlic in a bowl with the ginger, lemon juice, oil, spices '
          'and seasoning.',
      'Blitz with a hand blender until smooth, then use to coat the lamb chops on '
          'both sides.',
      'Leave to marinate in the fridge for a couple of hours or overnight.',
      'step 2 Heat a barbecue until hot.',
      'Barbecue the chops over the coals for 3 mins on each side until cooked but '
          'still pink and juicy in the centre.',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
    rate: 4.0,
  ),

  // ── m45: Chorba Hamra bel Frik (Algerian Lamb, Tomato, and Freekeh Soup)
  Meal(
    id: 'm45',
    categories: ['c6'],
    title: 'Chorba Hamra bel Frik (Algerian Lamb, Tomato, and Freekeh Soup)',
    subtitle: 'Ricetta di Algerian — autentica e collaudata',
    description:
        'Un piatto di Algerian dalla tradizione lamb: Chorba Hamra bel Frik (Algerian '
        'Lamb, Tomato, and Freekeh Soup) preparato con ingredienti genuini e tecnica '
        'consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/p9tebp1764118792.jpg',
    duration: 67,
    servings: 4,
    complexity: Complexity.challenging,
    affordability: Affordability.affordable,
    ingredients: [
      '1 cup Freekeh',
      '12 ounces Lamb',
      '1 finely chopped Onion',
      '1 tsp Black Pepper',
      '1 tsp Paprika',
      '1 tsp Ground Cinnamon',
      'To taste Salt',
      '3  tablespoons Vegetable Oil',
      '1  bunch Cilantro',
      '1  bunch Mint',
    ],
    steps: [
      'Place freekeh in a small bowl and cover with cold water. Set aside.',
      'Combine lamb, onion, black pepper, paprika, cinnamon, and salt in a pot. '
          'Stir in oil, 1/2 the cilantro, 1/2 the mint, and celery stalk until '
          'combined. Simmer over low heat for 15 minutes. Stir in chickpeas; pour in '
          'just enough water to cover, and return to a simmer. Stir in zucchini, '
          'carrot, and tomato paste.',
      'Set a steamer over the pot; add tomatoes. Cover and steam tomatoes until '
          'soft, about 5 minutes. Crush tomatoes using a wooden spoon, so pulp drips '
          'into soup. Remove the steamer and discard leftover tomato peels.',
      'Add potato to soup and just enough water to cover. Simmer until potato is '
          'soft, about 10 minutes.',
      'Drain freekeh and add to soup. Simmer until soft, about 15 minutes. Remove '
          'celery stalk and discard. Sprinkle soup with remaining 1/2 cilantro and '
          'remaining 1/2 mint before serving.',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
    rate: 4.9,
  ),

  // ── m46: Fårikål (Norwegian National Dish)
  Meal(
    id: 'm46',
    categories: ['c6'],
    title: 'Fårikål (Norwegian National Dish)',
    subtitle: 'Ricetta di Norwegian — autentica e collaudata',
    description:
        'Un piatto di Norwegian dalla tradizione lamb: Fårikål (Norwegian National '
        'Dish) preparato con ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/ttfxxn1762773067.jpg',
    duration: 35,
    servings: 3,
    complexity: Complexity.challenging,
    affordability: Affordability.affordable,
    ingredients: [
      '3 Lbs Lamb',
      '1 head White Cabbage',
      '3  tablespoons Whole black peppercorns',
      '3 tsp Salt',
      '1 1/2 cups Water',
      '5 tablespoons Flour',
    ],
    steps: [
      'Cut the lamb into large pieces.',
      'Slice the cabbage into large wedges, keeping the core attached.',
      'Add a layer of lamb pieces to the bottom of a large pot, fatty side down. '
          'Sprinkle with peppercorns and salt. Add a layer of cabbage wedges on top. '
          'Repeat with more layers of lamb, peppercorns, and cabbage, ending with '
          'cabbage on top.',
      'Optional: Sprinkle a couple of tablespoons on top of the lamb for a thicker '
          'stew.',
      'Add water to the pot and bring to a boil. Cover and reduce heat. Cook on low '
          'heat for 2 – 3 hours, until the lamb gently falls away from the bone.',
      'Serve with boiled potatoes and fresh parsley, covering generously with the '
          'fårikål broth.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
    rate: 4.0,
  ),

  // ── m47: Hot cumin lamb wrap with crunchy slaw & spicy mayo
  Meal(
    id: 'm47',
    categories: ['c6', 'c12'],
    title: 'Hot cumin lamb wrap with crunchy slaw & spicy mayo',
    subtitle: 'Ricetta di Turkish — autentica e collaudata',
    description:
        'Un piatto di Turkish dalla tradizione lamb: Hot cumin lamb wrap with crunchy '
        'slaw & spicy mayo preparato con ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/jyylmo1763790808.jpg',
    duration: 18,
    servings: 6,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: [
      '4 small Lamb Leg',
      '2 tsp Olive Oil',
      '1 tsp Ground Cumin',
      '1 tablespoon Sugar',
      '3  tablespoons White Wine Vinegar',
      '2 Carrots',
      '2 sliced Spring Onions',
      '400g White Cabbage',
      '5 Sweet Peppadew Peppers',
      '3  tablespoons Mayonnaise',
    ],
    steps: [
      'step 1 Heat a griddle pan. Rub the lamb steaks with the oil, cumin and some '
          'seasoning. Griddle for about 3-4 mins on each side or until cooked to your '
          'liking. Place to one side on a plate to rest.',
      'step 2 In a large bowl, stir the sugar into the vinegar until dissolved. Add '
          'the carrots, spring onions, cabbage and some seasoning, and toss together.',
      'step 3 Blitz the whole peppers and the mayo in a food processor. Add a heap '
          'of the salad to each flatbread. Slice the lamb, trimming off any excess fat '
          'and lay on top of the salad, drizzling with the resting juices. Spoon over '
          'the mayo and scatter with a few of the sliced peppers. Roll up and eat. If '
          'using pitta, split and stuff. Serve any extra salad on the side.',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
    rate: 3.9,
  ),

  // ── m48: Imam bayildi with BBQ lamb & tzatziki
  Meal(
    id: 'm48',
    categories: ['c6', 'c12'],
    title: 'Imam bayildi with BBQ lamb & tzatziki',
    subtitle: 'Ricetta di Turkish — autentica e collaudata',
    description:
        'Un piatto di Turkish dalla tradizione lamb: Imam bayildi with BBQ lamb & '
        'tzatziki preparato con ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/ampz9v1763787134.jpg',
    duration: 60,
    servings: 3,
    complexity: Complexity.challenging,
    affordability: Affordability.affordable,
    ingredients: [
      '3 Aubergine',
      '2 tablespoons Olive Oil',
      '1 chopped Onion',
      '2 cloves chopped Garlic',
      '1 tsp Cinnamon',
      '8 Tomato',
      'Bunch Parsley',
      '12 Lamb Loin Chops',
      'Pinch Paprika',
      '1 Lemon',
    ],
    steps: [
      'step 1 Heat oven to 190C/170C fan/gas 5. Halve the aubergines lengthways and '
          'score the flesh side deeply, brush with a good layer of olive oil and put on '
          'a baking sheet. Roast for 20 mins or until the flesh is soft enough to scoop '
          'out.',
      'step 2 Fry the onion in a little oil until soft, add the garlic and cinnamon '
          'and fry for 1 min. Once the aubergines are cool enough to handle, scoop out '
          'the centres. Roughly chop the flesh and add it to the onions. Halve the '
          'tomatoes, scoop the seeds and juice into a sieve set over a bowl, then chop '
          'the flesh. Add the chopped tomatoes to the pan and cook everything for 10 '
          'mins until nice and soft. Add a little more oil if you need to. Stir in the '
          'parsley, leaving a little for scattering at the end.',
      'step 3 Lay the aubergine halves in a baking dish and divide the tomato '
          'mixture between them. Pour over the juice from the tomatoes, drizzle with '
          'more olive oil and bake for 30 mins until the aubergines have collapsed.',
      'step 4 Meanwhile, mix the tzatziki ingredients together and put in a small '
          'serving bowl.',
      'step 5 Season the lamb with salt, black pepper and a pinch of paprika. '
          'Griddle, grill or barbecue for 3 mins on each side or until the fat is '
          'nicely browned, then put in a serving dish and squeeze over the lemon '
          'halves. Scatter the aubergines with parsley, then serve with the lamb and '
          'tzatziki.',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
    rate: 3.9,
  ),

  // ── m49: Ajo blanco
  Meal(
    id: 'm49',
    categories: ['c12', 'c10'],
    title: 'Ajo blanco',
    subtitle: 'Ricetta di Spanish — autentica e collaudata',
    description:
        'Un piatto di Spanish dalla tradizione starter: Ajo blanco preparato con '
        'ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/5jdtie1763289302.jpg',
    duration: 33,
    servings: 4,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: [
      '150g White bread',
      '200g Almonds',
      '50 ml Extra Virgin Olive Oil',
      '1 Garlic Clove',
      '1 ½ tbsp Red Wine Vinegar',
    ],
    steps: [
      'step 1 Tip the bread into a bowl and pour over 350ml water. Leave to soak '
          'for 10 mins.',
      'step 2 Blend the ingredients together with 350ml water and 1 tsp salt.',
      'step 3 Let the soup cool in the fridge for 1 hr or so, then serve with a '
          'drizzle of oil and some black pepper.',
    ],
    isGlutenFree: false,
    isVegan: true,
    isVegetarian: true,
    isLactoseFree: true,
    rate: 4.5,
  ),

  // ── m50: Broccoli & Stilton soup
  Meal(
    id: 'm50',
    categories: ['c3'],
    title: 'Broccoli & Stilton soup',
    subtitle: 'Ricetta di British — autentica e collaudata',
    description:
        'Un piatto di British dalla tradizione starter: Broccoli & Stilton soup '
        'preparato con ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/tvvxpv1511191952.jpg',
    duration: 19,
    servings: 6,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: [
      '2 tblsp Rapeseed Oil',
      '1 finely chopped Onion',
      '1 Celery',
      '1 sliced Leek',
      '1 medium Potatoes',
      '1 knob Butter',
      '1 litre hot Vegetable Stock',
      '1 Head chopped Broccoli',
      '140g Stilton Cheese',
    ],
    steps: [
      'Heat the rapeseed oil in a large saucepan and then add the onions. Cook on a '
          'medium heat until soft. Add a splash of water if the onions start to catch.',
      'Add the celery, leek, potato and a knob of butter. Stir until melted, then '
          'cover with a lid. Allow to sweat for 5 minutes. Remove the lid.',
      'Pour in the stock and add any chunky bits of broccoli stalk. Cook for 10 – '
          '15 minutes until all the vegetables are soft.',
      'Add the rest of the broccoli and cook for a further 5 minutes. Carefully '
          'transfer to a blender and blitz until smooth. Stir in the stilton, allowing '
          'a few lumps to remain. Season with black pepper and serve.',
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
    rate: 4.0,
  ),

  // ── m51: Clam chowder
  Meal(
    id: 'm51',
    categories: ['c2', 'c3'],
    title: 'Clam chowder',
    subtitle: 'Ricetta di American — autentica e collaudata',
    description:
        'Un piatto di American dalla tradizione starter: Clam chowder preparato con '
        'ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/rvtvuw1511190488.jpg',
    duration: 21,
    servings: 3,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: [
      '1½ kg Clams',
      '50g Butter',
      '150g Bacon',
      '1 finely chopped Onion',
      'sprigs of fresh Thyme',
      '1 Bay Leaf',
      '1 tbls Plain Flour',
      '150ml Milk',
      '150ml Double Cream',
      '2 medium Potatoes',
    ],
    steps: [
      'Rinse the clams in several changes of cold water and drain well. Tip the '
          'clams into a large pan with 500ml of water. Cover, bring to the boil and '
          'simmer for 2 mins until the clams have just opened. Tip the contents of the '
          'pan into a colander over a bowl to catch the clam stock. When cool enough to '
          'handle, remove the clams from their shells – reserving a handful of empty '
          'shells for presentation if you want. Strain the clam stock into a jug, '
          'leaving any grit in the bottom of the bowl. You should have around 800ml '
          'stock.',
      'Heat the butter in the same pan and sizzle the bacon for 3-4 mins until it '
          'starts to brown. Stir in the onion, thyme and bay and cook everything gently '
          'for 10 mins until the onion is soft and golden. Scatter over the flour and '
          'stir in to make a sandy paste, cook for 2 mins more, then gradually stir in '
          'the clam stock then the milk and the cream.',
      'Throw in the potatoes, bring everything to a simmer and leave to bubble away '
          'gently for 10 mins or until the potatoes are cooked. Use a fork to crush a '
          'few of the potato chunks against the side of the pan to help thicken – you '
          'still want lots of defined chunks though. Stir through the clam meat and the '
          'few clam shells, if you\'ve gone down that route, and simmer for a minute to '
          'reheat. Season with plenty of black pepper and a little salt, if needed, '
          'then stir through the parsley just before ladling into bowls or hollowed-out '
          'crusty rolls.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: false,
    rate: 3.9,
  ),

  // ── m52: Cream Cheese Tart
  Meal(
    id: 'm52',
    categories: ['c2', 'c3'],
    title: 'Cream Cheese Tart',
    subtitle: 'Ricetta di American — autentica e collaudata',
    description:
        'Un piatto di American dalla tradizione starter: Cream Cheese Tart preparato '
        'con ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/wurrux1468416624.jpg',
    duration: 70,
    servings: 5,
    complexity: Complexity.challenging,
    affordability: Affordability.affordable,
    ingredients: [
      '250g Flour',
      '125g Butter',
      '1 Egg',
      'Pinch Salt',
      '300g Cheese',
      '100ml milk Milk',
      '3 Eggs',
      '100g Parmesan Cheese',
      '350g Plum tomatoes',
      '3tbsp White Vinegar',
    ],
    steps: [
      'Crust: make a dough from 250g flour (I like mixing different flours like '
          'plain and wholegrain spelt flour), 125g butter, 1 egg and a pinch of salt, '
          'press it into a tart form and place it in the fridge. Filling: stir 300g '
          'cream cheese and 100ml milk until smooth, add in 3 eggs, 100g grated '
          'parmesan cheese and season with salt, pepper and nutmeg.',
      'Take the crust out of the fridge and prick the bottom with a fork. Pour in '
          'the filling and bake at 175 degrees C for about 25 minutes.',
      'Cover the tart with some aluminium foil after half the time. In the mean '
          'time, slice about 350g mini tomatoes.',
      'In a small pan heat 3tbsp olive oil, 3tbsp white vinegar, 1 tbsp honey, salt '
          'and pepper and combine well. Pour over the tomato slices and mix well.',
      'With a spoon, place the tomato slices on the tart, avoiding too much liquid '
          'on it. Decorate with basil leaves and enjoy.',
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
    rate: 4.4,
  ),

  // ── m53: Creamy Tomato Soup
  Meal(
    id: 'm53',
    categories: ['c3'],
    title: 'Creamy Tomato Soup',
    subtitle: 'Ricetta di British — autentica e collaudata',
    description:
        'Un piatto di British dalla tradizione starter: Creamy Tomato Soup preparato '
        'con ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/stpuws1511191310.jpg',
    duration: 30,
    servings: 2,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: [
      '3 tbsp Olive Oil',
      '2 chopped Onions',
      '2 sticks Celery',
      '300g Carrots',
      '500g Potatoes',
      '4 Bay Leaf',
      '5 tblsp Tomato Puree',
      '2 tblsp Sugar',
      '2 tblsp White Vinegar',
      '1½ kg Chopped Tomatoes',
    ],
    steps: [
      'Put the oil, onions, celery, carrots, potatoes and bay leaves in a big '
          'casserole dish, or two saucepans. Fry gently until the onions are softened – '
          'about 10-15 mins. Fill the kettle and boil it.',
      'Stir in the tomato purée, sugar, vinegar, chopped tomatoes and passata, then '
          'crumble in the stock cubes. Add 1 litre boiling water and bring to a simmer. '
          'Cover and simmer for 15 mins until the potato is tender, then remove the bay '
          'leaves. Purée with a stick blender (or ladle into a blender in batches) '
          'until very smooth. Season to taste and add a pinch more sugar if it needs '
          'it. The soup can now be cooled and chilled for up to 2 days, or frozen for '
          'up to 3 months.',
      'To serve, reheat the soup, stirring in the milk – try not to let it boil. '
          'Serve in small bowls with cheesy sausage rolls.',
    ],
    isGlutenFree: true,
    isVegan: true,
    isVegetarian: true,
    isLactoseFree: true,
    rate: 4.7,
  ),

  // ── m54: Quick gazpacho
  Meal(
    id: 'm54',
    categories: ['c12', 'c10'],
    title: 'Quick gazpacho',
    subtitle: 'Ricetta di Spanish — autentica e collaudata',
    description:
        'Un piatto di Spanish dalla tradizione starter: Quick gazpacho preparato con '
        'ingredienti genuini e tecnica consolidata.',
    imageUrl:
        'https://www.themealdb.com/images/media/meals/h5qmn31763304965.jpg',
    duration: 25,
    servings: 6,
    complexity: Complexity.simple,
    affordability: Affordability.affordable,
    ingredients: [
      '250g Passata',
      '1 chopped Red Pepper',
      '1 chopped Red Chilli',
      '1 clove peeled crushed Garlic',
      '1 teaspoon Sherry vinegar',
      'Juice of 1/2 Lime',
    ],
    steps: [
      'step 1 In a blender (or with a stick blender), whizz together the passata, '
          'red pepper, chilli, garlic, sherry vinegar and lime juice until smooth.',
      'Season to taste, then serve with ice cubes.',
    ],
    isGlutenFree: true,
    isVegan: true,
    isVegetarian: true,
    isLactoseFree: true,
    rate: 4.6,
  ),
];
