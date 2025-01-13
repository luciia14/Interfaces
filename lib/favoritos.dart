import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Para cargar archivos desde assets

class FavoritesPage extends StatefulWidget {
  final String email; // Email del usuario actual

  const FavoritesPage({Key? key, required this.email}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Map<String, dynamic>> _favoritos = [];

  @override
  void initState() {
    super.initState();
    _cargarFavoritos();
  }

  // Función para cargar los favoritos desde el archivo JSON
  Future<void> _cargarFavoritos() async {
    final String respuesta = await rootBundle.loadString('assets/usuarios.json');
    final Map<String, dynamic> data = json.decode(respuesta);

    // Encuentra el usuario por email y obtiene sus favoritos
    final usuario = data['usuarios'].firstWhere(
      (u) => u['email'] == widget.email,
      orElse: () => null,
    );

    if (usuario != null && usuario['favoritos'] != null) {
      setState(() {
        _favoritos = List<Map<String, dynamic>>.from(usuario['favoritos']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
        backgroundColor: const Color.fromARGB(255, 235, 180, 0), // Amarillo
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tus Favoritos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _favoritos.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _favoritos.length,
                      itemBuilder: (context, index) {
                        final favorito = _favoritos[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: Icon(
                              favorito['tipo'] == 'hotel'
                                  ? Icons.hotel
                                  : Icons.directions_car,
                              color: Colors.blueGrey,
                            ),
                            title: Text(favorito['detalle']),
                            subtitle: Text(favorito['estado']),
                            onTap: () {
                              // Mostrar detalles del favorito
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Detalles del Favorito'),
                                  content: Text(

                                      'Estado: ${favorito['estado']}'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('Cerrar'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  )
                : const Center(
                    child: Text(
                      'No tienes favoritos registrados.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
