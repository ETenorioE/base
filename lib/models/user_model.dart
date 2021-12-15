// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

List<UserModel> userModelFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
    UserModel({
        this.usuId,
        this.usuDni,
        this.usuNom,
        this.usuApe,
        this.usuCelular,
        this.idEstablecimiento,
        this.nombreEstablecimiento,
        this.central,
        this.red,
        this.microred,
    });

    String? usuId;
    String? usuDni;
    String? usuNom;
    String? usuApe;
    String? usuCelular;
    String? idEstablecimiento;
    String? nombreEstablecimiento;
    String? central;
    String? red;
    String? microred;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        usuId: json["usu_id"],
        usuDni: json["usu_dni"],
        usuNom: json["usu_nom"],
        usuApe: json["usu_ape"],
        usuCelular: json["usu_celular"],
        idEstablecimiento: json["Id_Establecimiento"],
        nombreEstablecimiento: json["Nombre_Establecimiento"],
        central: json["central"],
        red: json["red"],
        microred: json["microred"],
    );

    Map<String, dynamic> toJson() => {
        "usu_id": usuId,
        "usu_dni": usuDni,
        "usu_nom": usuNom,
        "usu_ape": usuApe,
        "usu_celular": usuCelular,
        "Id_Establecimiento": idEstablecimiento,
        "Nombre_Establecimiento": nombreEstablecimiento,
        "central": central,
        "red": red,
        "microred": microred,
    };
}
