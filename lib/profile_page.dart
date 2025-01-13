import 'package:flutter/material.dart';
import 'reservas.dart';
import 'favoritos.dart';
class ProfilePage extends StatelessWidget {
  final Map<String, dynamic> usuario;

  const ProfilePage({Key? key, required this.usuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: const Color.fromARGB(255, 235, 180, 0), // Color amarillo
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar e información del usuario
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
                      usuario['nombre'], // Nombre dinámico
                      style: const TextStyle(
                        fontSize: 36, // Tamaño grande
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Correo: ${usuario['email']}', // Correo dinámico
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Teléfono: ${usuario['telefono']}', // Teléfono dinámico
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
            // Lista con botones estilo ListTile
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(Icons.bookmark, color: Colors.blueGrey),
                    title: const Text(
                      'Mis Reservas',
                      style: TextStyle(fontSize: 18, color: Colors.black), // Color negro
                    ),
                     onTap: () {
                       Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReservationsPage(email: usuario['email']), 
                          ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.favorite, color: Colors.blueGrey),
                    title: const Text(
                      'Favoritos',
                      style: TextStyle(fontSize: 18, color: Colors.black), // Color negro
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FavoritesPage(email: usuario['email']), 
                          )
                      );
                    },
                  ),
                ],
              ),
            ),
            // Puntos acumulados en la esquina inferior izquierda
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
    );
  }
}
