import 'dart:convert';

class HistorialUbicacionRepartidorModel {
  late int? id;
  late int repartidorId;
  late double latitud;
  late double longitud;
  late DateTime timestamp;

  HistorialUbicacionRepartidorModel({
    this.id,
    required this.repartidorId,
    required this.latitud,
    required this.longitud,
    required this.timestamp,
  });

  factory HistorialUbicacionRepartidorModel.fromJson(Map<String, dynamic> json) {
    return HistorialUbicacionRepartidorModel(
      id: json['id'] as int?,
      repartidorId: json['repartidor'],
      latitud: double.parse(json['latitud']),
      longitud: double.parse(json['longitud']),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['repartidor'] = repartidorId;
    data['latitud'] = latitud;
    data['longitud'] = longitud;
    data['timestamp'] = timestamp.toIso8601String();
    return data;
  }
}