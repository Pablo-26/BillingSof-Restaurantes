import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/auth/registerform/vehicle_form.dart';
import 'package:frontend/src/models/user.dart';

class Register extends StatelessWidget{
  final void Function(User) onAddDelivery;
  final GlobalKey<NavigatorState> navigatorKey;

  const Register({Key? key, required this.onAddDelivery, required this.navigatorKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PersonalInfoForm(onAddDelivery: onAddDelivery, navigatorKey: navigatorKey);
  }
}

class PersonalInfoForm  extends StatefulWidget {
  final void Function(User) onAddDelivery;
  final GlobalKey<NavigatorState> navigatorKey;

  const PersonalInfoForm({Key? key, required this.onAddDelivery, required this.navigatorKey}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PersonalInfoFormState();
  }
}

class _PersonalInfoFormState extends State<PersonalInfoForm> {
  // Llave global
  final _formKey = GlobalKey<FormState>();

  // Datos de los repartidores
  final _firstName = TextEditingController();
  final _lastName1 = TextEditingController();
  final _lastName2 = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _firstName.dispose();
    _lastName1.dispose();
    _lastName2.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _goToNextScreen() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VehicleForm(
            navigatorKey: widget.navigatorKey,
            firstName: _firstName.text,
            lastName1: _lastName1.text,
            lastName2: _lastName2.text,
            email: _email.text,
            password: _password.text,
            onAddDelivery: widget.onAddDelivery,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        alignment: Alignment.bottomCenter,
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
            // Formulario de registro de repartidores
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // NOMBRE
                    const Text(
                      'Nombre:',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextFormField(
                      controller: _firstName,
                      decoration: InputDecoration(
                        labelText: 'Ej. Juan',
                        labelStyle: const TextStyle(
                          color: Color.fromRGBO(189, 189, 189, 1),
                          fontWeight: FontWeight.normal,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(189, 189, 189, 1),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese su nombre';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),

                    // PRIMER APELLIDO
                    const Text(
                      'Primer Apellido:',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextFormField(
                      controller: _lastName1,
                      decoration: InputDecoration(
                        labelText: 'Ej. Perez',
                        labelStyle: const TextStyle(
                          color: Color.fromRGBO(189, 189, 189, 1),
                          fontWeight: FontWeight.normal,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(189, 189, 189, 1),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese su primer apellido:';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),

                    //SEGUNDO APELLIDO
                    const Text(
                      'Segundo Apellido:',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextFormField(
                      controller: _lastName2,
                      decoration: InputDecoration(
                        labelText: 'Ej. Romero',
                        labelStyle: const TextStyle(
                          color: Color.fromRGBO(189, 189, 189, 1),
                          fontWeight: FontWeight.normal,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(189, 189, 189, 1),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese su segundo apellido:';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),

                    // CORREO ELECTRONICO
                    const Text(
                      'Correo Electrónico:',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextFormField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Ej. usuario@example.com',
                        labelStyle: const TextStyle(
                          color: Color.fromRGBO(189, 189, 189, 1),
                          fontWeight: FontWeight.normal,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(189, 189, 189, 1),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese su correo electronico:';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),

                    // CONTRASENA
                    const Text(
                      'Contraseña:',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextFormField(
                      controller: _password,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(189, 189, 189, 1),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese una contraseña:';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: OutlinedButton(
                onPressed: _goToNextScreen,
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
                      'Siguiente',
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
            ),
          ],
        ),
      ),
    );
  }
}
