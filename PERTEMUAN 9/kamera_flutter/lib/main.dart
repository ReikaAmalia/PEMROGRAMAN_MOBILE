import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'widget/takepicture_screen.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  // Pastikan plugin kamera diinisialisasi sebelum digunakan.
  WidgetsFlutterBinding.ensureInitialized();

  // Dapatkan daftar kamera yang tersedia di device.
  cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: TakePictureScreen(
        // Pass kamera pertama ke widget TakePictureScreen.
        camera: firstCamera,
      ),
    ),
  );
}