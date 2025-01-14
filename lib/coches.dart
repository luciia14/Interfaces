import 'package:flutter/material.dart';

class SearchCarsPage extends StatefulWidget {
  const SearchCarsPage({Key? key}) : super(key: key);

  @override
  _SearchCarsPageState createState() => _SearchCarsPageState();
}

class _SearchCarsPageState extends State<SearchCarsPage> {
  final TextEditingController _searchController = TextEditingController();

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
              Navigator.pop(context);
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
      appBar: AppBar(
        title: const Text('Buscar Coches'),
        backgroundColor: const Color.fromARGB(255, 235, 180, 0), // Amarillo
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Buscar destino',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: _filterCars,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: filteredCars.isNotEmpty
                  ? ListView.builder(
                      itemCount: filteredCars.length,
                      itemBuilder: (context, index) {
                        final car = filteredCars[index];
                        final isFavorite = favoriteCars.contains(car['name']);

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 12.0),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/${car['name']}.png',
                                  height: 120,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        car['name']!,
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        '${car['price']} - ${car['seats']} plazas',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.blueGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: isFavorite ? Colors.red : Colors.grey,
                                      ),
                                      onPressed: () => _toggleFavorite(car['name']!),
                                    ),
                                    ElevatedButton(
                                      onPressed: () => _reserveCar(car['name']!),
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
                    )
                  : const Center(
                      child: Text(
                        'No se encontraron coches para este destino.',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
