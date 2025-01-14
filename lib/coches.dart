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
  final TextEditingController _peopleController = TextEditingController();

  DateTime? _pickupDate;
  DateTime? _returnDate;

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
  bool _searchPerformed = false;

  bool get isSearchEnabled {
    return _searchController.text.isNotEmpty &&
           _peopleController.text.isNotEmpty &&
           int.tryParse(_peopleController.text) != null &&
           int.parse(_peopleController.text) <= 5 &&
           _pickupDate != null &&
           _returnDate != null &&
           _pickupDate!.isBefore(_returnDate!);
  }

  void _filterCars() {
    setState(() {
      final query = _searchController.text.trim();
      if (carsByDestination.containsKey(query)) {
        filteredCars = carsByDestination[query]!;
      } else {
        filteredCars = [];
      }
      _searchPerformed = true;
    });
  }

  Future<void> _selectPickupDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (pickedDate != null) {
      setState(() {
        _pickupDate = pickedDate;
        if (_returnDate != null && _returnDate!.isBefore(_pickupDate!)) {
          _returnDate = null;
        }
      });
    }
  }

  Future<void> _selectReturnDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _pickupDate ?? DateTime.now(),
      firstDate: _pickupDate ?? DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (pickedDate != null) {
      setState(() {
        _returnDate = pickedDate;
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

  void _reserveCar(String carName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmación de reserva'),
        content: Text('¿Quieres reservar el coche $carName?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Reserva realizada con éxito')),
              );
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => MainLayout(usuario: widget.usuario),
                ),
                (route) => false,
              );
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
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
                const Text(
                  'Buscar Coches',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Buscar destino',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 20),

                TextField(
                  controller: _peopleController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Número de personas (máx. 5)',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 20),

                ElevatedButton.icon(
                  onPressed: () => _selectPickupDate(context),
                  icon: const Icon(Icons.calendar_today),
                  label: Text(_pickupDate == null
                      ? 'Seleccionar fecha de recogida'
                      : 'Recogida: ${_pickupDate!.day}/${_pickupDate!.month}/${_pickupDate!.year}'),
                ),
                const SizedBox(height: 10),

                ElevatedButton.icon(
                  onPressed: () => _selectReturnDate(context),
                  icon: const Icon(Icons.calendar_today),
                  label: Text(_returnDate == null
                      ? 'Seleccionar fecha de devolución'
                      : 'Devolución: ${_returnDate!.day}/${_returnDate!.month}/${_returnDate!.year}'),
                ),
                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: isSearchEnabled ? _filterCars : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSearchEnabled ? Colors.blue : Colors.grey,
                  ),
                  child: const Text('Buscar Coches'),
                ),
                const SizedBox(height: 20),

                Expanded(
                  child: ListView.builder(
                    itemCount: filteredCars.length,
                    itemBuilder: (context, index) {
                      final car = filteredCars[index];
                      final isFavorite = favoriteCars.contains(car['name']);
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 12.0),
                        child: ListTile(
                          leading: Image.asset(
                            'assets/${car['name']}.png',
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          title: Text(car['name']!),
                          subtitle: Text('${car['price']} - ${car['seats']} plazas'),
                          trailing: IconButton(
                            icon: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.grey,
                            ),
                            onPressed: () => _toggleFavorite(car['name']!),
                          ),
                          onTap: () => _reserveCar(car['name']!),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 30, // Ajusta la posición vertical
            left: 10, // Ajusta la posición horizontal
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
              }, // Redirige al Home
            ),
          ),
        ],
      ),
    );
  }
}
