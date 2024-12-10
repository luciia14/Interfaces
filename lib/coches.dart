import 'package:flutter/material.dart';

class CochePage extends StatelessWidget {
  const CochePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista simulada de coches
    final List<Map<String, dynamic>> coches = [
      {
        'title': 'Compact',
        'description': '2 door | Ford Focus or similar',
        'price': 39,
        'deals': 4,
        'capacity': 4,
        'luggage': 3,
        'automatic': true,
        'ac': true,
        'pickup': 'Shuttle bus (EWR)'
      },
      {
        'title': 'Midsize',
        'description': '4 door | Nissan Sentra or similar',
        'price': 44,
        'deals': 7,
        'capacity': 5,
        'luggage': 3,
        'automatic': true,
        'ac': true,
        'pickup': 'Shuttle bus (EWR)'
      },
      {
        'title': 'Fullsize',
        'description': '4 door | Toyota Camry or similar',
        'price': 49,
        'deals': 5,
        'capacity': 5,
        'luggage': 4,
        'automatic': true,
        'ac': true,
        'pickup': 'Shuttle bus (EWR)'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Coches de Alquiler'),
        backgroundColor: const Color.fromARGB(255, 235, 180, 0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: coches.length,
          itemBuilder: (context, index) {
            final coche = coches[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Columna de información del coche
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            coche['title'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            coche['description'],
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.person, size: 18, color: Colors.grey[700]),
                              const SizedBox(width: 4),
                              Text('${coche['capacity']}'),
                              const SizedBox(width: 16),
                              Icon(Icons.luggage, size: 18, color: Colors.grey[700]),
                              const SizedBox(width: 4),
                              Text('${coche['luggage']}'),
                              const SizedBox(width: 16),
                              Icon(
                                coche['automatic'] ? Icons.settings : Icons.settings_outlined,
                                size: 18,
                                color: Colors.grey[700],
                              ),
                              const SizedBox(width: 4),
                              Text(coche['automatic'] ? 'Automatic' : 'Manual'),
                              const SizedBox(width: 16),
                              Icon(Icons.ac_unit, size: 18, color: Colors.grey[700]),
                              const SizedBox(width: 4),
                              Text(coche['ac'] ? 'AC' : 'No AC'),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Pickup: ${coche['pickup']}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    // Columna de precio y botón
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$${coche['price']}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Free cancellation',
                          style: TextStyle(color: Colors.green, fontSize: 12),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            // Acción para ver ofertas
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('View deals'),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${coche['deals']} deals from',
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
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
    );
  }
}
