import 'package:flutter/material.dart';
import 'package:frontend/src/models/order.dart';

class OrdersScreen extends StatefulWidget {
  final List<Order> registeredOrders;
  final Widget mainOrder;

  OrdersScreen(
      {super.key, required this.registeredOrders, required this.mainOrder});

  @override
  State<StatefulWidget> createState() {
    return _OrdersScreenState();
  }
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ordenes',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: widget.mainOrder,
          ),
        ],
      ),
    );
  }
}
