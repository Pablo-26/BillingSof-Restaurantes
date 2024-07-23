import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/src/models/user.dart';

class ScheduleForm extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  ScheduleForm({
    super.key,
    required this.navigatorKey,
    required this.firstName,
    required this.lastName1,
    required this.lastName2,
    required this.email,
    required this.password,
    required this.ci,
    required this.phoneNumber,
    required this.vehicleType,
    required this.placa,
    required this.onAddDelivery,
  });

  final String firstName;
  final String lastName1;
  final String lastName2;
  final String email;
  final String password;
  final String ci;
  final String phoneNumber;
  final String vehicleType;
  final String placa;
  final Function(User) onAddDelivery;

  @override
  State<StatefulWidget> createState() {
    return _ScheduleFormState();
  }
}

class _ScheduleFormState extends State<ScheduleForm> {
  //final _formKey = GlobalKey<FormState>();

  void _finishRegistration() {
    final user = User(
      firstName: widget.firstName,
      lastName1: widget.lastName1,
      lastName2: widget.lastName2,
      email: widget.email,
      password: widget.password,
      dni: widget.ci,
      phone: widget.phoneNumber,
      vehicleType: widget.vehicleType,
      numberPlate: widget.placa,
    );

    widget.onAddDelivery(user);

    // Navegar a la pantalla de inicio
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Éxito'),
          content: const Text('Usuario creado con éxito'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
                widget.navigatorKey.currentState?.pushNamedAndRemoveUntil(
                  '/home',
                  (route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                //height: MediaQuery.of(context).size.height / 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 70,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(89, 89, 89, 1),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                                topRight: Radius.circular(0),
                                topLeft: Radius.circular(20))),
                        side: BorderSide.none,
                      ),
                      child: const Text(
                        'Iniciar Sesión',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(40, 45, 51, 1),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(0))),
                        side: BorderSide.none,
                      ),
                      child: const Text(
                        'Registrarse',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: const Column(
                  children: [
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.clock,
                          color: Color.fromRGBO(40, 45, 51, 1),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Horario Laboral',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(40, 45, 51, 1),
                          ),
                        )
                      ],
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // LUNES
                        Text(
                          'Lunes',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        // MARTES
                        Text(
                          'Martes',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        // MIERCOLES
                        Text(
                          'Miercoles',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        // JUEVES
                        Text(
                          'Jueves',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        // VIERNES
                        Text(
                          'Viernes',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                          iconColor: const Color.fromRGBO(89, 89, 89, 1)),
                      child: const Row(
                        children: [
                          Icon(Icons.keyboard_arrow_left),
                          Text(
                            'Anterior',
                            style: TextStyle(
                              color: Color.fromRGBO(89, 89, 89, 1),
                            ),
                          )
                        ],
                      ),
                    ),
                    OutlinedButton(
                      onPressed: _finishRegistration,
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(213, 31, 54, 1),
                        iconColor: Colors.white,
                        side: BorderSide.none,
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Finalizar',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
