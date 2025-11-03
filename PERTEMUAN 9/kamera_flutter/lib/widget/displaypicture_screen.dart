import 'dart:io';
import 'package:flutter/material.dart';

// Widget yang menampilkan foto yang baru diambil pengguna.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture - 2341720173')),
      // Gambar disimpan sebagai file di device → tampilkan dengan Image.file.
      body: Image.file(File(imagePath)),
    );
  }
}
