
import 'package:flutter/material.dart';
import 'package:frontend/src/models/order.dart';
import 'package:frontend/src/widgets/active_deliveries/active_order_list.dart';
import 'package:frontend/src/widgets/orders/order_list.dart';

class Inicio extends StatelessWidget{
  final List<Order> activeOrders;
  final List<Order> registeredOrders;

  Inicio({super.key, required this.activeOrders, required this.registeredOrders});

  @override
  Widget build(BuildContext context) {
    // Gestion de ordenes activas
    Widget mainNewOrder = const Center(
      child: Text('No tienes ordenes activas'),
    );

    if (activeOrders.isNotEmpty) {
      mainNewOrder = ActiveOrderList(active_orders: activeOrders);
    }

    // Gestion de nuevas ordenes
    Widget mainOrder = const Center(
      child: Text('No hay nuevas ordenes'),
    );

    if (registeredOrders.isNotEmpty) {
      mainOrder = OrderList(orders: registeredOrders);
    }

    return Column(
      children: [
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
    );
  }
}