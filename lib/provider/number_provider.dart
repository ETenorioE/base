import 'package:http/http.dart' as http;
import 'package:svmdiresa/models/number_model.dart';

class NumberProvider {
  Future<List<NumberModel>> getNumber() async {
    final response = await http.get(Uri.parse(
        'https://reporte.sba.org.pe/controllers/credencial.php?op=GetPhone'));
    final centersModel = numberModelFromJson(response.body);
    return centersModel;
  }
}
