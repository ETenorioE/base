// To parse this JSON data, do
//
//     final tickResponseModel = tickResponseModelFromJson(jsonString);

import 'dart:convert';

List<TickResponseModel> tickResponseModelFromJson(String str) => List<TickResponseModel>.from(json.decode(str).map((x) => TickResponseModel.fromJson(x)));

String tickResponseModelToJson(List<TickResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TickResponseModel {
    TickResponseModel({
        this.sinId,
    });

    String? sinId;

    factory TickResponseModel.fromJson(Map<String, dynamic> json) => TickResponseModel(
        sinId: json["sin_id"],
    );

    Map<String, dynamic> toJson() => {
        "sin_id": sinId,
    };
}
