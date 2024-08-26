import 'dart:convert';

List<HorarioTrabajoModel> horariosTrabajoFromJson(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<HorarioTrabajoModel>((json) => HorarioTrabajoModel.fromJson(json))
      .toList();
}

class HorarioTrabajoModel {
  late int? id;
  late int? repartidorId;
  late int diaSemana;
  late String horaInicio;
  late String horaFin;

  HorarioTrabajoModel({
    this.id,
    required this.repartidorId,
    required this.diaSemana,
    required this.horaInicio,
    required this.horaFin,
  });

  factory HorarioTrabajoModel.fromJson(Map<String, dynamic> json) {
    return HorarioTrabajoModel(
      id: json['id'] as int?,
      repartidorId: json['repartidor'],
      diaSemana: json['dia_semana'],
      horaInicio: json['hora_inicio'],
      horaFin: json['hora_fin'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['repartidor'] = repartidorId;
    data['dia_semana'] = diaSemana;
    data['hora_inicio'] = horaInicio;
    data['hora_fin'] = horaFin;
    return data;
  }
}