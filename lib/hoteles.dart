import 'package:flutter/material.dart';

class HotelPage extends StatelessWidget {
  const HotelPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista simulada de hoteles
    final List<Map<String, dynamic>> hotels = [
      {
        'name': 'Hotel Central Park',
        'location': 'New York, NY',
        'price': 150,
        'rating': 4.5,
        'availableRooms': 20,
      },
      {
        'name': 'Ocean View Resort',
        'location': 'Miami Beach, FL',
        'price': 200,
        'rating': 4.7,
        'availableRooms': 5,
      },
      {
        'name': 'Mountain Lodge',
        'location': 'Aspen, CO',
        'price': 300,
        'rating': 4.9,
        'availableRooms': 3,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hoteles Disponibles'),
        backgroundColor: const Color.fromARGB(255, 235, 180, 0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: hotels.length,
          itemBuilder: (context, index) {
            final hotel = hotels[index];
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
                      hotel['name'],
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
                          hotel['location'],
                          style: const TextStyle(color: Colors.grey),
                        ),
                        Text(
                          'Rating: ${hotel['rating']}★',
                          style: const TextStyle(color: Colors.blueGrey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'Available Rooms: ${hotel['availableRooms']}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '\$${hotel['price']} per night',
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
                        // Acción para seleccionar hotel
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Seleccionar Hotel'),
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
