import 'package:flutter/material.dart';
import 'package:frontend/src/models/order.dart';

class ActiveOrderItem extends StatelessWidget {
  const ActiveOrderItem(this.order, {super.key});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Image.asset(
                'assets/images/orderImage.png',
                width: 65,
              ),
            ),
            Container(
              width: 200,
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.only(right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.nameOrder,
                    style: const TextStyle(
                      color: Color.fromRGBO(25, 29, 49, 1),
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    order.status,
                    style: const TextStyle(
                      color: Color.fromRGBO(167, 169, 183, 1),
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    order.location,
                    style: const TextStyle(
                      color: Color.fromRGBO(167, 169, 183, 1),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.circle,
                color: _getStatusColor(order.status),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch(status){
      case 'En preparacion':
        return const Color.fromRGBO(213, 31, 54, 1);
      case 'Listo para despacho':
        return const Color.fromARGB(255, 208, 189, 23);
      case 'Despachando':
        return Colors.green;
      default:
        return const Color.fromARGB(255, 118, 118, 118);
    }
  }
}
