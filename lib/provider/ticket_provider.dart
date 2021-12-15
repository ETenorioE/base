import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:svmdiresa/models/tick_model.dart';
import 'package:svmdiresa/models/tick_response.dart';

class TicketProvider {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  
  Future<List<TickModel>> getTicket() async {
    final SharedPreferences prefs = await _prefs;

    final body = {"usu_id": prefs.getString('id')};

    final response = await http.post(
        Uri.parse(
            'https://reporte.sba.org.pe/controllers/tm_ticket.php?op=MyTicket'),
        body: json.encode(body));
    final usersModel = tickModelFromJson(response.body);
    return usersModel;
  }

  Future<List<TickResponseModel>> getResponse(String? id) async {
    final body = {"tick_id": id};

    final response = await http.post(
        Uri.parse(
            'https://reporte.sba.org.pe/controllers/tm_ticket.php?op=Respuesta'),
        body: json.encode(body));
    final usersModel = tickResponseModelFromJson(response.body);
    return usersModel;
  }
}
