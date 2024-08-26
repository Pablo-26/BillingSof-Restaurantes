import 'package:flutter/material.dart';
import 'package:frontend/src/models/horario_trabajo_model.dart';
import 'package:frontend/src/services/api_horario_trabajo.dart';

class ScheduleForm extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final int? repartidorId;

  ScheduleForm(
      {super.key, required this.navigatorKey, required this.repartidorId});

  @override
  State<StatefulWidget> createState() {
    return _ScheduleFormState();
  }
}

class _ScheduleFormState extends State<ScheduleForm> {
  final _formKey = GlobalKey<FormState>();
  int? _diaSemanaController;
  final _horaInicioController = TextEditingController();
  final _horaFinController = TextEditingController();

  final List<String> _diasSemana = [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo'
  ];

  @override
  void dispose() {
    _horaInicioController.dispose();
    _horaFinController.dispose();
    super.dispose();
  }

  void _goToNextScreen() {
    if (_formKey.currentState!.validate()) {
      _registerWorkSchedule();
    }
  }

  Future<void> _registerWorkSchedule() async {
    final diaSemana = _diaSemanaController;
    final horaInicio = _horaInicioController.text;
    final horaFin = _horaFinController.text;

    if (diaSemana == null || horaInicio.isEmpty || horaFin.isEmpty) {
      // Puedes mostrar un mensaje de error si algún campo está vacío
      return;
    }

    final workSchedule = HorarioTrabajoModel(
      repartidorId: widget.repartidorId!,
      diaSemana: diaSemana,
      horaInicio: horaInicio,
      horaFin: horaFin,
    );

    await APIHorarioTrabajo.saveHorarioTrabajo(workSchedule, false);

    // Navegar a la siguiente pantalla o mostrar un mensaje de éxito
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

  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        controller.text = time.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Horario de Trabajo'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Día de la Semana:', style: TextStyle(fontSize: 16)),
                DropdownButtonFormField<int>(
                  value: _diaSemanaController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(189, 189, 189, 1),
                      ),
                    ),
                  ),
                  items: List.generate(
                    _diasSemana.length,
                    (index) => DropdownMenuItem(
                      value: index,
                      child: Text(_diasSemana[index]),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _diaSemanaController = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor seleccione un día de la semana.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Text('Hora de Inicio:', style: TextStyle(fontSize: 16)),
                TextFormField(
                  controller: _horaInicioController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Seleccione la hora de inicio',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(189, 189, 189, 1),
                      ),
                    ),
                  ),
                  onTap: () => _selectTime(context, _horaInicioController),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor seleccione la hora de inicio.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Text('Hora de Fin:', style: TextStyle(fontSize: 16)),
                TextFormField(
                  controller: _horaFinController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Seleccione la hora de fin',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(189, 189, 189, 1),
                      ),
                    ),
                  ),
                  onTap: () => _selectTime(context, _horaFinController),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor seleccione la hora de fin.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: _goToNextScreen,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 34, 47, 62),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      'Registrar',
                      style: TextStyle(color: Colors.white),
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
}
