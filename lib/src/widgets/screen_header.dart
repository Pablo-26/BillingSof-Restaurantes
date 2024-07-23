import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/src/widgets/notifications.dart';

class ScreenHeader extends StatefulWidget {
  final String userName;

  const ScreenHeader({super.key, required this.userName});

  @override
  State<StatefulWidget> createState() {
    return _ScreenHeaderState();
  }
}

class _ScreenHeaderState extends State<ScreenHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            //Color.fromRGBO(217, 217, 217, 1),
            Color.fromRGBO(66, 73, 81, 1),
            Color.fromRGBO(29, 33, 37, 1)
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: Column(
            children: [
              Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.user,
                    color: Colors.white,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    widget.userName,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      margin: const EdgeInsets.only(left: 30),
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Text(
                          'Disponible',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: _openNotifications,
                      icon: const FaIcon(
                        FontAwesomeIcons.bell,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Container(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 10,
                    ),
                    child: const FaIcon(
                      FontAwesomeIcons.magnifyingGlass,
                      color: Colors.white,
                    ),
                  ),
                  label: const Text(
                    'Ingresar Restaurante',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 2),
                  filled: true,
                  fillColor: const Color.fromRGBO(213, 31, 54, 1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openNotifications() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => const Notifications(),
    );
  }
}
