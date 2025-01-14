import 'package:flutter/material.dart';
import 'reservas.dart';
import 'favoritos.dart';
import 'products_lists_view.dart';

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
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: const Color.fromARGB(255, 235, 180, 0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              child: Row(
                children: [
                  Text(
                    'Puntos acumulados: ${usuario['puntos']}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  // Tooltip al pasar el ratón sobre el icono
                  const Tooltip(
                    message:
                        'Los puntos acumulados se utilizan para obtener descuentos, recompensas exclusivas y otros beneficios dentro de la aplicación. ¡Sigue participando para ganar más!',
                    child: const Icon(
                      Icons.info_outline,
                      color: Colors.blue,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
