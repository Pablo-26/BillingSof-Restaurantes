import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/auth/registerform/vehicle_form.dart';
import 'package:frontend/src/models/repartidor_model.dart';
import 'package:frontend/src/models/user.dart';
import 'package:frontend/src/services/api_repartidor.dart';

class Register extends StatelessWidget {
  final void Function(User) onAddDelivery;
  final GlobalKey<NavigatorState> navigatorKey;

  const Register(
      {Key? key, required this.onAddDelivery, required this.navigatorKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PersonalInfoForm(
        onAddDelivery: onAddDelivery, navigatorKey: navigatorKey);
  }
}

class PersonalInfoForm extends StatefulWidget {
  final void Function(User) onAddDelivery;
  final GlobalKey<NavigatorState> navigatorKey;

  const PersonalInfoForm(
      {Key? key, required this.onAddDelivery, required this.navigatorKey})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PersonalInfoFormState();
}

class _PersonalInfoFormState extends State<PersonalInfoForm> {
  final _formKey = GlobalKey<FormState>();

  final _primerNombreController = TextEditingController();
  final _primerApellidoController = TextEditingController();
  final _segundoApellidoController = TextEditingController();
  final _correoElectronicoController = TextEditingController();
  final _contrasenaController = TextEditingController();
  final _numeroCedulaController = TextEditingController();
  final _numeroTelefonoController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10),
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
                          controller: _primerNombreController,
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
                          controller: _primerApellidoController,
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
                          controller: _segundoApellidoController,
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
                          controller: _correoElectronicoController,
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
                          controller: _contrasenaController,
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
                        // Numero de Identificacion
                        const Text(
                          'Numero de Cédula:',
                          style: TextStyle(fontSize: 16),
                        ),
                        TextFormField(
                          controller: _numeroCedulaController,
                          keyboardType: TextInputType.number,
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
                              return 'Por favor ingrese el numero de cedula';
                            } else if (value.length < 10) {
                              return 'Ingrese un numero de cedula válido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),

                        // NUMERO DE TELEFONO
                        const Text(
                          'Número de Teléfono:',
                          style: TextStyle(fontSize: 16),
                        ),
                        TextFormField(
                          controller: _numeroTelefonoController,
                          keyboardType: TextInputType.number,
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
                              return 'Por favor ingrese su número de teléfono:';
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
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : OutlinedButton(
                          onPressed: _registerRepartidor,
                          style: OutlinedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(213, 31, 54, 1),
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
        ),
      ),
    );
  }

  void _registerRepartidor() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);

    final repartidor = RepartidorModel(
      primerNombre: _primerNombreController.text,
      primerApellido: _primerApellidoController.text,
      segundoApellido: _segundoApellidoController.text,
      correoElectronico: _correoElectronicoController.text,
      contrasena: _contrasenaController.text,
      numeroCedula: _numeroCedulaController.text,
      numeroTelefono: _numeroTelefonoController.text,
      telefonoVerificado: false,  // Valor por defecto
      estadoRepartidor: 'Activo',  // Valor por defecto
      ultimaActualizacionUbicacion: DateTime.now(),
      fechaRegistro: DateTime.now(),
    );

    try {
      final result = await APIRepartidor.saveRepartidor(repartidor, false);

      if (result) {
        final repartidorId = await APIRepartidor.getRepartidorId(repartidor);
        if (repartidorId != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VehicleForm(
                repartidorId: repartidorId,
                navigatorKey: widget.navigatorKey,
              ),
            ),
          );
        } else {
          throw Exception('Error al obtener el ID del repartidor');
        }
      } else {
        throw Exception('Error en el registro');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
}