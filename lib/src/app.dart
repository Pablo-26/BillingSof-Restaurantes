import 'package:flutter/material.dart';
import 'package:frontend/src/auth/mylogin.dart';
import 'package:frontend/src/auth/register.dart';
import 'package:frontend/src/models/order.dart';
import 'package:frontend/src/models/user.dart';
import 'package:frontend/src/screens/home_screen.dart';
import 'package:frontend/src/screens/splash_screen.dart';
import 'package:frontend/src/screens/start_screen.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  final List<User> _registeredUsers = [
    User(
      firstName: 'Pablo',
      lastName1: 'Ramon',
      lastName2: 'Vasquez',
      email: 'pablo@gmail.com',
      password: 'asdf',
      dni: '1100123456',
      phone: '0999128475',
      vehicleType: 'carro',
      numberPlate: 'LCL0123',
    )
  ];
  User? _currentUser;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  void _addDelivery(User user) {
    setState(() {
      _registeredUsers.add(user);
      _currentUser = user;
    });
    print('Usuario agregado: ${user.firstName} ${user.lastName1}');
    _printRegisteredUsers();
    if (_currentUser != null) {
      _navigatorKey.currentState?.pushReplacementNamed('/home');
    }
  }

  void _printRegisteredUsers() {
    print('Lista de usuarios registrados:');
    for (var user in _registeredUsers) {
      print(
          'Nombre: ${user.firstName}, Apellido1: ${user.lastName1}, Apellido2: ${user.lastName2}, Email: ${user.email}');
    }
  }

  bool _login(String email, String password) {
    for (var user in _registeredUsers) {
      if (user.email == email && user.password == password) {
        setState(() {
          _currentUser = user;
        });
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final List<Order> _registeredOrders = [
      Order(
        nameOrder: 'Big Box',
        restaurante: 'KFC',
        status: 'Listo para despacho',
        date: DateTime.now(),
        location: 'Gran AKI',
      ),
      Order(
        nameOrder: 'Pizza familiar',
        restaurante: 'Giro Pizza',
        status: 'En preparacion',
        date: DateTime.now(),
        location: 'Lourdes y Bernardo Valdivieso',
      ),
    ];


    return MaterialApp(
      navigatorKey: _navigatorKey,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/start': (context) => StartScreen(),
        '/login': (context) => Mylogin(onLogin: _login),
        '/register': (context) =>
            Register(onAddDelivery: _addDelivery, navigatorKey: _navigatorKey),
        '/home': (context) => HomeScreen(currentUser: _currentUser!),
      },
    );
  }
}
