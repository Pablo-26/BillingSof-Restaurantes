import 'package:flutter/material.dart';
import 'package:frontend/src/models/repartidor_model.dart';
import 'package:frontend/src/services/api_repartidor.dart';

class Mylogin extends StatefulWidget {
  final bool Function(String, String) onLogin;

  const Mylogin({super.key, required this.onLogin});

  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Mylogin> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _attemptLogin() async {
    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text;
    final password = _passwordController.text;

    bool loginSucces = await _validateUser(email, password);

    setState(() {
      _isLoading = false;
    });

    if (loginSucces) {
      // Login exitoso, navegar a la pantalla principal
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      // Mostrar un mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Credenciales inválidas')),
      );
    }
  }

  Future<bool> _validateUser(String email, String password) async {
    List<RepartidorModel>? repartidores = await APIRepartidor.getRepartidores();
    if(repartidores != null) {
      for(var repartidor in repartidores) {
        if(repartidor.correoElectronico == email && repartidor.contrasena == password){
          return true;
        }
      }
    }
    return false;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            color: Colors.white,
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        width: 180,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
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
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(89, 89, 89, 1),
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
                  padding: const EdgeInsets.only(top: 20),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Correo Electrónico:',
                        style: TextStyle(fontSize: 16),
                      ),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Correo',
                          hintStyle: const TextStyle(
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
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Contraseña:',
                        style: TextStyle(fontSize: 16),
                      ),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Contraseña',
                          hintStyle: const TextStyle(
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
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                    ],
                  ),
                ),
                OutlinedButton(
                  onPressed: _attemptLogin,
                  style: OutlinedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(213, 31, 54, 1),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 90, vertical: 17),
                      side: BorderSide.none),
                  child: const Text(
                    'Iniciar Sesión',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
