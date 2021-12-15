import 'package:http/http.dart' as http;
import 'package:svmdiresa/models/obstetrician_model.dart';

class ObstetricianProvider {
  Future<List<ObstetricianModel>> getObstetrician() async {
    final response = await http.get(Uri.parse(
        'https://reporte.sba.org.pe/controllers/obstetra.php?op=GetAll'));
    final centersModel = obstetricianModelFromJson(response.body);
    return centersModel;
  }
}
