import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:svmdiresa/provider/number_provider.dart';
import 'package:svmdiresa/provider/user_provider.dart';
import 'package:svmdiresa/ui/widgets/custom_button.dart';
import 'package:svmdiresa/ui/widgets/custom_input.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String? dni;
  UserProvider userProvider = UserProvider();
  String _connectionStatus = 'Unknown';
  String? number;
  String? textWtsp;
  final Connectivity _connectivity = Connectivity();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  final snackBar = SnackBar(
    content: const Text('Error de conexión, verifique su red.'),
    action: SnackBarAction(
      label: 'Aceptar',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1);
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    NumberProvider numberProvider = NumberProvider();
    await numberProvider.getNumber().then((value) => setState(() {
          number = value[0].phone;
          textWtsp = value[0].wtsphone;
        }));
    ConnectivityResult result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          key: _scaffoldKey,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                      child: Text(
                        '   ACCEDISTE A LA \nAPP DE SISTEMA DE\n        VIGILANCIA\n         MATERNA',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'INICIAR SESIÓN',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
                height: 200,
                width: MediaQuery.of(context).size.width,
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomInput(
                  hintText: '',
                  title: 'POR FAVOR INGRESE SU DNI',
                  readOnly: false,
                  onChanged: (value) {
                    setState(() {
                      dni = value;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Registrate llamando'),
                  IconButton(
                      onPressed: () {
                        launch("tel://${number}");
                      },
                      icon: Icon(Icons.phone)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Whatsapp', style: TextStyle(color: Colors.green[200])),
                  IconButton(
                      onPressed: () {
                         launch("whatsapp://send?phone=$number&text=$textWtsp");
                      },
                      icon: Image.asset(
                        'assets/images/whatsapp.png',
                        width: 20,
                        height: 20,
                      ))
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
                child: CustomButtonPrimary(
                  onTap: () async {
                    final SharedPreferences prefs = await _prefs;
                    if (dni!.length < 8 || dni!.isEmpty)
                      showToast('Debe contener 8 caracteres');
                    if (dni!.length == 8) {
                      var res = await userProvider.getUserInput(dni!);
                      if (res.length < 1) {
                        showToast('DNI no encontrado');
                      } else {
                        prefs.setString('name', res[0].usuNom!);
                        prefs.setString('lastname', res[0].usuApe!);
                        prefs.setString(
                            'establecimiento', res[0].idEstablecimiento!);
                        prefs.setString('name_establecimiento',
                            res[0].nombreEstablecimiento!);
                        prefs.setString('id', res[0].usuId!);
                        prefs.setString('central', res[0].central!);
                        prefs.setString('red', res[0].red!);
                        prefs.setString('microred', res[0].microred!);
                        prefs.setString('phone', res[0].usuCelular!);
                        prefs.setString('dni', res[0].usuDni!);
                        showToast('Bienvenido ${res[0].usuNom}');
                        Navigator.pushReplacementNamed(context, '/symptons');
                      }
                    }
                  },
                  text: 'ingresar',
                ),
              )
            ],
          )),
    );
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        break;
      case ConnectivityResult.mobile:
        break;
      case ConnectivityResult.none:
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }
}
