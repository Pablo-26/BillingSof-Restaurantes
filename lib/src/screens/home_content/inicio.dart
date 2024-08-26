// orders_widget.dart
import 'package:flutter/material.dart';
import 'package:frontend/src/widgets/active_orders/active_order_list.dart';
import 'package:frontend/src/models/order.dart';
import 'package:frontend/src/widgets/orders/order_list.dart';

class Inicio extends StatefulWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _InicioState();
  }
}

class _InicioState extends State<Inicio> {
  // Gestion de pedidos activos
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
  final List<Order> _activeOrders = [
    Order(
      nameOrder: 'Chaulafan especial',
      restaurante: 'Misu Misu',
      status: 'Despachando',
      date: DateTime.now(),
      location: 'Juan Jose Pena y Lordes',
      lat: -4.001647732026979, 
      long: -79.19888873091776,
    ),
    Order(
      nameOrder: 'Chizza',
      restaurante: 'KFC',
      status: 'Listo para despacho',
      date: DateTime.now(),
      location: 'Supermaxi',
      lat: -3.987714920670151, 
      long: -79.20248620094415,
    ),
    Order(
      nameOrder: 'Parrillada',
      restaurante: 'Brasa y Leña',
      status: 'En preparacion',
      date: DateTime.now(),
      location: '18 de Noviembre y Lourdes',
      lat: -4.002030210476022, 
      long: -79.20351375037033
    ),
  ];

  final List<Order> _finishOrder = [];

  @override
  Widget build(BuildContext context) {
    // Gestion de la lista de ordenes activas
    Widget mainNewOrder = const Center(
      child: Text('No tienes ordenes activas'),
    );

    if (_activeOrders.isNotEmpty) {
      mainNewOrder = ActiveOrderList(active_orders: _activeOrders);
    }

    // Gestion de la lista de ordenes nuevas
    Widget mainOrder = const Center(
      child: Text('No hay nuevas ordenes'),
    );

    if (_registeredOrders.isNotEmpty) {
      mainOrder = OrderList(orders: _registeredOrders);
    }

    // Gestion del historial de ordenes realizadas
    Widget mainFinishOrder = const Center(
      child: Text('No hay entregas realizadas recientemente'),
    );

    if (_finishOrder.isNotEmpty) {
      mainFinishOrder = OrderList(orders: _finishOrder);
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Entregas activas',
            style: TextStyle(fontSize: 16),
          ),
          mainNewOrder,
          const Text(
            'Ordenes',
            style: TextStyle(fontSize: 16),
          ),
          mainOrder,
          const Text(
            'Entregas realizadas',
            style: TextStyle(fontSize: 16),
          ),
          mainFinishOrder,
        ],
      ),
    );
  }
}
