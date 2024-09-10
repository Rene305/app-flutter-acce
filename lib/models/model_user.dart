// To parse this JSON data, do
//
//     final userApp = userAppFromJson(jsonString);

import 'dart:convert';

UserApp userAppFromJson(String str) => UserApp.fromJson(json.decode(str));

String userAppToJson(UserApp data) => json.encode(data.toJson());

class UserApp {
  String nombre;
  String cedula;
  String celular;
  String ciudad;
  String provincia;
  int edad;
  String correo;
  String sexo;
  String tipoPaciente;

  UserApp({
    required this.nombre,
    required this.cedula,
    required this.celular,
    required this.ciudad,
    required this.provincia,
    required this.edad,
    required this.correo,
    required this.sexo,
    required this.tipoPaciente,
  });

  factory UserApp.fromJson(Map<String, dynamic> json) => UserApp(
        nombre: json["nombre"],
        cedula: json["cedula"],
        celular: json["celular"],
        ciudad: json["ciudad"],
        provincia: json["provincia"],
        edad: json["edad"],
        correo: json["correo"],
        sexo: json["sexo"],
        tipoPaciente: json["tipoPaciente"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "cedula": cedula,
        "celular": celular,
        "ciudad": ciudad,
        "provincia": provincia,
        "edad": edad,
        "correo": correo,
        "sexo": sexo,
        "tipoPaciente": tipoPaciente,
      };
}
