import 'package:flutter/material.dart';

class Rendimiento extends StatefulWidget {
  Rendimiento({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RendimientoState();
  }
}

class _RendimientoState extends State<Rendimiento> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text(
        'Graficas del rendimiento del repartidor',
      ),
    );
  }
}
