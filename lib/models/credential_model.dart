// To parse this JSON data, do
//
//     final credentialsModel = credentialsModelFromJson(jsonString);

import 'dart:convert';

List<CredentialsModel> credentialsModelFromJson(String str) => List<CredentialsModel>.from(json.decode(str).map((x) => CredentialsModel.fromJson(x)));

String credentialsModelToJson(List<CredentialsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CredentialsModel {
    CredentialsModel({
        this.login,
        this.pass,
        this.phone,
    });

    String? login;
    String? pass;
    String? phone;

    factory CredentialsModel.fromJson(Map<String, dynamic> json) => CredentialsModel(
        login: json["login"],
        pass: json["pass"],
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "login": login,
        "pass": pass,
        "phone": phone,
    };
}
