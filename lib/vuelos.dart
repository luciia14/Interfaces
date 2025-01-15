import 'package:flutter/material.dart';
import  'products_lists_view.dart';

class SearchFlightsPage extends StatefulWidget {
  final Map<String, dynamic> usuario;
  const SearchFlightsPage({Key? key, required this.usuario}) : super(key: key);

  @override
  _SearchFlightsPageState createState() => _SearchFlightsPageState();
}

class _SearchFlightsPageState extends State<SearchFlightsPage> {
  final TextEditingController _departureController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  bool isSearchEnabled = false;
  bool _idaSeleccionada = false;


  Map<String, String>? _vueloIdaSeleccionado;
  Map<String, String>? _vueloVueltaSeleccionado;

  // Vuelos disponibles
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
        // Cancelar button
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog without doing anything
          },
          child: const Text('Cancelar'),
        ),
        // Aceptar button
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
            // Show a success message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Reserva realizada con éxito')),
            );
            // Navigate to the main layout after the reservation is confirmed
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => MainLayout(usuario: widget.usuario),
              ),
              (route) => false, // Eliminate all previous routes
            );
          },
          child: const Text('Aceptar'),
        ),
      ],
    ),
  );
}


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

  // Función para obtener los vuelos filtrados
  List<Map<String, String>> getFilteredVuelos() {
    final salida = _departureController.text;
    final destino = _destinationController.text;

    if (_checkInDate != null && _checkOutDate != null && salida.isNotEmpty && destino.isNotEmpty) {
      // Filtrar vuelos de ida según la ciudad de salida y destino
      if (!_idaSeleccionada) {
        if (vuelos[salida] != null && vuelos[salida]![destino] != null) {
          return vuelos[salida]![destino]!;
        }
      } else {
        // Filtrar vuelos de vuelta según el destino
        if (vuelosVuelta[destino] != null) {
          return vuelosVuelta[destino]!;
        }
      }
    }
    return [];
  }

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          _checkInDate = picked;
        } else {
          _checkOutDate = picked;
        }
        isSearchEnabled = _checkInDate != null && _checkOutDate != null && _departureController.text.isNotEmpty && _destinationController.text.isNotEmpty;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 40), // Espacio para la flecha
                const Text(
                  'Buscar Vuelos',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20), // Espacio entre la cabecera y el campo de búsqueda

                // Campo de Ciudad de Salida
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

                // Campo de Ciudad de Destino
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

                // Mostrar texto de selección de vuelo
                if (_idaSeleccionada && _vueloIdaSeleccionado != null)
                  const Text(
                    'Selecciona vuelo de ida',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                if (!_idaSeleccionada)
                  const Text(
                    'Selecciona vuelo de vuelta',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                // Espacio para las fechas
                Row(
                  children: [
                    const SizedBox(width: 8), // Espacio entre los elementos
                    // Icono para la fecha de ida
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context, true), // Fecha de ida
                    ),
                    const SizedBox(width: 8), // Espacio entre los elementos
                    // Mostrar la fecha de ida
                    Text(
                      _checkInDate == null ? 'Fecha Entrada' : '${_checkInDate!.day}/${_checkInDate!.month}/${_checkInDate!.year}',
                      style: const TextStyle(fontSize: 16, color: Colors.blueGrey),
                    ),
                    const SizedBox(width: 8), // Espacio entre las fechas
                    // Icono para la fecha de salida
                    IconButton(
                      icon: const Icon(Icons.calendar_today_outlined),
                      onPressed: () => _selectDate(context, false), // Fecha de salida
                    ),
                    const SizedBox(width: 8), // Espacio entre los elementos
                    // Mostrar la fecha de salida
                    Text(
                      _checkOutDate == null ? 'Fecha Salida' : '${_checkOutDate!.day}/${_checkOutDate!.month}/${_checkOutDate!.year}',
                      style: const TextStyle(fontSize: 16, color: Colors.blueGrey),
                    ),
                    const SizedBox(width: 8), // Espacio entre los elementos
                    // Botón de búsqueda
                    ElevatedButton(
                      onPressed: isSearchEnabled ? () => setState(() {}) : null, // Solo busca si la búsqueda está habilitada
                      child: const Text('Buscar'),
                    ),
                  ],
                ),
                const SizedBox(height: 20), // Espacio entre la barra de búsqueda y la lista de vuelos

                // Lista de vuelos filtrados
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

          Positioned(
          top: 20, // Ajusta la posición vertical para que quede en la parte superior
          left: 10, // Ajusta la posición horizontal para que quede en el borde izquierdo
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
                  builder: (context) => MainLayout(usuario: widget.usuario),
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
