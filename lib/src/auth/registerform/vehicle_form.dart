import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/src/auth/registerform/schedule_form.dart';
import 'package:frontend/src/models/user.dart';
import 'package:frontend/src/models/vehiculo_repartidor_model.dart';
import 'package:frontend/src/services/api_repartidor.dart';
import 'package:frontend/src/services/api_vehiculo_repartidor.dart';

class VehicleForm extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final int? repartidorId;

  VehicleForm(
      {super.key, required this.navigatorKey, required this.repartidorId});

  @override
  State<StatefulWidget> createState() {
    return _VehicleFormState();
  }
}

class _VehicleFormState extends State<VehicleForm> {
  final _formKey = GlobalKey<FormState>();
  final _placaController = TextEditingController();
  String? _tipoController;
  var _documentoMatriculaController;
  var _documentoIdentificacionController;

  final List<String> _options = ['Carro', 'Moto'];

  Future<void> _pickMatricula() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      setState(() {
        _documentoMatriculaController = result.files.first.name;
      });
    } else {
      // El usuario cancelo la seleccion del archivo
    }
  }

  Future<void> _pickIdentificacion() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      setState(() {
        _documentoMatriculaController = result.files.first.name;
      });
    } else {
      // El usuario cancelo la seleccion del archivo
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                            child: DropdownButton<String>(
                              value: _tipoController,
                              dropdownColor: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              items: _options.map((String option) {
                                return DropdownMenuItem<String>(
                                  value: option,
                                  child: Text(option),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _tipoController = value!;
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
                        controller: _placaController,
                        inputFormatters: const [],
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
                          onPressed: _pickMatricula,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 34, 47, 62),
                            iconColor: Colors.white,
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Adjuntar Matricula',
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
                      if (_documentoMatriculaController != null) ...[
                        const SizedBox(height: 20),
                        Text(
                            'Nombre del archivo: ${_documentoMatriculaController!.name}')
                      ],
                      const SizedBox(
                        height: 12,
                      ),

                      // DOCUMENTO DE IDENTIFICACION
                      const Text(
                        'Documento de identificación',
                        style: TextStyle(fontSize: 16),
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: _pickIdentificacion,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 34, 47, 62),
                            iconColor: Colors.white,
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Adjuntar Identificación',
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
                      if (_documentoIdentificacionController != null) ...[
                        const SizedBox(height: 20),
                        Text(
                            'Nombre del archivo: ${_documentoIdentificacionController!.name}')
                      ],
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
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
                      onPressed: _registerVehicle,
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
      ),
    );
  }

  void _registerVehicle() async {
    final vehiculo = VehiculoRepartidorModel(
      repartidorId: widget.repartidorId,
      placaVehiculo: _placaController.text,
      tipoVehiculo: _tipoController,
      documentoMatricula: _documentoMatriculaController.text.isNotEmpty
          ? _documentoMatriculaController.text
          : null,
      documentoIdentificacion:
          _documentoIdentificacionController.text.isNotEmpty
              ? _documentoIdentificacionController.text
              : null,
    );

    final result =
        await APIVehiculoRepartidor.saveVehiculoRepartidor(vehiculo, false);

    if (result) {// Añade este método en APIRepartidor
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScheduleForm(
            repartidorId: widget.repartidorId,
            navigatorKey: widget.navigatorKey,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error en el registro')));
    }
  }
}
