import 'package:flutter/material.dart';
import 'package:frontend/src/models/order.dart';
import 'package:frontend/src/models/user.dart';
import 'package:frontend/src/screens/home_content.dart';
import 'package:frontend/src/screens/orders_screen.dart';
import 'package:frontend/src/screens/profile_screen.dart';
import 'package:frontend/src/widgets/navigation_bar.dart';
import 'package:frontend/src/widgets/orders/order_list.dart';
import 'package:frontend/src/widgets/screen_header.dart';

class HomeScreen extends StatefulWidget {
  final User? currentUser;

  HomeScreen({super.key, required this.currentUser});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    // Gestion de la lista de ordnes nuevas
    Widget mainOrder = const Center(
      child: Text('No hay nuevas ordenes'),
    );

    if (_registeredOrders.isNotEmpty) {
      mainOrder = OrderList(orders: _registeredOrders);
    }

    super.initState();
    _screens = [
      HomeContent(),
      OrdersScreen(
        registeredOrders: _registeredOrders,
        mainOrder: mainOrder,
      ),
      ProfileScreen(user: widget.currentUser!),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // Gestion de pedidos activos
  final List<Order> _registeredOrders = [
    Order(
      nameOrder: 'Big Box',
      restaurante: 'KFC',
      status: 'Listo para despacho',
      date: DateTime.now(),
      location: 'Gran AKI',
      lat: -3.987714920670151, 
      long: -79.20248620094415,
    ),
    Order(
      nameOrder: 'Pizza familiar',
      restaurante: 'Giro Pizza',
      status: 'En preparacion',
      date: DateTime.now(),
      location: 'Lourdes y Bernardo Valdivieso',
      lat: -4.002086394771131, 
      long: -79.19722942729722
    ),
  ];

  // Gestion de nuevas ordenes


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          ScreenHeader(userName: widget.currentUser?.firstName ?? 'Usuario'),
          Expanded(
            child: _screens[_currentIndex],
          ),
        ],
      ),
      bottomNavigationBar: NavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
