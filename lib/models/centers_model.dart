// To parse this JSON data, do
//
//     final centersModel = centersModelFromJson(jsonString);

import 'dart:convert';

List<CentersModel> centersModelFromJson(String str) => List<CentersModel>.from(json.decode(str).map((x) => CentersModel.fromJson(x)));

String centersModelToJson(List<CentersModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CentersModel {
    CentersModel({
        this.id,
        this.provi,
        this.dist,
        this.nomEst,
        this.direc,
        this.phone,
    });

    String? id;
    String? provi;
    String? dist;
    String? nomEst;
    String? direc;
    String? phone;

    factory CentersModel.fromJson(Map<String, dynamic> json) => CentersModel(
        id: json["id"],
        provi: json["provi"],
        dist: json["dist"],
        nomEst: json["nom_est"],
        direc: json["direc"],
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "provi": provi,
        "dist": dist,
        "nom_est": nomEst,
        "direc": direc,
        "phone": phone,
    };
}

