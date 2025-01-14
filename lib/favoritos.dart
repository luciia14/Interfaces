import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class FavoritesPage extends StatefulWidget {
  final String email;

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

  Future<void> _cargarFavoritos() async {
    final String respuesta = await rootBundle.loadString('assets/usuarios.json');
    final Map<String, dynamic> data = json.decode(respuesta);

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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tus Favoritos',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Detalles del Favorito'),
                                content: Text('Estado: ${favorito['estado']}'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(),
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
    );
  }
}
