import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Belanja',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
      ),
      // Daftar rute aplikasi
      routes: {
        '/': (context) => const ShoppingList(),
        '/item': (context) => const ItemPage(),
      },
    );
  }
}

class ShoppingList extends StatelessWidget {
  const ShoppingList({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'name': 'Sugar', 'price': 5000},
      {'name': 'Salt', 'price': 2000},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: items.length,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, index) {
          final item = items[index];
          return InkWell(
            onTap: () {
              // Pindah ke halaman item
              Navigator.pushNamed(context, '/item',
                  arguments: item); // kirim data item
            },
            child: Card(
              child: ListTile(
                title: Text(item['name'].toString()),
                trailing: Text(item['price'].toString()),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ItemPage extends StatelessWidget {
  const ItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as Map?;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: item == null
            ? const Text('No item selected')
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item['name'].toString(),
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Price: ${item['price']}",
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
      ),
    );
  }
}