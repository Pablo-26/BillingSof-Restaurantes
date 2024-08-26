import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/src/config.dart';
import '../models/historial_ubicacion_repartidor_model.dart';

List<HistorialUbicacionRepartidorModel> historialUbicacionRepartidorFromJson(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<HistorialUbicacionRepartidorModel>((json) => HistorialUbicacionRepartidorModel.fromJson(json))
      .toList();
}

class APIHistorialUbicacionRepartidor {
  static var client = http.Client();

  static Future<List<HistorialUbicacionRepartidorModel>?> getHistorialUbicacionRepartidor() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.historialUbicacionRepartidorAPI,
    );

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return compute(historialUbicacionRepartidorFromJson, response.body);
    } else {
      return null;
    }
  }

  static Future<bool> saveHistorialUbicacionRepartidor(
    HistorialUbicacionRepartidorModel model,
    bool isEditMode,
  ) async {
    var historialURL = "${Config.historialUbicacionRepartidorAPI}/";

    if (isEditMode) {
      historialURL = "$historialURL${model.id.toString()}/";
    }

    var url = Uri.http(Config.apiURL, historialURL);

    var requestMethod = isEditMode ? "PUT" : "POST";

    var request = http.MultipartRequest(requestMethod, url);
    request.fields["repartidor"] = model.repartidorId.toString();
    request.fields["latitud"] = model.latitud.toString();
    request.fields["longitud"] = model.longitud.toString();
    request.fields["timestamp"] = model.timestamp.toIso8601String();

    var response = await request.send();

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteHistorialUbicacionRepartidor(historialId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, "${Config.historialUbicacionRepartidorAPI}/$historialId/");

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