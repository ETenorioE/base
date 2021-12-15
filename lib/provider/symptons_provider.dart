import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:svmdiresa/models/symptons_model.dart';

class SystemProvider {

   final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
   
  Future<List<SymptonModel>> getSymptons() async {
    final response = await http.get(Uri.parse(
        'https://reporte.sba.org.pe/controllers/sintomas.php?op=GetSin'));
    final centersModel = symptonModelFromJson(response.body);
    return centersModel;
  }

  Future<dynamic> inserTicket(String place, String diseases) async {
    final SharedPreferences prefs = await _prefs;

    final body = {
      "usu_id": prefs.getString('id'),
      "sin_id": diseases,
      "lugar": place,
      "Id_Establecimiento": prefs.getString('establecimiento')
    };
    final response = await http.post(Uri.parse('https://reporte.sba.org.pe/controllers/tm_ticket.php?op=InsertarTicket'), body: jsonEncode(body));
    return response.body;
  }
}