import 'package:flutter/material.dart';
import 'package:svmdiresa/models/obstetrician_model.dart';
import 'package:svmdiresa/provider/obstetrician_provider.dart';
import 'package:svmdiresa/ui/widgets/custom_input.dart';
import 'package:url_launcher/url_launcher.dart';

class ObstreticianScreen extends StatefulWidget {
  const ObstreticianScreen({Key? key}) : super(key: key);

  @override
  State<ObstreticianScreen> createState() => _ObstreticianScreenState();
}

class _ObstreticianScreenState extends State<ObstreticianScreen> {
  List<ObstetricianModel>? res = [];
  ObstetricianProvider obstetricianProvider = ObstetricianProvider();

  @override
  void initState() {
    super.initState();
    obstetricianProvider.getObstetrician().then((value) => setState(() {
          res = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Text('OBSTETRAS'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomInput(
                  hintText: 'Busca el obstetra más cercano',
                  title: '',
                  characterl: 100,
                  type: TextInputType.text,
                  readOnly: false,
                  onChanged: (value) {
                    setState(() {
                      res = res!.where((element) => element.nomEst!.toLowerCase().contains(value.toLowerCase())).toList();
                    });
                  },
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: res!.length,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Icon(Icons.person_pin),
                        title: Text('${res![index].nomEst}'),
                        subtitle: Text('${res![index].nom}'),
                        trailing: IconButton(
                            onPressed: () async {
                              launch("tel://+51${res![index].phone}");
                            },
                            icon: Icon(Icons.call)),
                      ),
                    );
                  })
            ],
          ),
        ));
  }
}
