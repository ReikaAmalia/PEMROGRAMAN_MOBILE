import 'dart:async';
import 'package:flutter/cupertino.dart'; 
import 'package:flutter/material.dart';
import 'basic_widgets/image_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Praktikum Flutter Gabungan',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Praktikum Widget Dasar Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  DateTime selectedDate = DateTime.now();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // Fungsi untuk Date and Time Pickers
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // Fungsi untuk Dialog Widget
  void _showAlertDialog() {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("My title"),
      content: const Text("This is my message."),
      actions: [okButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // 1. Logo / Image Widget
                const MyImageWidget(),

                const SizedBox(height: 20),

                // 2. Counter (Scaffold + FAB)
                const Text('You have pushed the button this many times:'),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),

                const SizedBox(height: 20),

                // 3. Dialog Widget
                ElevatedButton(
                  onPressed: _showAlertDialog,
                  child: const Text('Show Alert Dialog'),
                ),

                const SizedBox(height: 20),

                // 4. TextField
                const TextField(
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nama',
                  ),
                ),

                const SizedBox(height: 20),

                // 5. Date Picker
                Text("Tanggal terpilih: ${selectedDate.toLocal()}".split(' ')[0]),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: const Text("Pilih Tanggal"),
                ),

                const SizedBox(height: 30),

                // 6. Cupertino Button & Loading Indicator
                CupertinoButton(
                  child: const Text("Contoh Cupertino Button"),
                  onPressed: () {},
                ),
                const CupertinoActivityIndicator(),

                const SizedBox(height: 30),

                // 7. FAB Tambahan 
                FloatingActionButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("FAB Pink ditekan!")),
                    );
                  },
                  backgroundColor: Colors.pink,
                  child: const Icon(Icons.thumb_up),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(height: 50.0, color: Colors.deepPurple.shade100),
      ),
      // FAB utama counter
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}