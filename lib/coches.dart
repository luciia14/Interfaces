import 'package:flutter/material.dart';
import 'products_lists_view.dart';

class SearchCarsPage extends StatefulWidget {
  final Map<String, dynamic> usuario;
  const SearchCarsPage({Key? key, required this.usuario}) : super(key: key);

  @override
  _SearchCarsPageState createState() => _SearchCarsPageState();
}

class _SearchCarsPageState extends State<SearchCarsPage> {
  final TextEditingController _searchController = TextEditingController();
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  int _seats = 1;
  bool isSearchEnabled = false;

  final Map<String, List<Map<String, String>>> carsByDestination = {
    'París': [
      {'name': 'Renault Clio', 'price': '45€/día', 'seats': '4'},
      {'name': 'Peugeot 208', 'price': '50€/día', 'seats': '5'},
      {'name': 'Citroen C3', 'price': '48€/día', 'seats': '4'},
    ],
    'Londres': [
      {'name': 'Ford Fiesta', 'price': '40€/día', 'seats': '4'},
      {'name': 'BMW Serie 1', 'price': '90€/día', 'seats': '5'},
      {'name': 'Mini Cooper', 'price': '70€/día', 'seats': '4'},
      {'name': 'Audi A3', 'price': '85€/día', 'seats': '5'},
    ],
  };

  List<Map<String, String>> filteredCars = [];
  final Set<String> favoriteCars = {};

  void _filterCars(String query) {
    setState(() {
      if (carsByDestination.containsKey(query)) {
        filteredCars = carsByDestination[query]!;
      } else {
        filteredCars = [];
      }
    });
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
        isSearchEnabled = _checkInDate != null && _checkOutDate != null && _searchController.text.isNotEmpty;
      });
    }
  }

  void _toggleFavorite(String carName) {
    setState(() {
      if (favoriteCars.contains(carName)) {
        favoriteCars.remove(carName);
      } else {
        favoriteCars.add(carName);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$carName se ha añadido a favoritos')),
        );
      }
    });
  }

  @override
 Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),  // Espacio para la flecha

              const Text(
                'Buscar Coches',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  // Campo de búsqueda para el destino
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'Destino',
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          isSearchEnabled = _checkInDate != null && _checkOutDate != null && value.isNotEmpty;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8), // Espacio entre los elementos
                  // Icono para la fecha de entrada
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context, true), // Fecha de entrada
                  ),
                  const SizedBox(width: 8), // Espacio entre los elementos
                  // Mostrar la fecha de entrada
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
                    onPressed: isSearchEnabled ? () => _filterCars(_searchController.text) : null,
                    child: const Text('Buscar'),
                  ),
                ],
              ),
              const SizedBox(height: 20), // Espacio entre la barra de búsqueda y la lista de coches

              // Lista de coches
              Expanded(
                child: ListView.builder(
                  itemCount: filteredCars.length,
                  itemBuilder: (context, index) {
                    final car = filteredCars[index];
                    final isFavorite = favoriteCars.contains(car['name']);
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 12.0),
                      elevation: 12,  // Aumentamos la sombra de la tarjeta para más destacada
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),  // Borde más redondeado
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            // Imagen del coche más grande
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),  // Borde redondeado de la imagen
                              child: Image.asset(
                                'assets/${car['name']}.png',
                                height: 180, // Aumentamos el tamaño de la imagen
                                width: 220,  // Aumentamos el tamaño de la imagen
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 20),  // Espacio entre la imagen y los textos
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    car['name']!,
                                    style: const TextStyle(
                                      fontSize: 26,  // Aumentamos el tamaño del texto
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${car['price']} - ${car['seats']} plazas',
                                    style: const TextStyle(
                                      fontSize: 18,  // Tamaño de texto más grande
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                // Corazón para favoritos
                                IconButton(
                                  icon: Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isFavorite ? Colors.red : Colors.grey,
                                  ),
                                  onPressed: () => _toggleFavorite(car['name']!),
                                ),
                                // Botón de reservar al lado del corazón
                                ElevatedButton(
                                  onPressed: null,  // No hace nada por ahora
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text('Reservar'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        // Aquí está el Positioned que coloca la flecha en la esquina superior izquierda
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
