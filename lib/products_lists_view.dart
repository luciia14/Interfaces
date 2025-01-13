import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'coches.dart';
import 'hoteles.dart';
import 'vuelos.dart';

class MainLayout extends StatefulWidget {
  final Map<String, dynamic> usuario;

  const MainLayout({Key? key, required this.usuario}) : super(key: key);

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
    ProfilePage(usuario: widget.usuario),
    const SearchCarsPage(),
    SearchFlightsPage(usuario: widget.usuario),  // Pasamos widget.usuario aquí
    const SearchHotelsPage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Row(
        children: [
          Container(
            width: 250,
            color: Colors.blueGrey[50],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/persona.jpg'),
                      ),
                      const SizedBox(height: 13),
                      Text(
                        widget.usuario['nombre'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey[800],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.usuario['email'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.home, color: Colors.blueGrey),
                  title: const Text('Inicio'),
                  onTap: () => _onItemTapped(0),
                ),
                ListTile(
                  leading: const Icon(Icons.person, color: Colors.blueGrey),
                  title: const Text('Perfil'),
                  onTap: () => _onItemTapped(1),
                ),
                ListTile(
                  leading: const Icon(Icons.directions_car, color: Colors.blueGrey),
                  title: const Text('Coches'),
                  onTap: () => _onItemTapped(2),
                ),
                ListTile(
                  leading: const Icon(Icons.flight, color: Colors.blueGrey),
                  title: const Text('Vuelos'),
                  onTap: () => _onItemTapped(3),
                ),
                ListTile(
                  leading: const Icon(Icons.hotel, color: Colors.blueGrey),
                  title: const Text('Hoteles'),
                  onTap: () => _onItemTapped(4),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
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
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.directions_car),
            title: const Text('Buscar Coches'),
            onTap: () => onItemSelected(2),
          ),
          ListTile(
            leading: const Icon(Icons.flight),
            title: const Text('Vuelos'),
            onTap: () => onItemSelected(3),
          ),
          ListTile(
            leading: const Icon(Icons.hotel),
            title: const Text('Hoteles'),
            onTap: () => onItemSelected(4),
          ),
        ],
      ),
    );
  }
}
