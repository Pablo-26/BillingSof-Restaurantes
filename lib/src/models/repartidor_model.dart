import 'dart:convert';

List<RepartidorModel> repartidoresFromJson(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<RepartidorModel>((json) => RepartidorModel.fromJson(json))
      .toList();
}

class RepartidorModel {
  late int? id;
  late String primerNombre;
  late String primerApellido;
  late String? segundoApellido;
  late String correoElectronico;
  late String contrasena;
  late String numeroCedula;
  late String numeroTelefono;
  late bool telefonoVerificado;
  late String estadoRepartidor;
  late DateTime? ultimaActualizacionUbicacion;
  late DateTime fechaRegistro;

  RepartidorModel({
    this.id,
    required this.primerNombre,
    required this.primerApellido,
    this.segundoApellido,
    required this.correoElectronico,
    required this.contrasena,
    required this.numeroCedula,
    required this.numeroTelefono,
    required this.telefonoVerificado,
    required this.estadoRepartidor,
    this.ultimaActualizacionUbicacion,
    required this.fechaRegistro,
  });

  factory RepartidorModel.fromJson(Map<String, dynamic> json) {
    return RepartidorModel(
      id: json['id'] as int?,
      primerNombre: json['primer_nombre'],
      primerApellido: json['primer_apellido'],
      segundoApellido: json['segundo_apellido'],
      correoElectronico: json['correo_electronico'],
      contrasena: json['contrasena'],
      numeroCedula: json['numero_cedula'],
      numeroTelefono: json['numero_telefono'],
      telefonoVerificado: json['telefono_verificado'],
      estadoRepartidor: json['estado_repartidor'],
      ultimaActualizacionUbicacion: json['ultima_actualizacion_ubicacion'] != null
          ? DateTime.parse(json['ultima_actualizacion_ubicacion'])
          : null,
      fechaRegistro: DateTime.parse(json['fecha_registro']),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['primer_nombre'] = primerNombre;
    data['primer_apellido'] = primerApellido;
    data['segundo_apellido'] = segundoApellido;
    data['correo_electronico'] = correoElectronico;
    data['contrasena'] = contrasena;
    data['numero_cedula'] = numeroCedula;
    data['numero_telefono'] = numeroTelefono;
    data['telefono_verificado'] = telefonoVerificado;
    data['estado_repartidor'] = estadoRepartidor;
    data['ultima_actualizacion_ubicacion'] = ultimaActualizacionUbicacion?.toIso8601String();
    data['fecha_registro'] = fechaRegistro.toIso8601String();
    return data;
  }
}