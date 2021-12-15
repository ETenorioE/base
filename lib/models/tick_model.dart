// To parse this JSON data, do
//
//     final tickModel = tickModelFromJson(jsonString);

import 'dart:convert';

List<TickModel> tickModelFromJson(String str) => List<TickModel>.from(json.decode(str).map((x) => TickModel.fromJson(x)));

String tickModelToJson(List<TickModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TickModel {
    TickModel({
        this.tickId,
    });

    String? tickId;

    factory TickModel.fromJson(Map<String, dynamic> json) => TickModel(
        tickId: json["tick_id"],
    );

    Map<String, dynamic> toJson() => {
        "tick_id": tickId,
    };
}
