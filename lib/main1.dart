import 'package:flutter/material.dart';
import 'package:frontend/google_map_page.dart';
import 'package:frontend/src/services/whatsapp_notify.dart'; // Asegúrate de que el nombre y la ruta del archivo sean correctos

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Maps Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WhatsappNotify(),
    );
  }
}
