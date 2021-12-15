// To parse this JSON data, do
//
//     final numberModel = numberModelFromJson(jsonString);

import 'dart:convert';

List<NumberModel> numberModelFromJson(String str) => List<NumberModel>.from(json.decode(str).map((x) => NumberModel.fromJson(x)));

String numberModelToJson(List<NumberModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NumberModel {
    NumberModel({
        this.id,
        this.phone,
        this.wtsphone
    });

    String? id;
    String? phone;
    String? wtsphone;

    factory NumberModel.fromJson(Map<String, dynamic> json) => NumberModel(
        id: json["id"],
        phone: json["phone"],
        wtsphone: json["texto"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "texto": wtsphone
    };
}
