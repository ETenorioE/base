import 'package:shared_preferences/shared_preferences.dart';
import 'package:svmdiresa/provider/credentials_provider.dart';
import 'package:svmdiresa/ui/symptons_response.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:flutter/material.dart';
import 'package:svmdiresa/models/symptons_model.dart';
import 'package:svmdiresa/provider/symptons_provider.dart';
import 'package:svmdiresa/ui/menu.dart';
import 'package:svmdiresa/ui/widgets/custom_button.dart';
import 'package:svmdiresa/ui/widgets/custom_input.dart';

class SymptomScreen extends StatefulWidget {
  const SymptomScreen({Key? key}) : super(key: key);

  @override
  State<SymptomScreen> createState() => _SymptomScreenState();
}

class _SymptomScreenState extends State<SymptomScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TwilioFlutter? twilioFlutter;
  List<SymptonModel> data = [];
  String place = '';

  @override
  void initState() {
    super.initState();
    setCredentials();
    SystemProvider systemProvider = SystemProvider();
    systemProvider.getSymptons().then((value) => setState(() {
          data = value;
        }));
  }

  void setCredentials() async {
    CredentialsProvider credentialsProvider = CredentialsProvider();
    var response = await credentialsProvider.getCredentials();
    twilioFlutter = TwilioFlutter(
        accountSid: response[0].login!,
        authToken: response[0].pass!,
        twilioNumber: response[0].phone!);
  }



  void sendSms(List numbers, String center, String namecenter, String name,
      String symton, String phone) async {
    numbers.forEach((element) {
      twilioFlutter!.sendSMS(
          toNumber: '$element',
          messageBody:
              '\nEl/la Sr(a). $name con código de establecimiento: $center\n$namecenter Presenta los siguientes sintomas: $symton\nSu número de celular es: $phone\nDIRESA-AYACUCHO');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color.fromRGBO(255, 79, 99, 1),
                    Colors.pink,
                  ],
                )),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'SINTOMAS',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          Text(
                            'CONTESTE SI TIENE ALGUNO DE ESTOS SINTOMAS',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                height: 200,
                width: MediaQuery.of(context).size.width,
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => MenuScreen()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'IR A MENU',
                          style: TextStyle(color: Colors.pink),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => MenuScreen()));
                            },
                            icon: Icon(
                              Icons.arrow_forward_outlined,
                              color: Colors.pink,
                            )),
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomInput(
                  characterl: 100,
                  hintText: '',
                  title: 'EN DONDE TE ENCUENTRAS ACTUALMENTE',
                  type: TextInputType.text,
                  readOnly: false,
                  onChanged: (value) {
                    setState(() {
                      place = value;
                    });
                  },
                ),
              ),
              data.isNotEmpty
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2,
                      child: ListView.builder(
                          itemCount: data.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              title: Text('${data[index].sintomas}'),
                              value: data[index].active,
                              onChanged: (bool? value) {
                                setState(() {
                                  data[index].active = value;
                                });
                              },
                            );
                          }),
                    )
                  : Center(child: CircularProgressIndicator())
            ],
          ),
        ),
        floatingActionButton: data
                .where((element) => element.active == true)
                .isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: CustomButtonPrimary(
                  onTap: () async {
                    final lst = data.where((element) => element.active == true);
                    final send = lst.map((e) => e.sintomas).toList().join(',');
                    final SharedPreferences prefs = await _prefs;
                    SystemProvider systemProvider = SystemProvider();
                    sendSms(
                        [
                          prefs.getString('central')!,
                          prefs.getString('red')!,
                          prefs.getString('microred')!
                        ],
                        prefs.getString('establecimiento')!,
                        prefs.getString('name_establecimiento')!,
                        prefs.getString('name')! +
                            ' ' +
                            prefs.getString('lastname')!,
                        send,
                        prefs.getString('phone')!);
                    await systemProvider.inserTicket(place, send).then((value) {
                      for (var e in data) {
                        e.active = false;
                      }
                      place = '';
                      dialog(context);
                    });
                  },
                  text: 'enviar',
                ),
              )
            : Text(''),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

void dialog(context) {
  showGeneralDialog(
    context: context,
    barrierColor: Colors.pink, // Background color
    barrierDismissible: false,
    barrierLabel: 'Dialog',
    transitionDuration: Duration(
        milliseconds:
            400), // How long it takes to popup dialog after button click
    pageBuilder: (_, __, ___) {
      // Makes widget fullscreen
      return SizedBox.expand(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      'SUS SINTOMAS FUERON ENVIADOS AL PERSONAL DE SALUD',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          decoration: TextDecoration.none)),
                ),
                SizedBox(height: 25),
                Center(
                  child: Container(
                      width: MediaQuery.of(context).size.height / 3,
                      height: MediaQuery.of(context).size.height / 3,
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/pregnant.jpg')))),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => SymptonResponseScreen())),
                    child: Text(
                      'VER RESPUESTA',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.pink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ))
              ],
            ),
          ),
        ),
      );
    },
  );
}
