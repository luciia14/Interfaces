import 'package:flutter/material.dart';
import 'products_lists_view.dart';
class SearchHotelsPage extends StatefulWidget {
  final Map<String, dynamic> usuario;  // Asegúrate de pasar 'usuario' al widget

  const SearchHotelsPage({Key? key, required this.usuario}) : super(key: key);

  @override
  _SearchHotelsPageState createState() => _SearchHotelsPageState();
}

class _SearchHotelsPageState extends State<SearchHotelsPage> {
  final TextEditingController _searchController = TextEditingController();

  // Datos de hoteles agrupados por destino
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

  void _reserveHotel(String hotelName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmación de reserva'),
        content: Text('¿Quieres reservar el hotel $hotelName?'),
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
              // Navegar a MainLayout después de confirmar la reserva
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => MainLayout(usuario: widget.usuario),
                ),
                (route) => false, // Elimina las rutas anteriores
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
                // Espacio para la flecha
                const SizedBox(height: 40),

                const Text(
                  'Buscar Hoteles',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20), // Espacio entre la cabecera y el campo de búsqueda

                // Campo de búsqueda de hoteles
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
                  onChanged: _filterHotels,
                ),
                const SizedBox(height: 20),

                Expanded(
                  child: filteredHotels.isNotEmpty
                      ? ListView.builder(
                          itemCount: filteredHotels.length,
                          itemBuilder: (context, index) {
                            final hotel = filteredHotels[index];
                            final isFavorite = favoriteHotels.contains(hotel['name']);
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
                                      'assets/${hotel['name']}.png',
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
                                        IconButton(
                                          icon: Icon(
                                            isFavorite
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: isFavorite ? Colors.red : Colors.grey,
                                          ),
                                          onPressed: () => _toggleFavorite(hotel['name']!),
                                        ),
                                        ElevatedButton(
                                          onPressed: () => _reserveHotel(hotel['name']!),
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
                            'No se encontraron hoteles para este destino.',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ),
                ),
              ],
            ),
          ),

          // La flecha en la esquina izquierda
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
