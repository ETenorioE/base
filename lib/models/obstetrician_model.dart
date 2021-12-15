// To parse this JSON data, do
//
//     final obstetricianModel = obstetricianModelFromJson(jsonString);

import 'dart:convert';

List<ObstetricianModel> obstetricianModelFromJson(String str) => List<ObstetricianModel>.from(json.decode(str).map((x) => ObstetricianModel.fromJson(x)));

String obstetricianModelToJson(List<ObstetricianModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ObstetricianModel {
    ObstetricianModel({
        this.id,
        this.red,
        this.nomEst,
        this.nom,
        this.phone,
    });

    String? id;
    String? red;
    String? nomEst;
    String? nom;
    String? phone;

    factory ObstetricianModel.fromJson(Map<String, dynamic> json) => ObstetricianModel(
        id: json["id"],
        red: json["red"],
        nomEst: json["nom_est"],
        nom: json["nom"],
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "red": red,
        "nom_est": nomEst,
        "nom": nom,
        "phone": phone,
    };
}

