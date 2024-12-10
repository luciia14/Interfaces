// profile_page.dart

import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil de Usuario'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen de perfil
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage('https://www.example.com/profile-image.jpg'),
              ),
            ),
            const SizedBox(height: 16),
            // Nombre y correo
            Center(
              child: Column(
                children: const [
                  Text(
                    'Nombre del Usuario',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'usuario@ejemplo.com',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Opciones de perfil
            ListView(
              shrinkWrap: true, // Permite que la lista no ocupe todo el espacio
              physics: NeverScrollableScrollPhysics(), // Desactiva el scroll en esta lista
              children: [
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('Editar Perfil'),
                  onTap: () {
                    // Navegar a la pantalla de edición de perfil
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.lock),
                  title: const Text('Cambiar Contraseña'),
                  onTap: () {
                    // Navegar a la pantalla de cambio de contraseña
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text('Notificaciones'),
                  onTap: () {
                    // Navegar a la pantalla de configuración de notificaciones
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Cerrar Sesión'),
                  onTap: () {
                    // Lógica para cerrar sesión
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
