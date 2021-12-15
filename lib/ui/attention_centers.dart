import 'package:flutter/material.dart';
import 'package:svmdiresa/models/centers_model.dart';
import 'package:svmdiresa/provider/centers_provider.dart';
import 'package:svmdiresa/ui/widgets/custom_input.dart';
import 'package:url_launcher/url_launcher.dart';

class AttentionCenterScreen extends StatefulWidget {
  const AttentionCenterScreen({Key? key}) : super(key: key);

  @override
  State<AttentionCenterScreen> createState() => _AttentionCenterScreenState();
}

class _AttentionCenterScreenState extends State<AttentionCenterScreen> {
  CentersProvider centersProvider = CentersProvider();
  List<CentersModel>? res = [];

  @override
  void initState() {
    super.initState();
    centersProvider.getCenters().then((value) => setState(() {
          res = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Text('Centros de atencion'),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomInput(
                    hintText: 'Busca el establecimiento más cercano',
                    title: '',
                    characterl: 100,
                    readOnly: false,
                    type: TextInputType.text,
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
                          leading: Icon(Icons.home),
                          title: Text('${res![index].nomEst}'),
                          subtitle: Text('${res![index].direc}'),
                          trailing: IconButton(
                              onPressed: () async {
                                launch(
                                    "tel://+51${res![index].phone}");
                              },
                              icon: Icon(Icons.call)),
                        ),
                      );
                    })
              ],
            ),
          ),
        ));
  }
}
