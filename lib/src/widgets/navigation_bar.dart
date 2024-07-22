import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: const Color.fromRGBO(167, 168, 183, 1),
      unselectedLabelStyle:
          const TextStyle(color: Color.fromRGBO(167, 168, 183, 1)),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.motorcycle),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.view_list),
          label: 'Ordenes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.restaurant_menu),
          label: 'Restaurantes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: const Color.fromRGBO(52, 58, 65, 1),
      onTap: onTap  ,
    );
  }
}
