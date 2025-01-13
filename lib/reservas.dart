import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Para cargar archivos desde assets

class ReservationsPage extends StatefulWidget {
  final String email; // Email del usuario actual

  const ReservationsPage({Key? key, required this.email}) : super(key: key);

  @override
  _ReservationsPageState createState() => _ReservationsPageState();
}

class _ReservationsPageState extends State<ReservationsPage> {
  List<Map<String, dynamic>> _reservas = [];

  @override
  void initState() {
    super.initState();
    _cargarReservas();
  }

  // Función para cargar las reservas desde el archivo JSON
  Future<void> _cargarReservas() async {
    final String respuesta = await rootBundle.loadString('assets/usuarios.json');
    final Map<String, dynamic> data = json.decode(respuesta);

    // Encuentra el usuario por email y obtiene sus reservas
    final usuario = data['usuarios'].firstWhere(
      (u) => u['email'] == widget.email,
      orElse: () => null,
    );

    if (usuario != null && usuario['reservas'] != null) {
      setState(() {
        _reservas = List<Map<String, dynamic>>.from(usuario['reservas']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Reservas'),
        backgroundColor: const Color.fromARGB(255, 235, 180, 0), // Amarillo
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tus Reservas',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _reservas.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _reservas.length,
                      itemBuilder: (context, index) {
                        final reserva = _reservas[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: Icon(
                              reserva['tipo'] == 'vuelo'
                                  ? Icons.flight
                                  : Icons.hotel,
                              color: Colors.blueGrey,
                            ),
                            title: Text(reserva['detalle']),
                            subtitle: Text('Fecha: ${reserva['fecha']}'),
                            trailing: Text(reserva['estado']),
                            onTap: () {
                              // Mostrar detalles de la reserva
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Detalles de la Reserva'),
                                  content: Text(
                                      'Tipo: ${reserva['tipo']}\n'
                                      'Detalle: ${reserva['detalle']}\n'
                                      'Fecha: ${reserva['fecha']}\n'
                                      'Estado: ${reserva['estado']}'),
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
                      'No tienes reservas registradas.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
