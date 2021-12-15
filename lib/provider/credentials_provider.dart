import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:svmdiresa/models/credential_model.dart';
import 'package:svmdiresa/models/obstetrician_model.dart';

class CredentialsProvider {
  Future<List<CredentialsModel>> getCredentials() async {
    final response = await http.get(Uri.parse(
        'https://reporte.sba.org.pe/controllers/credencial.php?op=GetCre'));
    final credentialsModel = credentialsModelFromJson(response.body);
    return credentialsModel;
  }
}