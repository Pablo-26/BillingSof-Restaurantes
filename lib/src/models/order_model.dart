import 'dart:convert';

List<PedidoModel> pedidosFromJson(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<PedidoModel>((json) => PedidoModel.fromJson(json))
      .toList();
}

class PedidoModel {
  late int? id;
  late String numeroOrden;
  late int restauranteId;
  late String nombreCliente;
  late String idRucCliente;
  late String telefonoCliente;
  late String direccionCliente;
  late String correoCliente;
  late String direccionEntrega;
  late double? latitudEntrega;
  late double? longitudEntrega;
  late String metodoPago;
  late String estado;
  late int? repartidorId;
  late String? observaciones;
  late DateTime fechaCreacion;

  PedidoModel({
    this.id,
    required this.numeroOrden,
    required this.restauranteId,
    required this.nombreCliente,
    required this.idRucCliente,
    required this.telefonoCliente,
    required this.direccionCliente,
    required this.correoCliente,
    required this.direccionEntrega,
    this.latitudEntrega,
    this.longitudEntrega,
    required this.metodoPago,
    required this.estado,
    this.repartidorId,
    this.observaciones,
    required this.fechaCreacion,
  });

  factory PedidoModel.fromJson(Map<String, dynamic> json) {
    return PedidoModel(
      id: json['id'] as int?,
      numeroOrden: json['numero_orden'],
      restauranteId: json['restaurante'],
      nombreCliente: json['nombre_cliente'],
      idRucCliente: json['id_ruc_cliente'],
      telefonoCliente: json['telefono_cliente'],
      direccionCliente: json['direccion_cliente'],
      correoCliente: json['correo_cliente'],
      direccionEntrega: json['direccion_entrega'],
      latitudEntrega: json['latitud_entrega'] != null ? double.parse(json['latitud_entrega']) : null,
      longitudEntrega: json['longitud_entrega'] != null ? double.parse(json['longitud_entrega']) : null,
      metodoPago: json['metodo_pago'],
      estado: json['estado'],
      repartidorId: json['repartidor'],
      observaciones: json['observaciones'],
      fechaCreacion: DateTime.parse(json['fecha_creacion']),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['numero_orden'] = numeroOrden;
    data['restaurante'] = restauranteId;
    data['nombre_cliente'] = nombreCliente;
    data['id_ruc_cliente'] = idRucCliente;
    data['telefono_cliente'] = telefonoCliente;
    data['direccion_cliente'] = direccionCliente;
    data['correo_cliente'] = correoCliente;
    data['direccion_entrega'] = direccionEntrega;
    data['latitud_entrega'] = latitudEntrega;
    data['longitud_entrega'] = longitudEntrega;
    data['metodo_pago'] = metodoPago;
    data['estado'] = estado;
    data['repartidor'] = repartidorId;
    data['observaciones'] = observaciones;
    data['fecha_creacion'] = fechaCreacion.toIso8601String();
    return data;
  }
}