import 'package:flutter/material.dart';
import 'package:frontend/src/models/order.dart';
import 'package:frontend/src/widgets/orders/order_item.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key, required this.orders});

  final List<Order> orders;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: orders.map((order) => OrderItem(order)).toList(),
    );
  }
}
