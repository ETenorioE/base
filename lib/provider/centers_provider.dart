import 'package:http/http.dart' as http;
import 'package:svmdiresa/models/centers_model.dart';

class CentersProvider {
  Future<List<CentersModel>> getCenters() async {
    final response = await http.get(Uri.parse(
        'https://reporte.sba.org.pe/controllers/establecimiento.php?op=GetAll'));
    final centersModel = centersModelFromJson(response.body);
    return centersModel;
  }
}
