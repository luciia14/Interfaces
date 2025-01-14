import 'package:flutter/material.dart';
import 'products_lists_view.dart';


class SearchFlightsPage extends StatefulWidget {
  final Map<String, dynamic> usuario;
  const SearchFlightsPage({Key? key, required this.usuario}) : super(key: key);

  @override
  _SearchFlightsPageState createState() => _SearchFlightsPageState();
}

class _SearchFlightsPageState extends State<SearchFlightsPage> {
  final TextEditingController _departureController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  bool _idaSeleccionada = false;
  Map<String, String>? _vueloIdaSeleccionado;
  Map<String, String>? _vueloVueltaSeleccionado;

  final Map<String, Map<String, List<Map<String, String>>>> vuelos = {
    'Alicante': {
      'Londres': [
        {'hora': '2:00', 'vuelo': 'AL123', 'price': '100€'},
        {'hora': '6:00', 'vuelo': 'AL456', 'price': '120€'},
        {'hora': '9:00', 'vuelo': 'AL789', 'price': '140€'},
      ],
      'París': [
        {'hora': '2:00', 'vuelo': 'AP123', 'price': '90€'},
        {'hora': '6:00', 'vuelo': 'AP456', 'price': '110€'},
        {'hora': '9:00', 'vuelo': 'AP789', 'price': '130€'},
      ],
    },
  };

  final Map<String, List<Map<String, String>>> vuelosVuelta = {
    'Londres': [
      {'hora': '4:00', 'vuelo': 'VL123', 'price': '80€'},
      {'hora': '6:00', 'vuelo': 'VL456', 'price': '100€'},
    ],
    'París': [
      {'hora': '4:00', 'vuelo': 'VP123', 'price': '70€'},
      {'hora': '6:00', 'vuelo': 'VP456', 'price': '90€'},
    ],
  };

  List<Map<String, String>> getFilteredVuelos() {
    final salida = _departureController.text;
    final destino = _destinationController.text;

    if (!_idaSeleccionada) {
      if (vuelos[salida] != null && vuelos[salida]![destino] != null) {
        return vuelos[salida]![destino]!;
      }
    } else {
      if (vuelosVuelta[destino] != null) {
        return vuelosVuelta[destino]!;
      }
    }
    return [];
  }

  void _confirmarReserva(BuildContext context, Map<String, dynamic> usuario) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Reserva'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Vuelo de ida: ${_vueloIdaSeleccionado!['vuelo']} - ${_vueloIdaSeleccionado!['hora']} - ${_vueloIdaSeleccionado!['price']}'),
            Text('Vuelo de vuelta: ${_vueloVueltaSeleccionado!['vuelo']} - ${_vueloVueltaSeleccionado!['hora']} - ${_vueloVueltaSeleccionado!['price']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Reserva realizada con éxito')),
              );
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => MainLayout(usuario: usuario),
                ),
                (route) => false,
              );
            },
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_idaSeleccionada
            ? 'Seleccionar vuelo de vuelta'
            : 'Seleccionar vuelo de ida'),
        backgroundColor: const Color.fromARGB(255, 235, 180, 0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _departureController,
              decoration: InputDecoration(
                labelText: 'Ciudad de salida',
                prefixIcon: const Icon(Icons.flight_takeoff),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _destinationController,
              decoration: InputDecoration(
                labelText: 'Ciudad de destino',
                prefixIcon: const Icon(Icons.flight_land),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Builder(
                builder: (context) {
                  final vuelosFiltrados = getFilteredVuelos();

                  if (vuelosFiltrados.isEmpty) {
                    return const Center(
                      child: Text(
                        'No se encontraron vuelos para este destino.',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: vuelosFiltrados.length,
                    itemBuilder: (context, index) {
                      final vuelo = vuelosFiltrados[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.airplane_ticket),
                          title: Text('Vuelo: ${vuelo['vuelo']}'),
                          subtitle: Text('${vuelo['hora']} - ${vuelo['price']}'),
                          onTap: () {
                            if (!_idaSeleccionada) {
                              setState(() {
                                _idaSeleccionada = true;
                                _vueloIdaSeleccionado = vuelo;
                              });
                            } else {
                              setState(() {
                                _vueloVueltaSeleccionado = vuelo;
                              });
                              _confirmarReserva(context, widget.usuario);
                            }
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


