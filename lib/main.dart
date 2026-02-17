import 'package:flutter/material.dart';

void main() => runApp(const AlaBurgerApp());

class AlaBurgerApp extends StatelessWidget {
  const AlaBurgerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Verdana', // Usamos una fuente estándar robusta
      ),
      home: const MenuAlaburger(),
    );
  }
}

class MenuAlaburger extends StatefulWidget {
  const MenuAlaburger({super.key});

  @override
  State<MenuAlaburger> createState() => _MenuAlaburgerState();
}

class _MenuAlaburgerState extends State<MenuAlaburger> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Animación para el efecto de "fuego" (parpadeo sutil)
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D), // Negro carbón casi total
      body: Stack(
        children: [
          // LLAMAS ANIMADAS DE FONDO
          FadeTransition(
            opacity: Tween(begin: 0.1, end: 0.3).animate(_controller),
            child: Stack(
              children: [
                Positioned(
                  left: -40,
                  bottom: 150,
                  child: Icon(Icons.local_fire_department, size: 200, color: Colors.orange.shade900),
                ),
                Positioned(
                  right: -40,
                  top: 100,
                  child: Icon(Icons.local_fire_department, size: 200, color: Colors.red.shade900),
                ),
              ],
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // APP BAR PERSONALIZADA
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Tooltip(
                        message: 'Favoritos',
                        child: const Icon(Icons.star_rounded, color: Colors.orange, size: 32),
                      ),
                      Tooltip(
                        message: 'Buscar',
                        child: const Icon(Icons.search_rounded, color: Colors.white, size: 32),
                      ),
                    ],
                  ),
                ),

                // TÍTULO CON NUEVA JERARQUÍA
                const Text(
                  'MENU',
                  style: TextStyle(
                    fontSize: 70, // Super grande
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                    letterSpacing: 4,
                    height: 0.9,
                    shadows: [
                      Shadow(color: Colors.orange, blurRadius: 20, offset: Offset(0, 4)),
                      Shadow(color: Colors.red, blurRadius: 40),
                    ],
                  ),
                ),
                const Text(
                  'by Alaburger al Carbón',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.orangeAccent,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(height: 30),

                // GRILLA DE COMIDA
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.78,
                      children: const [
                        FoodItem(
                          name: 'CARNE POLLO',
                          price: '180',
                          img: 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=400',
                        ),
                        FoodItem(
                          name: 'VEGANA',
                          price: '150',
                          img: 'https://images.unsplash.com/photo-1520072959219-c595dc870360?w=400',
                        ),
                        FoodItem(
                          name: 'ULTRA QUESO',
                          price: '250',
                          img: 'https://images.unsplash.com/photo-1594212699903-ec8a3eca50f5?w=400',
                        ),
                        FoodItem(
                          name: 'GASEOSA',
                          price: '25',
                          img: 'https://images.unsplash.com/photo-1622483767028-3f66f32aef97?w=400',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      
      // NAVBAR INFERIOR CON TOOLTIPS
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          border: Border(top: BorderSide(color: Colors.orange.withOpacity(0.2))),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Tooltip(
              message: 'Atrás',
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white70),
                onPressed: () {},
              ),
            ),
            Tooltip(
              message: 'Perfil',
              child: IconButton(
                icon: const Icon(Icons.person_pin, color: Colors.orange, size: 38),
                onPressed: () {},
              ),
            ),
            Tooltip(
              message: 'Inicio',
              child: IconButton(
                icon: const Icon(Icons.home_filled, color: Colors.white70),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FoodItem extends StatelessWidget {
  final String name;
  final String price;
  final String img;

  const FoodItem({super.key, required this.name, required this.price, required this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.orange.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 10, offset: const Offset(0, 5))
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
              child: Image.network(
                img, 
                fit: BoxFit.cover, 
                width: double.infinity,
                // Manejo de error si la imagen no carga
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.fastfood, size: 50),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 1),
                ),
                const SizedBox(height: 6),
                Text(
                  '\$$price',
                  style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.w900, fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}