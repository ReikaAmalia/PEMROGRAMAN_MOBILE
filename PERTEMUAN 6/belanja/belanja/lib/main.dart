import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router( 
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Belanja',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: router, // gunakan konfigurasi go_router
    );
  }
}
