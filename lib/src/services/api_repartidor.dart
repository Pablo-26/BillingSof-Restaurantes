import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:frontend/src/config.dart';
import 'package:http/http.dart' as http;
import '../models/repartidor_model.dart';

class APIRepartidor {
  static var client = http.Client();

  static Future<List<RepartidorModel>?> getRepartidores() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(

      Config.apiURL,
      Config.repartidoresAPI,
    );

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return compute(repartidoresFromJson, response.body);
    } else {
      return null;
    }
  }

  static Future<bool> saveRepartidor(
    RepartidorModel model,
    bool isEditMode,
  ) async {
    var repartidorURL = "${Config.repartidoresAPI}/";

    if (isEditMode) {
      repartidorURL = "$repartidorURL${model.id.toString()}/";
    }

    var url = Uri.http(Config.apiURL, repartidorURL);

    var requestMethod = isEditMode ? "PUT" : "POST";

    var request = http.MultipartRequest(requestMethod, url);
    request.fields["primer_nombre"] = model.primerNombre;
    request.fields["primer_apellido"] = model.primerApellido;
    request.fields["segundo_apellido"] = model.segundoApellido ?? "";
    request.fields["correo_electronico"] = model.correoElectronico;
    request.fields["contrasena"] = model.contrasena;
    request.fields["numero_cedula"] = model.numeroCedula;
    request.fields["numero_telefono"] = model.numeroTelefono;
    request.fields["telefono_verificado"] = model.telefonoVerificado.toString();
    request.fields["estado_repartidor"] = model.estadoRepartidor;
    request.fields["ultima_actualizacion_ubicacion"] = model.ultimaActualizacionUbicacion?.toIso8601String() ?? "";
    request.fields["fecha_registro"] = model.fechaRegistro.toIso8601String();

    var response = await request.send();

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteRepartidor(repartidorId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, "${Config.repartidoresAPI}/$repartidorId/");

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

  static Future<int?> getRepartidorId(RepartidorModel repartidor) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    // Construye la URL para obtener un repartidor específico
    var url = Uri.http(Config.apiURL, "${Config.repartidoresAPI}/${repartidor.id}/");

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['id'] as int;
    } else {
      return null;
    }
  }
}