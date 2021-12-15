// To parse this JSON data, do
//
//     final symptonModel = symptonModelFromJson(jsonString);

import 'dart:convert';

List<SymptonModel> symptonModelFromJson(String str) => List<SymptonModel>.from(json.decode(str).map((x) => SymptonModel.fromJson(x)));

String symptonModelToJson(List<SymptonModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SymptonModel {
    SymptonModel({
        this.sinId,
        this.sintomas,
        this.active
    });

    String? sinId;
    String? sintomas;
    bool? active;

    factory SymptonModel.fromJson(Map<String, dynamic> json) => SymptonModel(
        sinId: json["sin_id"],
        sintomas: json["sintomas"],
        active: false
    );

    Map<String, dynamic> toJson() => {
        "sin_id": sinId,
        "sintomas": sintomas,
        "active": false
    };
}
