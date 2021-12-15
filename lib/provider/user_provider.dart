import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:svmdiresa/models/user_model.dart';

class UserProvider {

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  
  Future<List<UserModel>> getUser() async {
    final SharedPreferences prefs = await _prefs;

    final body = {"usu_dni": prefs.getString('dni')};

    final response = await http.post(Uri.parse(
        'https://reporte.sba.org.pe/controllers/usuario.php?op=GetId'), body: json.encode(body));
    final usersModel = userModelFromJson(response.body);
    return usersModel;
  }

   Future<List<UserModel>> getUserInput(String dni) async {
    final body = {"usu_dni": dni};

    final response = await http.post(Uri.parse(
        'https://reporte.sba.org.pe/controllers/usuario.php?op=GetId'), body: json.encode(body));
    final usersModel = userModelFromJson(response.body);
    return usersModel;
  }

  Future<bool> updateNumber(String number) async {
    final SharedPreferences prefs = await _prefs;
    final body = {
      "usu_id": prefs.getString('id'),
      "usu_celular": number
    };
    final response = await http.put(Uri.parse(
        'https://reporte.sba.org.pe/controllers/usuario.php?op=UpId'), body: json.encode(body));
    if(response.statusCode == 200){
      return true;
    } else {
      return false;
    };  
  }
}
