import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/src/config.dart';
import '../models/order_model.dart';

class APIPedido {
  static var client = http.Client();

  static Future<List<PedidoModel>?> getPedidos() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.pedidosAPI,
    );

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return compute(pedidosFromJson, response.body);
    } else {
      return null;
    }
  }

  static Future<bool> savePedido(
    PedidoModel model,
    bool isEditMode,
  ) async {
    var pedidoURL = "${Config.pedidosAPI}/";

    if (isEditMode) {
      pedidoURL = "$pedidoURL${model.id.toString()}/";
    }

    var url = Uri.http(Config.apiURL, pedidoURL);

    var requestMethod = isEditMode ? "PUT" : "POST";

    var request = http.MultipartRequest(requestMethod, url);
    request.fields["numero_orden"] = model.numeroOrden;
    request.fields["restaurante"] = model.restauranteId.toString();
    request.fields["nombre_cliente"] = model.nombreCliente;
    request.fields["id_ruc_cliente"] = model.idRucCliente;
    request.fields["telefono_cliente"] = model.telefonoCliente;
    request.fields["direccion_cliente"] = model.direccionCliente;
    request.fields["correo_cliente"] = model.correoCliente;
    request.fields["direccion_entrega"] = model.direccionEntrega;
    request.fields["latitud_entrega"] = model.latitudEntrega?.toString() ?? "";
    request.fields["longitud_entrega"] = model.longitudEntrega?.toString() ?? "";
    request.fields["metodo_pago"] = model.metodoPago;
    request.fields["estado"] = model.estado;
    request.fields["repartidor"] = model.repartidorId?.toString() ?? "";
    request.fields["observaciones"] = model.observaciones ?? "";
    request.fields["fecha_creacion"] = model.fechaCreacion.toIso8601String();

    var response = await request.send();

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deletePedido(pedidoId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, "${Config.pedidosAPI}/$pedidoId/");

    var response = await client.delete(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}