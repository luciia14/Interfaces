import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'coches.dart';
import 'hoteles.dart';
import 'vuelos.dart';
import 'reservas.dart';
import 'favoritos.dart';
import 'login_view.dart';

class MainLayout extends StatefulWidget {
  final Map<String, dynamic> usuario;

  const MainLayout({Key? key, required this.usuario}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;
  bool _isProfileExpanded = false;
  late List<Widget> _pages;
  Widget? _currentPage;
  List<String> _breadcrumbs = ['Inicio'];

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(onItemSelected: _onItemSelected),
      ProfilePage(
        usuario: widget.usuario,
        navigateToReservations: _navigateToReservations,
        navigateToFavorites: _navigateToFavorites,
      ),
      SearchCarsPage(usuario: widget.usuario),
      SearchFlightsPage(usuario: widget.usuario),
      SearchHotelsPage(usuario: widget.usuario),
    ];
    _currentPage = _pages[0];
  }

  void _navigateToReservations() {
    setState(() {
      _currentPage = ReservationsPage(email: widget.usuario['email']);
      _breadcrumbs.add('Reservas');
    });
  }

  void _navigateToFavorites() {
    setState(() {
      _currentPage = FavoritesPage(email: widget.usuario['email']);
      _breadcrumbs.add('Favoritos');
    });
  }

  void _navigateToHome() {
    setState(() {
      _selectedIndex = 0;
      _currentPage = _pages[0];
      _breadcrumbs = ['Inicio'];
    });
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginView(),
      ),
    );
  }

  void _onItemSelected(int index, String pageName) {
    setState(() {
      _selectedIndex = index;
      _currentPage = _pages[index];
      _breadcrumbs.add(pageName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/logo_app_color.png', height: 50),
            const SizedBox(width: 25),
            const Text(
              'Bienvenido a Trekko',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF8A2BE2), // Lila
      ),
      drawer: Drawer(
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
              onTap: _navigateToHome,
            ),
            Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.person, color: Colors.blueGrey),
                  title: Row(
                    children: [
                      const Expanded(child: Text('Perfil')),
                      IconButton(
                        icon: Icon(
                          _isProfileExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                          color: Colors.blueGrey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isProfileExpanded = !_isProfileExpanded;
                          });
                        },
                      ),
                    ],
                  ),
                  onTap: () => _onItemSelected(1, 'Perfil'),
                ),
                if (_isProfileExpanded) ...[
                  ListTile(
                    leading: const Icon(Icons.bookmark, color: Colors.blueGrey),
                    title: const Text('Reservas'),
                    contentPadding: const EdgeInsets.only(left: 32.0),
                    onTap: _navigateToReservations,
                  ),
                  ListTile(
                    leading: const Icon(Icons.favorite, color: Colors.blueGrey),
                    title: const Text('Favoritos'),
                    contentPadding: const EdgeInsets.only(left: 32.0),
                    onTap: _navigateToFavorites,
                  ),
                ],
              ],
            ),
            ListTile(
              leading: const Icon(Icons.directions_car, color: Colors.blueGrey),
              title: const Text('Coches'),
              onTap: () => _onItemSelected(2, 'Coches'),
            ),
            ListTile(
              leading: const Icon(Icons.flight, color: Colors.blueGrey),
              title: const Text('Vuelos'),
              onTap: () => _onItemSelected(3, 'Vuelos'),
            ),
            ListTile(
              leading: const Icon(Icons.hotel, color: Colors.blueGrey),
              title: const Text('Hoteles'),
              onTap: () => _onItemSelected(4, 'Hoteles'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.blueGrey),
              title: const Text('Cerrar sesión'),
              onTap: _logout,
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(child: _currentPage ?? const SizedBox()),
                _buildFooter(), // Aquí agregamos el pie de página
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      color: const Color(0xFFD6ED9E), // Verde claro
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 28),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo_app_color.png', height: 40),
              const SizedBox(width: 8),
              const Text(
                'Trekko',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF8A2BE2), // Lila
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ayuda'),
                  Text('Configuración de privacidad'),
                  Text('Iniciar sesión'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Política de cookies'),
                  Text('Política de privacidad'),
                  Text('Términos de servicio'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Breadcrumb extends StatelessWidget {
  final List<String> crumbs;

  const Breadcrumb({Key? key, required this.crumbs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: crumbs.map((crumb) => Text('$crumb > ')).toList(),
    );
  }
}

class HomePage extends StatelessWidget {
  final Function(int, String) onItemSelected;

  const HomePage({
    Key? key, 
    required this.onItemSelected
  }) : super(key: key);

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
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSquareButton(
                icon: Icons.directions_car,
                label: 'Coches',
                onTap: () => onItemSelected(2, 'Coches'),
                backgroundImage: 'assets/alquiler_coches.jpg',
              ),
              _buildSquareButton(
                icon: Icons.flight,
                label: 'Vuelos',
                onTap: () => onItemSelected(3, 'Vuelos'),
                backgroundImage: 'assets/avion_reserva.jpg',
              ),
              _buildSquareButton(
                icon: Icons.hotel,
                label: 'Hoteles',
                onTap: () => onItemSelected(4, 'Hoteles'),
                backgroundImage: 'assets/reserva_hotel.jpg',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSquareButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required String backgroundImage,
  }) {
    return Container(
      width: 300,
      height: 300,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
