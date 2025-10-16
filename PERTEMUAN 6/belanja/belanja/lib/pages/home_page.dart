import 'package:flutter/material.dart';
import '../models/item.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key}); // ✅ hapus const

  final List<Item> items = [
    Item(
      name: 'Makanan Kucing Me-O',
      price: 22000,
      image: 'image/meo.jpeg',
      stock: 10,
      rating: 4.8,
      heroTag: 'meo',
    ),
    Item(
      name: 'Americano',
      price: 15000,
      image: 'image/americano.jpg',
      stock: 5,
      rating: 4.5,
      heroTag: 'americano',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🛒 Daftar Produk'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
          final item = items[index];
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/item', arguments: item);
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
            Expanded(
              child: Hero(
                tag: item.heroTag,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12),
                  ),
                  child: Image.asset(
              item.image,
              fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
              item.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
                  ),
                  const SizedBox(height: 4),
                  Text(
              'Rp ${item.price}',
              style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
              'Stok: ${item.stock}',
              style: const TextStyle(fontSize: 12),
                  ),
                  Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 16,
                ),
                Text(
                  '${item.rating}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
                  ),
                ],
              ),
            ),
                ],
              ),
            ),
          );
              },
            ),
          ),

          // Bottom bar
          Container(
            color: Colors.blue,
            child: SafeArea(
              top: false,
              child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Dibuat oleh: Reika Amalia - 1234567890',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ],
          ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}