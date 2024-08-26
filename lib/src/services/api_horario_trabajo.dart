import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/src/config.dart';
import '../models/horario_trabajo_model.dart';

class APIHorarioTrabajo {
  static var client = http.Client();

  static Future<List<HorarioTrabajoModel>?> getHorariosTrabajo() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.horariosTrabajoAPI,
    );

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return compute(horariosTrabajoFromJson, response.body);
    } else {
      return null;
    }
  }

  static Future<bool> saveHorarioTrabajo(
    HorarioTrabajoModel model,
    bool isEditMode,
  ) async {
    var horarioURL = "${Config.horariosTrabajoAPI}/";

    if (isEditMode) {
      horarioURL = "$horarioURL${model.id.toString()}/";
    }

    var url = Uri.http(Config.apiURL, horarioURL);

    var requestMethod = isEditMode ? "PUT" : "POST";

    var request = http.MultipartRequest(requestMethod, url);
    request.fields["repartidor"] = model.repartidorId.toString();
    request.fields["dia_semana"] = model.diaSemana.toString();
    request.fields["hora_inicio"] = model.horaInicio;
    request.fields["hora_fin"] = model.horaFin;

    var response = await request.send();

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteHorarioTrabajo(horarioId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, "${Config.horariosTrabajoAPI}/$horarioId/");

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