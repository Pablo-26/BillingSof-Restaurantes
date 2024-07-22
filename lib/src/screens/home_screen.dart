import 'package:flutter/material.dart';
import 'package:frontend/src/models/user.dart';
import 'package:frontend/src/screens/home_content.dart';
import 'package:frontend/src/screens/orders_screen.dart';
import 'package:frontend/src/screens/profile_screen.dart';
import 'package:frontend/src/screens/restaurant_screen.dart';
import 'package:frontend/src/widgets/navigation_bar.dart';
import 'package:frontend/src/widgets/screen_header.dart';

class HomeScreen extends StatefulWidget {
  final User? currentUser;

  HomeScreen({super.key, required this.currentUser});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const HomeContent(),
      const OrdersScreen(),
      const RestaurantScreen(),
      ProfileScreen(user: widget.currentUser!),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          ScreenHeader(userName: widget.currentUser?.firstName ?? 'Usuario'),
          Expanded(
            child: _screens[_currentIndex],
          ),
        ],
      ),
      bottomNavigationBar: NavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
