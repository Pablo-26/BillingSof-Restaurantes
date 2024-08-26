import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/src/models/order.dart';
import 'package:frontend/src/widgets/map/delivey_order_map.dart';

class ActiveOrderItem extends StatelessWidget {
  const ActiveOrderItem(this.order, {super.key});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Row(
        children: [
          Padding(
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
                  onPressed: () => _openDetails(context),
                  icon: FaIcon(
                    FontAwesomeIcons.circleInfo,
                    color: _getStatusColor(order.status),
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
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

  void _openDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                order.nameOrder,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Restaurante: ${order.restaurante}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Estado: ${order.status}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Ubicación: ${order.location}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Fecha: ${order.formattedDate}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DeliveyOrderMap(order: order),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(213, 31, 54, 1),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                    side: BorderSide.none,
                  ),
                  child: const Text(
                    'Iniciar Ruta',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
