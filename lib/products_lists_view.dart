
import 'package:flutter/material.dart';

class ProductsListView extends StatelessWidget {
  const ProductsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Productos'),
      ),
      body: ListView.builder(
        itemCount: 10, // Cantidad de productos de ejemplo
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.shopping_bag),
              title: Text('Producto ${index + 1}'),
              subtitle: Text('Descripción del producto ${index + 1}'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                // Acción al tocar el producto, como navegar a detalles
              },
            ),
          );
        },
      ),
    );
  }
}

