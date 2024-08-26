import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/src/models/order.dart';
import 'package:frontend/src/widgets/active_orders/active_order_item.dart';

class ActiveOrderList extends StatelessWidget {
  const ActiveOrderList({super.key, required this.active_orders});

  final List<Order> active_orders;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: active_orders.map((order) => ActiveOrderItem(order)).toList(),
    );
  }
}
