import 'package:flutter/material.dart';
import 'package:frontend/src/models/order.dart';
import 'package:frontend/src/services/utilities.dart';
import 'package:frontend/src/widgets/active_deliveries/active_order_list.dart';

class HomeContent extends StatefulWidget {
  final List<Order> registeredOrders;
  final Widget mainOrder;

  HomeContent({super.key, required this.registeredOrders, required this.mainOrder});

  @override
  State<StatefulWidget> createState() {
    return _HomeContentState();
  }
}

class _HomeContentState extends State<HomeContent> {
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

    // Gestion de ordenes activas
    Widget mainNewOrder = const Center(
      child: Text('No tienes ordenes activas'),
    );

    if (_activeOrders.isNotEmpty) {
      mainNewOrder = ActiveOrderList(active_orders: _activeOrders);
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
            child: widget.mainOrder,
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
