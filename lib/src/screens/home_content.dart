import 'package:flutter/material.dart';
import 'package:frontend/src/models/order.dart';
import 'package:frontend/src/screens/home_content/cerca_ti.dart';
import 'package:frontend/src/screens/home_content/inicio.dart';
import 'package:frontend/src/screens/home_content/rendimiento.dart';
import 'package:frontend/src/services/utilities.dart';
import 'package:frontend/src/widgets/active_orders/active_order_list.dart';
import 'package:frontend/src/widgets/orders/order_list.dart';

class HomeContent extends StatefulWidget {

  HomeContent({
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _HomeContentState();
  }
}

class _HomeContentState extends State<HomeContent> {
  int _currentIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    _screens = [
      Inicio(),
      CercaTi(),
      Rendimiento(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Utilidades',
            style: TextStyle(fontSize: 16),
          ),
          Utilities(onItemTapped: _onItemTapped),
          Expanded(
            child: _screens[_currentIndex],
          ),
        ],
      ),
    );
  }
}
