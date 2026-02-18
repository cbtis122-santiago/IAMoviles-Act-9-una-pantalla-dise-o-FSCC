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
            opacity: Tween<double>(begin: 0.1, end: 0.3).animate(_controller),
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
                    children: <Widget>[
                      const Tooltip(
                        message: 'Favoritos',
                        child: Icon(Icons.star_rounded, color: Colors.orange, size: 32),
                      ),
                      const Tooltip(
                        message: 'Buscar',
                        child: Icon(Icons.search_rounded, color: Colors.white, size: 32),
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
                    shadows: <Shadow>[
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
                      children: const <FoodItem>[
                        FoodItem(
                          name: 'CARNE POLLO',
                          price: '180',
                          img: 'https://raw.githubusercontent.com/cbtis122-santiago/IAMoviles-Act-9-una-pantalla-dise-o-FSCC/master/carnepollo.jpg',
                        ),
                        FoodItem(
                          name: 'VEGANA',
                          price: '150',
                          img: 'https://raw.githubusercontent.com/cbtis122-santiago/IAMoviles-Act-9-una-pantalla-dise-o-FSCC/master/vegana.jpg',
                        ),
                        FoodItem(
                          name: 'ULTRA QUESO',
                          price: '250',
                          img: 'https://raw.githubusercontent.com/cbtis122-santiago/IAMoviles-Act-9-una-pantalla-dise-o-FSCC/master/ultraqueso.jpg',
                        ),
                        FoodItem(
                          name: 'GASEOSA',
                          price: '25',
                          img: 'https://raw.githubusercontent.com/cbtis122-santiago/IAMoviles-Act-9-una-pantalla-dise-o-FSCC/master/gaseosa.jpg',
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
        decoration: const BoxDecoration(
          color: Color(0xFF1A1A1A),
          border: Border(top: BorderSide(color: Colors.orange)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
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
        border: Border.all(color: Colors.orange),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Colors.black, blurRadius: 10, offset: Offset(0, 5))
        ],
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
              child: Image.network(
                img,
                fit: BoxFit.cover,
                width: double.infinity,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                          : null,
                      color: Colors.orange,
                    ),
                  );
                },
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.broken_image,
                      color: Colors.grey,
                      size: 50,
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: <Widget>[
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