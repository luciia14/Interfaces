import 'package:flutter/material.dart';
import 'products_lists_view.dart';

class SearchHotelsPage extends StatefulWidget {
  final Map<String, dynamic> usuario;

  const SearchHotelsPage({Key? key, required this.usuario}) : super(key: key);

  @override
  _SearchHotelsPageState createState() => _SearchHotelsPageState();
}

class _SearchHotelsPageState extends State<SearchHotelsPage> {
  final TextEditingController _searchController = TextEditingController();
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  int _guests = 1;
  int _rooms = 1;
  bool isSearchEnabled = false;

  final Map<String, List<Map<String, String>>> hotelsByDestination = {
    'París': [
      {
        'name': 'Hotel Eiffel',
        'price': '150€/noche',
        'rating': '4.5',
        'capacity': '2',
        'location': 'Buena',
      },
      {
        'name': 'Hotel Louvre',
        'price': '200€/noche',
        'rating': '4.0',
        'capacity': '3',
        'location': 'Regular',
      },
    ],
    'Londres': [
      {
        'name': 'Hotel London Bridge',
        'price': '180€/noche',
        'rating': '4.7',
        'capacity': '2',
        'location': 'Buena',
      },
      {
        'name': 'Hotel Soho',
        'price': '250€/noche',
        'rating': '4.9',
        'capacity': '2',
        'location': 'Buena',
      },
    ],
  };

  List<Map<String, String>> filteredHotels = [];
  final Set<String> favoriteHotels = {};

  void _filterHotels(String query) {
    setState(() {
      if (hotelsByDestination.containsKey(query)) {
        filteredHotels = hotelsByDestination[query]!;
      } else {
        filteredHotels = [];
      }
    });
  }

  void _toggleFavorite(String hotelName) {
    setState(() {
      if (favoriteHotels.contains(hotelName)) {
        favoriteHotels.remove(hotelName);
      } else {
        favoriteHotels.add(hotelName);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$hotelName se ha añadido a favoritos')),
        );
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
                'Buscar Hoteles',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  SizedBox(
                    width: 270,
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
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => DoNothingAction
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () => _selectDate(context, true),
                    child: Text(_checkInDate == null ? 'Fecha Entrada' : '${_checkInDate!.day}/${_checkInDate!.month}/${_checkInDate!.year}'),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today_outlined),
                    onPressed: () => DoNothingAction
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () => _selectDate(context, false),
                    child: Text(_checkOutDate == null ? 'Fecha Salida' : '${_checkOutDate!.day}/${_checkOutDate!.month}/${_checkOutDate!.year}'),
                  ),
                  const SizedBox(width: 8),
                  DropdownButton<int>(
                    value: _guests,
                    onChanged: (value) => setState(() => _guests = value!),
                    items: List.generate(10, (index) => DropdownMenuItem(value: index + 1, child: Text('${index + 1} Huéspedes'))),
                  ),
                  DropdownButton<int>(
                    value: _rooms,
                    onChanged: (value) => setState(() => _rooms = value!),
                    items: List.generate(5, (index) => DropdownMenuItem(value: index + 1, child: Text('${index + 1} Habitación(es)'))),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: isSearchEnabled ? () => _filterHotels(_searchController.text) : null,
                    child: const Text('Buscar'),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredHotels.length,
                  itemBuilder: (context, index) {
                    final hotel = filteredHotels[index];
                    final isFavorite = favoriteHotels.contains(hotel['name']);
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 12.0),
                      elevation: 8, // Añadimos sombra para hacerlo más estético
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            // Imagen del hotel más grande
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                'assets/${hotel['name']}.png',
                                height: 150, // Aumentamos el tamaño de la imagen
                                width: 180,  // Aumentamos el tamaño de la imagen
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    hotel['name']!,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${hotel['price']} - ${hotel['capacity']} personas',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Text(
                                        'Puntuación: ${hotel['rating']}⭐',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.blueGrey,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Text(
                                        'Ubicación: ${hotel['location']}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: hotel['location'] == 'Buena'
                                              ? Colors.green
                                              : hotel['location'] == 'Regular'
                                                  ? Colors.orange
                                                  : Colors.red,
                                        ),
                                      ),
                                    ],
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
                                  onPressed: () => _toggleFavorite(hotel['name']!),
                                ),
                                // Botón de reservar al lado del corazón
                                ElevatedButton(
                                  onPressed: null ,
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
