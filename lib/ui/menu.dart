import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:svmdiresa/models/menu_data.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<dynamic> menu = [
      MenuData(Icons.move_to_inbox_outlined, 'Obstetras', '/obstetrician'),
      MenuData(Icons.find_in_page_outlined, 'Centros de atención', '/centers'),
      MenuData(Icons.upgrade_outlined, 'Sintomas', '/symptons'),
      MenuData(Icons.upgrade_outlined, 'Respuesta', '/symptons-response'),
      MenuData(Icons.find_in_page_outlined, 'Perfil', '/profile'),
      MenuData(Icons.read_more, 'Cerrar sesión', '/logout'),
    ];

    return SafeArea(
      child: Scaffold(
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
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Expanded(
                        child: Text(
                          '  SISTEMA DE\n   VIGILANCIA\n    MATERNA',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Text(
                          'MENU PRINCIPAL',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            height: 200,
            width: MediaQuery.of(context).size.width,
          ),
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: menu.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.3,
                  crossAxisCount: 2,
                  crossAxisSpacing: 2.0,
                  mainAxisSpacing: 2.0),
              itemBuilder: (BuildContext context, int index) {
                return menu[index] != null
                    ? Card(
                        elevation: 0.2,
                        color: Colors.pink,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: InkWell(
                          onTap: () {
                            if (menu[index].path == '/logout') {
                              Dialogs.materialDialog(
                                  msg: '¿Esta seguro de cerrar sesión?',
                                  title: "¿Cerrar Sesión?",
                                  color: Colors.white,
                                  context: context,
                                  actions: [
                                    IconsOutlineButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      text: 'Cancelar',
                                      iconData: Icons.cancel_outlined,
                                      textStyle: TextStyle(color: Colors.grey),
                                      iconColor: Colors.grey,
                                    ),
                                    IconsButton(
                                      onPressed: () async {
                                        SharedPreferences preferences =
                                            await SharedPreferences
                                                .getInstance();
                                        await preferences.clear();
                                        Navigator.pushReplacementNamed(
                                            context, '/login');
                                      },
                                      text: 'Aceptar',
                                      iconData: Icons.delete,
                                      color: Colors.pink,
                                      textStyle: TextStyle(color: Colors.white),
                                      iconColor: Colors.white,
                                    ),
                                  ]);
                            } else {
                              Navigator.pushNamed(context, menu[index].path);
                            }
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                menu[index].icon,
                                size: 30,
                                color: Colors.white,
                              ),
                              SizedBox(height: 20),
                              Text(
                                menu[index].title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      )
                    : Text('');
              },
            ),
          )
        ],
      )),
    );
  }
}
