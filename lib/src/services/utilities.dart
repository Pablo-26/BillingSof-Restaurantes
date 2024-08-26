import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Utilities extends StatelessWidget {
  final Function(int) onItemTapped;

  const Utilities({super.key, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OutlinedButton(
            onPressed: () => onItemTapped(0),
            style: OutlinedButton.styleFrom(
                fixedSize: const Size(117, 80),
                side: const BorderSide(
                    color: Color.fromRGBO(224, 224, 224, 1), width: 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.handshake,
                  color: Color.fromRGBO(25, 29, 49, 1),
                  size: 20,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Entregas',
                  style: TextStyle(
                      color: Color.fromRGBO(25, 29, 49, 1),
                      fontSize: 11,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          OutlinedButton(
            onPressed: () => onItemTapped(1),
            style: OutlinedButton.styleFrom(
                fixedSize: const Size(117, 80),
                side: const BorderSide(
                    color: Color.fromRGBO(224, 224, 224, 1), width: 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.map,
                  color: Color.fromRGBO(25, 29, 49, 1),
                  size: 20,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Cerca de ti',
                  style: TextStyle(
                      color: Color.fromRGBO(25, 29, 49, 1),
                      fontSize: 11,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          OutlinedButton(
            onPressed: () => onItemTapped(2),
            style: OutlinedButton.styleFrom(
                fixedSize: const Size(117, 80),
                side: const BorderSide(
                    color: Color.fromRGBO(224, 224, 224, 1), width: 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.rectangleList,
                  color: Color.fromRGBO(25, 29, 49, 1),
                  size: 20,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Rendimiento',
                  style: TextStyle(
                      color: Color.fromRGBO(25, 29, 49, 1),
                      fontSize: 11,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
