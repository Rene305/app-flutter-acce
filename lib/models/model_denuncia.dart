// To parse this JSON data, do
//
//     final denuncia = denunciaFromJson(jsonString);

import 'dart:convert';

Denuncia denunciaFromJson(String str) => Denuncia.fromJson(json.decode(str));

String denunciaToJson(Denuncia data) => json.encode(data.toJson());

class Denuncia {
  String denunciante;
  String denuncia;
  String fecha;
  String estado;
  String userID;

  Denuncia({
    required this.denunciante,
    required this.denuncia,
    required this.fecha,
    required this.estado,
    required this.userID,
  });

  factory Denuncia.fromJson(Map<String, dynamic> json) => Denuncia(
        denunciante: json["denunciante"],
        denuncia: json["denuncia"],
        fecha: json["fecha"],
        estado: json["estado"],
        userID: json["userID"],
      );

  Map<String, dynamic> toJson() => {
        "denunciante": denunciante,
        "denuncia": denuncia,
        "fecha": fecha,
        "estado": estado,
        "userID": userID
      };
}
