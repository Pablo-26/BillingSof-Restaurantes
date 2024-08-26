import 'dart:convert';

List<VehiculoRepartidorModel> vehiculosRepartidorFromJson(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<VehiculoRepartidorModel>((json) => VehiculoRepartidorModel.fromJson(json))
      .toList();
}

class VehiculoRepartidorModel {
  late int? id;
  late int? repartidorId;
  late String placaVehiculo;
  late String? tipoVehiculo;
  late String? documentoMatricula;
  late String? documentoIdentificacion;

  VehiculoRepartidorModel({
    this.id,
    required this.repartidorId,
    required this.placaVehiculo,
    required this.tipoVehiculo,
    this.documentoMatricula,
    this.documentoIdentificacion,
  });

  factory VehiculoRepartidorModel.fromJson(Map<String, dynamic> json) {
    return VehiculoRepartidorModel(
      id: json['id'] as int?,
      repartidorId: json['repartidor'],
      placaVehiculo: json['placa_vehiculo'],
      tipoVehiculo: json['tipo_vehiculo'],
      documentoMatricula: json['documento_matricula'],
      documentoIdentificacion: json['documento_identificacion'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['repartidor'] = repartidorId;
    data['placa_vehiculo'] = placaVehiculo;
    data['tipo_vehiculo'] = tipoVehiculo;
    data['documento_matricula'] = documentoMatricula;
    data['documento_identificacion'] = documentoIdentificacion;
    return data;
  }
}