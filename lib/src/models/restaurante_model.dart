import 'dart:convert';

List<RestauranteModel> restaurantesFromJson(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<RestauranteModel>((json) => RestauranteModel.fromJson(json))
      .toList();
}

class RestauranteModel {
  late int? id;
  late String nombre;
  late String direccion;
  late double? latitud;
  late double? longitud;

  RestauranteModel({
    this.id,
    required this.nombre,
    required this.direccion,
    this.latitud,
    this.longitud,
  });

  factory RestauranteModel.fromJson(Map<String, dynamic> json) {
    return RestauranteModel(
      id: json['id'] as int?,
      nombre: json['nombre'],
      direccion: json['direccion'],
      latitud: json['latitud'] != null ? double.parse(json['latitud']) : null,
      longitud: json['longitud'] != null ? double.parse(json['longitud']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['nombre'] = nombre;
    data['direccion'] = direccion;
    data['latitud'] = latitud;
    data['longitud'] = longitud;
    return data;
  }
}