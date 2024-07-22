import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/src/auth/registerform/schedule_form.dart';
import 'package:frontend/src/models/user.dart';

class VehicleForm extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  VehicleForm({
    super.key,
    required this.navigatorKey,
    required this.firstName,
    required this.lastName1,
    required this.lastName2,
    required this.email,
    required this.password,
    required this.onAddDelivery,
  });

  final String firstName;
  final String lastName1;
  final String lastName2;
  final String email;
  final String password;
  final void Function(User) onAddDelivery;

  @override
  State<StatefulWidget> createState() {
    return _VehicleFormState();
  }
}

class _VehicleFormState extends State<VehicleForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _ci = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _placa = TextEditingController();
  VehicleType _selectedVehicle = VehicleType.moto;

  PlatformFile? _selectedFile;

  @override
  void dispose() {
    _ci.dispose();
    _phoneNumber.dispose();
    _placa.dispose();
    super.dispose();
  }

  void _goToNextScreen() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScheduleForm(
            navigatorKey: widget.navigatorKey,
            firstName: widget.firstName,
            lastName1: widget.lastName1,
            lastName2: widget.lastName2,
            email: widget.email,
            password: widget.password,
            ci: _ci.text,
            phoneNumber: _phoneNumber.text,
            vehicleType: _selectedVehicle.name,
            placa: _placa.text,
            onAddDelivery: widget.onAddDelivery,
          ),
        ),
      );
    }
  }

  Future<void> _pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedFile = result.files.first;
      });
    } else {
      // El usuario cancelo la seleccion del archivo
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
            // Segunda parte del formulario de registro de repartidores
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
                    // Numero de Identificacion
                    const Text(
                      'Numero de Cédula:',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextFormField(
                      controller: _ci,
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
                      controller: _phoneNumber,
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

                    // TIPO DE VEHICULO
                    Row(
                      children: [
                        const Text(
                          'Placa del Vehiculo:',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<VehicleType>(
                            value: _selectedVehicle,
                            dropdownColor: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            items:
                                VehicleType.values.map((VehicleType category) {
                              return DropdownMenuItem<VehicleType>(
                                value: category,
                                child: Text(category.name),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedVehicle = value!;
                              });
                            },
                            style: const TextStyle(
                              color: Color.fromRGBO(89, 89, 89, 1),
                              fontSize: 16,
                            ),
                            icon: const Icon(Icons.keyboard_arrow_down),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),

                    // PLACA DEL VEHICULO
                    const Text(
                      'Placa del Vehiculo:',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextFormField(
                      controller: _placa,
                      inputFormatters: [],
                      decoration: InputDecoration(
                        labelText: 'Ej. LCL0213',
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
                          return 'Por favor ingrese el numero de placa de su vehiculo:';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),

                    // DOCUMENTO DE MATRICULA DE SU VEHICULO
                    const Text(
                      'Documento de matricula del vehículo',
                      style: TextStyle(fontSize: 16),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: _pickDocument,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 34, 47, 62),
                          iconColor: Colors.white,
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Aduntar Matricula',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            FaIcon(
                              FontAwesomeIcons.file,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (_selectedFile != null) ...[
                      SizedBox(height: 20),
                      Text('Nombre del archivo: ${_selectedFile!.name}'),
                      Text('Ruta del archivo: ${_selectedFile!.path}'),
                    ],
                    const SizedBox(
                      height: 12,
                    ),

                    // DOCUMENTO DE IDENTIFICACION
                    const Text(
                      'Documento de identificación',
                      style: TextStyle(fontSize: 16),
                    ),
                    //----
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                        iconColor: Color.fromRGBO(89, 89, 89, 1)),
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
