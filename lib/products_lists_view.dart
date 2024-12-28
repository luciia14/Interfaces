import 'package:flutter/material.dart';

// Widget principal que contiene la barra lateral y superior constante
class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(onItemSelected: (index) => setState(() => _selectedIndex = index)),
      const SearchPage(option: 'Mis Reservas'),
      const ProfilePage(),
      const SettingsPage(),
      const SearchPage(option: 'Coche'),
      const SearchPage(option: 'Vuelo'),
      const HotelPage(),  // Se añade la nueva página de Hoteles
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Row(
        children: [
          // Barra lateral fija
          Container(
            width: 250,
            color: Colors.blueGrey[50],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Sección de perfil
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            AssetImage('assets/persona.jpg'),
                      ),
                      const SizedBox(height: 13),
                      Text(
                        'Usuario',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey[800],
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'usuario@correo.com',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),

                // Menú de navegación
                ListTile(
                  leading: const Icon(Icons.home, color: Colors.blueGrey),
                  title: const Text('Inicio'),
                  onTap: () => setState(() => _selectedIndex = 0),
                ),
                ListTile(
                  leading: const Icon(Icons.bookmark, color: Colors.blueGrey),
                  title: const Text('Mis Reservas'),
                  onTap: () => setState(() => _selectedIndex = 1),
                ),
                ListTile(
                  leading: const Icon(Icons.person, color: Colors.blueGrey),
                  title: const Text('Perfil'),
                  onTap: () => setState(() => _selectedIndex = 2),
                ),
                ListTile(
                  leading: const Icon(Icons.settings, color: Colors.blueGrey),
                  title: const Text('Ajustes'),
                  onTap: () => setState(() => _selectedIndex = 3),
                ),
              ],
            ),
          ),

          // Contenido principal
          Expanded(
            child: Column(
              children: [
                // Barra superior fija con logo
                Container(
                  width: double.infinity,
                  color: const Color.fromARGB(255, 235, 180, 0),
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/logo_app.png',
                        height: 70,
                      ),
                      const SizedBox(width: 25),
                      const Text(
                        'Bienvenido a nuestro portal de servicios',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // Página seleccionada
                Expanded(
                  child: IndexedStack(
                    index: _selectedIndex,
                    children: _pages,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Página de inicio
class HomePage extends StatelessWidget {
  final Function(int) onItemSelected;
  const HomePage({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '¿Qué estás buscando?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey[800],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          // Opción de Coche
          ListTile(
            leading: const Icon(Icons.directions_car, color: Colors.blueGrey),
            title: const Text('Coches de alquiler'),
            onTap: () => onItemSelected(4),
          ),
          // Opción de Vuelo
          ListTile(
            leading: const Icon(Icons.flight, color: Colors.blueGrey),
            title: const Text('Vuelos'),
            onTap: () => onItemSelected(5),
          ),
          // Opción de Hotel
          ListTile(
            leading: const Icon(Icons.hotel, color: Colors.blueGrey),
            title: const Text('Hoteles'),
            onTap: () => onItemSelected(6),
          ),
        ],
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  final String option;
  const SearchPage({Key? key, required this.option}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Barra de búsqueda
          TextField(
            decoration: InputDecoration(
              labelText: 'Buscar $option',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Aquí puedes agregar contenido adicional según la búsqueda
          Expanded(
            child: Center(
              child: Text(
                'Resultados de búsqueda para $option',
                style: TextStyle(fontSize: 18, color: Colors.blueGrey[600]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Página de perfil
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Página de Perfil'),
    );
  }
}

// Página de ajustes
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Página de Ajustes'),
    );
  }
}

// Página de Hoteles
class HotelPage extends StatelessWidget {
  const HotelPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista simulada de hoteles
    final List<Map<String, dynamic>> hotels = [
      {
        'name': 'Hotel Sunrise',
        'location': 'Miami, FL',
        'price': 150,
        'rating': 4.5,
      },
      {
        'name': 'Mountain Resort',
        'location': 'Aspen, CO',
        'price': 300,
        'rating': 4.8,
      },
      {
        'name': 'Beachfront Inn',
        'location': 'Los Angeles, CA',
        'price': 200,
        'rating': 4.3,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hoteles Disponibles'),
        backgroundColor: const Color.fromARGB(255, 235, 180, 0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: hotels.length,
          itemBuilder: (context, index) {
            final hotel = hotels[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hotel['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          hotel['location'],
                          style: const TextStyle(color: Colors.grey),
                        ),
                        Text(
                          '\$${hotel['price']} per night',
                          style: const TextStyle(color: Colors.blueGrey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'Rating: ${hotel['rating']}⭐',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        // Acción para seleccionar hotel
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Seleccionar Hotel'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
