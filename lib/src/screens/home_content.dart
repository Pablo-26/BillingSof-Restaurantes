import 'package:flutter/material.dart';
import 'package:frontend/src/models/order.dart';
import 'package:frontend/src/services/utilities.dart';
import 'package:frontend/src/widgets/active_deliveries/active_order_list.dart';
import 'package:frontend/src/widgets/orders/order_list.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    final List<Order> _activeOrders = [
      Order(
        nameOrder: 'Chaulafan especial',
        restaurante: 'Misu Misu',
        status: 'Despachando',
        date: DateTime.now(),
        location: 'Juan Jose Pena y Lordes',
      ),
      Order(
        nameOrder: 'Chizza',
        restaurante: 'KFC',
        status: 'Listo para despacho',
        date: DateTime.now(),
        location: 'Supermaxi',
      ),
      Order(
        nameOrder: 'Parrillada',
        restaurante: 'Brasa y Leña',
        status: 'En preparacion',
        date: DateTime.now(),
        location: '18 de Noviembre y Lourdes',
      ),
    ];

    final List<Order> _registeredOrders = [
      Order(
        nameOrder: 'Big Box',
        restaurante: 'KFC',
        status: 'Listo para despacho',
        date: DateTime.now(),
        location: 'Gran AKI',
      ),
      Order(
        nameOrder: 'Pizza familiar',
        restaurante: 'Giro Pizza',
        status: 'En preparacion',
        date: DateTime.now(),
        location: 'Lourdes y Bernardo Valdivieso',
      ),
    ];

    // Gestion de ordenes activas
    Widget mainNewOrder = const Center(
      child: Text('No tienes ordenes activas'),
    );

    if (_activeOrders.isNotEmpty) {
      mainNewOrder = ActiveOrderList(active_orders: _activeOrders);
    }

    // Gestion de nuevas ordenes
    Widget mainOrder = const Center(
      child: Text('No hay nuevas ordenes'),
    );

    if (_registeredOrders.isNotEmpty) {
      mainOrder = OrderList(orders: _registeredOrders);
    }

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
          const Utilities(),
          const Text(
            'Entregas activas',
            style: TextStyle(fontSize: 16),
          ),
          Expanded(
            child: mainNewOrder,
          ),
          const Text(
            'Ordenes',
            style: TextStyle(fontSize: 16),
          ),
          Expanded(
            child: mainOrder,
          ),
          const Text(
            'Entregas realizadas',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
