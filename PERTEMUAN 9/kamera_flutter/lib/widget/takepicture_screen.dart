import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'displaypicture_screen.dart';

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({super.key, required this.camera});

  @override
  State<TakePictureScreen> createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // Inisialisasi kamera controller dengan resolusi medium.
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    // Simpan future inisialisasi kamera.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Jangan lupa dispose controller agar kamera dilepas saat widget ditutup.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture - 2341720XXX')),
      // Gunakan FutureBuilder untuk menunggu kamera siap.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Kamera siap → tampilkan preview.
            return CameraPreview(_controller);
          } else {
            // Masih loading → tampilkan spinner.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Tombol untuk mengambil gambar
        onPressed: () async {
          try {
            // Pastikan kamera sudah diinisialisasi.
            await _initializeControllerFuture;

            // Ambil gambar menggunakan kamera.
            final image = await _controller.takePicture();

            if (!context.mounted) return;

            // Navigasi ke halaman hasil foto.
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  // Kirim path gambar ke halaman berikutnya.
                  imagePath: image.path,
                ),
              ),
            );
          } catch (e) {
            // Jika error, tampilkan di console.
            print('Terjadi kesalahan saat mengambil gambar: $e');
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}