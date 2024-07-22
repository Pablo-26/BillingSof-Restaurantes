import 'package:uuid/uuid.dart';

final uuid = Uuid();

enum VehicleType {moto, carro}

class User {
  User({
    required this.firstName,
    required this.lastName1,
    required this.lastName2,
    required this.email,
    required this.password,
    required this.dni,
    required this.phone,
    required this.vehicleType,
    required this.numberPlate,
    //required this.matricula,
    //required this.identificacion,
  }): id = uuid.v4();

  // Datos de registro del repartidor
  final String id;
  final String firstName;
  final String lastName1;
  final String lastName2;
  final String email;
  final String password;
  final String dni;
  final String phone;
  final String vehicleType;
  final String numberPlate;
  // Documentos de validacion del rapartidor
  //final File matricula;
  //final File identificacion;
}
