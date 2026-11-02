import 'package:flutter/material.dart';

void main() => runApp(const PetAdoptionApp());

const Color ink = Color(0xFF20312D);
const Color muted = Color(0xFF78837E);
const Color cream = Color(0xFFF7F6F1);
const Color green = Color(0xFF397B68);
const Color paleGreen = Color(0xFFE5F0EA);
const Color orange = Color(0xFFE6A45B);

class PetAdoptionApp extends StatelessWidget {
  const PetAdoptionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PawPal',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: cream,
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(seedColor: green),
      ),
      home: const PetHomePage(),
    );
  }
}

class Pet {
  final String name, type, age, location, image, description, tag;
  const Pet({
    required this.name,
    required this.type,
    required this.age,
    required this.location,
    required this.image,
    required this.description,
    this.tag = 'Ready to meet',
  });
}

const List<Pet> pets = [
  Pet(
    name: 'Bruno', type: 'Dog', age: '2 years', location: 'Hyderabad',
    image: 'https://images.unsplash.com/photo-1552053831-71594a27632d?w=900',
    description: 'Bruno is a friendly and playful dog who loves people and outdoor activities. He is ready to become your everyday adventure buddy.',
    tag: 'Playful',
  ),
  Pet(
    name: 'Luna', type: 'Cat', age: '1 year', location: 'Hyderabad',
    image: 'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?w=900',
    description: 'Luna is a calm and affectionate cat who enjoys relaxing, sunny windows and playing with her favourite toys.',
    tag: 'Gentle',
  ),
  Pet(
    name: 'Coco', type: 'Rabbit', age: '8 months', location: 'Secunderabad',
    image: 'https://images.unsplash.com/photo-1585110396000-c9ffd4e4b308?w=900',
    description: 'Coco is a cute and gentle rabbit looking for a loving family and a cosy place to call home.',
    tag: 'Little explorer',
  ),
  Pet(
    name: 'Milo', type: 'Dog', age: '3 years', location: 'Hyderabad',
    image: 'https://images.unsplash.com/photo-1587300003388-59208cc962cb?w=900',
    description: 'Milo is energetic, loyal and loves spending time with his people. He would enjoy a home with room to play.',
    tag: 'Energetic',
  ),
];

class PetHomePage extends StatefulWidget {
  const PetHomePage({super.key});
  @override
  State<PetHomePage> createState() => _PetHomePageState();
}

class _PetHomePageState extends State<PetHomePage> {
  int selectedCategory = 0;
  int navIndex = 0;
  String searchText = '';
  final Set<String> favorites = {};

  final categories = const ['All pets', 'Dogs', 'Cats', 'Rabbits', 'Birds'];

  List<Pet> get filteredPets {
    return pets.where((pet) {
      final category = selectedCategory == 0 ||
          pet.type.toLowerCase() == categories[selectedCategory].substring(0, categories[selectedCategory].length - 1).toLowerCase();
      final query = searchText.toLowerCase();
      final search = pet.name.toLowerCase().contains(query) ||
          pet.type.toLowerCase().contains(query) ||
          pet.location.toLowerCase().contains(query);
      final favoriteMatch = navIndex != 1 || favorites.contains(pet.name);
      return category && search && favoriteMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final showingFavorites = navIndex == 1;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 44, width: 44,
                          decoration: BoxDecoration(color: paleGreen, borderRadius: BorderRadius.circular(15)),
                          child: const Icon(Icons.pets_rounded, color: green, size: 25),
                        ),
                        const SizedBox(width: 10),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('PawPal', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: ink)),
                            Text('A little love goes a long way', style: TextStyle(fontSize: 11, color: muted)),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('You are all caught up!')),
                          ),
                          icon: const Icon(Icons.notifications_none_rounded, color: ink),
                          style: IconButton.styleFrom(backgroundColor: Colors.white),
                        ),
                        CircleAvatar(
                          radius: 21,
                          backgroundColor: const Color(0xFFF0E3D4),
                          child: const Icon(Icons.person_rounded, color: ink),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    const Text('Your next great', style: TextStyle(fontSize: 29, height: 1.1, fontWeight: FontWeight.w800, color: ink)),
                    const Row(
                      children: [
                        Text('adventure ', style: TextStyle(fontSize: 29, height: 1.1, fontWeight: FontWeight.w800, color: green)),
                        Text('has paws.', style: TextStyle(fontSize: 29, height: 1.1, fontWeight: FontWeight.w800, color: ink)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text('Meet your new best friend and make memories together.', style: TextStyle(color: muted, fontSize: 13)),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF315F52), Color(0xFF5B907B)],
                          begin: Alignment.topLeft, end: Alignment.bottomRight,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(color: Colors.white.withOpacity(.17), borderRadius: BorderRadius.circular(20)),
                                  child: const Text('ADOPT • DON’T SHOP', style: TextStyle(color: Colors.white, fontSize: 9, letterSpacing: 1.1, fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(height: 12),
                                const Text('A new chapter\nstarts with you.', style: TextStyle(color: Colors.white, fontSize: 22, height: 1.15, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 7),
                                const Text('Give a loving pet a forever home.', style: TextStyle(color: Colors.white70, fontSize: 11)),
                                const SizedBox(height: 13),
                                TextButton(
                                  onPressed: () => setState(() { selectedCategory = 0; navIndex = 0; }),
                                  style: TextButton.styleFrom(backgroundColor: Colors.white, foregroundColor: green, padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8)),
                                  child: const Text('Meet the pets', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 5),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              pets[0].image, width: 118, height: 150, fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const SizedBox(width: 118, height: 150, child: Icon(Icons.pets, color: Colors.white, size: 50)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    TextField(
                      onChanged: (value) => setState(() => searchText = value),
                      decoration: InputDecoration(
                        hintText: 'Search by name, type or location',
                        hintStyle: const TextStyle(fontSize: 12, color: muted),
                        prefixIcon: const Icon(Icons.search_rounded, color: green),
                        filled: true, fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(vertical: 15),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 22),
                    Row(
                      children: [
                        const Text('Explore pets', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: ink)),
                        const Spacer(),
                        Text('${filteredPets.length} found', style: const TextStyle(color: muted, fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 13),
                    SizedBox(
                      height: 39,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final selected = selectedCategory == index;
                          return ChoiceChip(
                            label: Text(categories[index]),
                            selected: selected,
                            onSelected: (_) => setState(() => selectedCategory = index),
                            backgroundColor: Colors.white,
                            selectedColor: green,
                            labelStyle: TextStyle(color: selected ? Colors.white : ink, fontWeight: FontWeight.w600, fontSize: 12),
                            side: BorderSide.none,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            if (filteredPets.isEmpty)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: Text('No pets found. Try another search.', style: TextStyle(color: muted))),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 22),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final pet = filteredPets[index];
                      return PetCard(
                        pet: pet,
                        favorite: favorites.contains(pet.name),
                        onFavorite: () => setState(() {
                          favorites.contains(pet.name) ? favorites.remove(pet.name) : favorites.add(pet.name);
                        }),
                      );
                    },
                    childCount: filteredPets.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 13, mainAxisSpacing: 14, childAspectRatio: .64,
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        height: 68,
        backgroundColor: Colors.white,
        indicatorColor: paleGreen,
        selectedIndex: navIndex,
        onDestinationSelected: (index) => setState(() => navIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.explore_outlined), selectedIcon: Icon(Icons.explore), label: 'Explore'),
          NavigationDestination(icon: Icon(Icons.favorite_border), selectedIcon: Icon(Icons.favorite), label: 'Saved'),
          NavigationDestination(icon: Icon(Icons.pets_outlined), selectedIcon: Icon(Icons.pets), label: 'My pets'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class PetCard extends StatelessWidget {
  final Pet pet;
  final bool favorite;
  final VoidCallback onFavorite;
  const PetCard({super.key, required this.pet, required this.favorite, required this.onFavorite});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PetDetailsPage(pet: pet))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(pet.image, fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(color: paleGreen, child: const Icon(Icons.pets, size: 45, color: green))),
                  Positioned(
                    top: 9, left: 9,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                      decoration: BoxDecoration(color: Colors.white.withOpacity(.93), borderRadius: BorderRadius.circular(20)),
                      child: Text(pet.tag, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: green)),
                    ),
                  ),
                  Positioned(
                    top: 7, right: 7,
                    child: Material(
                      color: Colors.white.withOpacity(.95), shape: const CircleBorder(),
                      child: IconButton(
                        visualDensity: VisualDensity.compact,
                        onPressed: onFavorite,
                        icon: Icon(favorite ? Icons.favorite : Icons.favorite_border, color: favorite ? Colors.red : ink, size: 19),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(11, 9, 11, 9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(pet.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: ink)),
                    const SizedBox(height: 3),
                    Text('${pet.type}  •  ${pet.age}', style: const TextStyle(fontSize: 10, color: muted)),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 13, color: green),
                        const SizedBox(width: 2),
                        Expanded(child: Text(pet.location, style: const TextStyle(fontSize: 10, color: muted), overflow: TextOverflow.ellipsis)),
                        const Icon(Icons.arrow_forward_rounded, size: 16, color: green),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PetDetailsPage extends StatelessWidget {
  final Pet pet;
  const PetDetailsPage({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 360, pinned: true, backgroundColor: green,
            leading: IconButton(
              icon: const CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.arrow_back, color: ink, size: 19)),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(fit: StackFit.expand, children: [
                Image.network(pet.image, fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(color: paleGreen, child: const Icon(Icons.pets, size: 70, color: green))),
                const DecoratedBox(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Color(0x66000000)]))),
                Positioned(left: 22, bottom: 24, child: Text(pet.name, style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w800))),
              ]),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(21, 22, 21, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    _infoPill(Icons.pets, pet.type),
                    const SizedBox(width: 8),
                    _infoPill(Icons.cake_outlined, pet.age),
                    const SizedBox(width: 8),
                    _infoPill(Icons.location_on_outlined, pet.location),
                  ]),
                  const SizedBox(height: 25),
                  const Text('A little about me', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: ink)),
                  const SizedBox(height: 9),
                  Text(pet.description, style: const TextStyle(fontSize: 14, height: 1.6, color: muted)),
                  const SizedBox(height: 22),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: paleGreen, borderRadius: BorderRadius.circular(18)),
                    child: const Row(children: [
                      Icon(Icons.volunteer_activism_outlined, color: green, size: 27),
                      SizedBox(width: 12),
                      Expanded(child: Text('Adoption gives a pet a safe home, care and a lifetime of love.', style: TextStyle(color: ink, fontSize: 12, height: 1.4))),
                    ]),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity, height: 54,
                    child: ElevatedButton.icon(
                      onPressed: () => showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          title: const Text('Adoption request'),
                          content: Text('Your request for ${pet.name} has been submitted! The adoption team will guide you through the next steps.'),
                          actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Done'))],
                        ),
                      ),
                      icon: const Icon(Icons.favorite_rounded),
                      label: const Text('Start adoption', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(backgroundColor: green, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoPill(IconData icon, String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 13, color: green),
      const SizedBox(width: 4),
      Text(text, style: const TextStyle(fontSize: 10, color: ink, fontWeight: FontWeight.w600)),
    ]),
  );
}