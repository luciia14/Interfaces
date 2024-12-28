import 'package:flutter/material.dart';
import 'package:flutter_application_1/login_view.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajustes'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Opción para cambiar el idioma
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Cambiar Idioma'),
              onTap: () {
                // Acción para cambiar el idioma
              },
            ),
            const Divider(),

            // Opción para cambiar el tema (oscuro o claro)
            ListTile(
              leading: const Icon(Icons.brightness_6),
              title: const Text('Cambiar Tema'),
              onTap: () {
                // Acción para cambiar el tema
              },
            ),
            const Divider(),

            // Opción para configurar notificaciones
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notificaciones'),
              onTap: () {
                // Acción para configurar notificaciones
              },
            ),
            const Divider(),

            // Opción para cerrar sesión
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar Sesión'),
              onTap: () {
                Navigator.push(
                  context,
                    MaterialPageRoute(builder: (context) => const LoginView()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
