import 'dart:convert'; // Para trabajar con JSON
import 'package:flutter/services.dart' show rootBundle; // Para cargar archivos desde assets

// Función para cargar usuarios desde el JSON
Future<List<Map<String, dynamic>>> cargarUsuarios() async {
  // Cargar el archivo JSON desde los assets
  final String respuesta = await rootBundle.loadString('assets/usuarios.json');
  
  // Decodificar el JSON a una lista de mapas
  final Map<String, dynamic> data = json.decode(respuesta);
  return List<Map<String, dynamic>>.from(data['usuarios']);
}

// Función para verificar las credenciales de inicio de sesión
Future<bool> verificarInicioSesion(String email, String contrasena) async {
  // Cargar usuarios desde el archivo JSON
  final List<Map<String, dynamic>> usuarios = await cargarUsuarios();

  // Buscar un usuario que coincida con el email y la contraseña
  for (final usuario in usuarios) {
    if (usuario['email'] == email && usuario['contraseña'] == contrasena) {
      return true; // Usuario válido
    }
  }
  return false; // Usuario no encontrado
}
