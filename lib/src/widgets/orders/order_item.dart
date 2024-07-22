import 'package:flutter/material.dart';
import 'package:frontend/src/models/order.dart';

class OrderItem extends StatelessWidget {
  const OrderItem(this.order, {super.key});

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
              width: 165,
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
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(52, 58, 65, 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text(
                'Aceptar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
