import 'package:flutter/material.dart';
import 'products_lists_view.dart'; // Asegúrate de importar el MainLayout aquí

class ProfilePage extends StatelessWidget {
  final Map<String, dynamic> usuario;
  final void Function() navigateToReservations;
  final void Function() navigateToFavorites;

  const ProfilePage({
    Key? key,
    required this.usuario,
    required this.navigateToReservations,
    required this.navigateToFavorites,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Espacio adicional antes de la foto y nombre
                const SizedBox(height: 40),  // Aumenté este valor para más espacio

                Row(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/persona.jpg'),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          usuario['nombre'],
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Correo: ${usuario['email']}',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Teléfono: ${usuario['telefono']}',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Expanded(
                  child: ListView(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.bookmark, color: Colors.blueGrey),
                        title: const Text(
                          'Mis Reservas',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        onTap: navigateToReservations,
                      ),
                      ListTile(
                        leading: const Icon(Icons.favorite, color: Colors.blueGrey),
                        title: const Text(
                          'Favoritos',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        onTap: navigateToFavorites,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Puntos acumulados: ${usuario['puntos']}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // La flecha en la esquina izquierda
          Positioned(
            top: 30, // Ajusta la posición vertical
            left: 10, // Ajusta la posición horizontal
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 40.0,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainLayout(usuario: usuario),
                  ),
                  (route) => false, // Elimina las rutas anteriores
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
