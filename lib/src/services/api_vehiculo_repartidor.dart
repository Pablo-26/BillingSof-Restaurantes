import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/src/config.dart';
import '../models/vehiculo_repartidor_model.dart';

class APIVehiculoRepartidor {
  static var client = http.Client();

  static Future<List<VehiculoRepartidorModel>?> getVehiculosRepartidor() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.vehiculosRepartidorAPI,
    );

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return compute(vehiculosRepartidorFromJson, response.body);
    } else {
      return null;
    }
  }

  static Future<bool> saveVehiculoRepartidor(
    VehiculoRepartidorModel model,
    bool isEditMode,
  ) async {
    var vehiculoURL = "${Config.vehiculosRepartidorAPI}/";

    if (isEditMode) {
      vehiculoURL = "$vehiculoURL${model.id.toString()}/";
    }

    var url = Uri.http(Config.apiURL, vehiculoURL);

    var requestMethod = isEditMode ? "PUT" : "POST";

    var request = http.MultipartRequest(requestMethod, url);
    request.fields["repartidor"] = model.repartidorId.toString();
    request.fields["placa_vehiculo"] = model.placaVehiculo;
    request.fields["tipo_vehiculo"] = model.tipoVehiculo ?? '';
    request.fields["documento_matricula"] = model.documentoMatricula ?? "";
    request.fields["documento_identificacion"] = model.documentoIdentificacion ?? "";

    var response = await request.send();

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteVehiculoRepartidor(vehiculoId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, "${Config.vehiculosRepartidorAPI}/$vehiculoId/");

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