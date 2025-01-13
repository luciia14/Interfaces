import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'coches.dart';
import 'hoteles.dart';
import 'vuelos.dart';
// Widget principal que contiene la barra lateral y superior constante
class MainLayout extends StatefulWidget {
  final Map<String, dynamic> usuario; // Parámetro para los datos del usuario

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
      const SearchPage(option: 'Vuelo'),
      const SearchPage(option: 'Hotel'), 
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
                  leading: const Icon(Icons.person, color: Colors.blueGrey),
                  title: const Text('Perfil'),
                  onTap: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                       builder: (context) => ProfilePage(usuario: widget.usuario), // Pasa los datos del usuario
                    ),
                  );
               },
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
            title: const Text('Buscar Coches'),
            onTap: () {
             Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchCarsPage()),
              );
            },
          ),
          // Opción de Vuelo
          ListTile(
            leading: const Icon(Icons.flight, color: Colors.blueGrey),
            title: const Text('Vuelos'),
            onTap: () {
              Navigator.push(
                context,
               MaterialPageRoute(
                builder: (context) => const SearchFlightsPage(),
              ),
           );
        },
      ),
          // Opción de Hotel
          ListTile(
            leading: const Icon(Icons.hotel, color: Colors.blueGrey),
            title: const Text('Hoteles'),
            onTap: () {
             Navigator.push(
               context,
              MaterialPageRoute(
              builder: (context) => const SearchHotelsPage(),
                  ),
               );
            },
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