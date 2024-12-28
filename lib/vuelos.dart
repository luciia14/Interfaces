import 'package:flutter/material.dart';

class VueloPage extends StatelessWidget {
  const VueloPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista simulada de vuelos
    final List<Map<String, dynamic>> flights = [
      {
        'airline': 'American Airlines',
        'departure': 'New York (JFK)',
        'arrival': 'Los Angeles (LAX)',
        'price': 320,
        'duration': '6h 15m',
        'stops': 0,
      },
      {
        'airline': 'Delta Airlines',
        'departure': 'Boston (BOS)',
        'arrival': 'Miami (MIA)',
        'price': 240,
        'duration': '3h 45m',
        'stops': 1,
      },
      {
        'airline': 'United Airlines',
        'departure': 'Chicago (ORD)',
        'arrival': 'San Francisco (SFO)',
        'price': 400,
        'duration': '5h 50m',
        'stops': 0,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vuelos Disponibles'),
        backgroundColor: const Color.fromARGB(255, 235, 180, 0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: flights.length,
          itemBuilder: (context, index) {
            final flight = flights[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      flight['airline'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${flight['departure']} → ${flight['arrival']}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        Text(
                          '${flight['duration']}',
                          style: const TextStyle(color: Colors.blueGrey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'Stops: ${flight['stops']}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '\$${flight['price']}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        // Acción para seleccionar vuelo
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Seleccionar Vuelo'),
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
