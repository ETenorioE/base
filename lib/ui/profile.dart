import 'package:flutter/material.dart';
import 'package:svmdiresa/models/user_model.dart';
import 'package:svmdiresa/provider/user_provider.dart';
import 'package:svmdiresa/ui/menu.dart';
import 'package:svmdiresa/ui/widgets/custom_button.dart';
import 'package:svmdiresa/ui/widgets/custom_input.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserProvider userProvider = UserProvider();
  String? number;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 130.0,
          backgroundColor: Colors.pink,
          title: Text('Perfil'.toUpperCase()),
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              'Sistema de vigilancia materna'.toUpperCase(),
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                future: userProvider.getUser(),
                builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                  if (snapshot.hasData) {
                    return Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomInput(
                            hintText: '',
                            title: 'NOMBRE Y APELLIDO',
                            initialValue:
                                '${snapshot.data![0].usuNom! + ' ' + snapshot.data![0].usuApe!}',
                            readOnly: true,
                            onChanged: (value) {},
                          ),
                          SizedBox(height: 10),
                          CustomInput(
                            hintText: '',
                            title: 'ESTABLECIMIENTO',
                            initialValue:
                                snapshot.data![0].nombreEstablecimiento,
                            readOnly: true,
                            onChanged: (value) {},
                          ),
                          SizedBox(height: 10),
                          CustomInput(
                            hintText: '',
                            initialValue: snapshot.data![0].usuDni,
                            title: 'DNI',
                            readOnly: true,
                            onChanged: (value) {},
                          ),
                          SizedBox(height: 10),
                          CustomInput(
                            hintText: '',
                            initialValue: snapshot.data![0].usuCelular,
                            title: 'CELULAR',
                            characterl: 15,
                            readOnly: false,
                            onChanged: (value) {
                              setState(() {
                                number = value;
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomButtonPrimary(
                              onTap: () async {
                                var response =
                                    await userProvider.updateNumber(number!);
                                if (response)
                                  Dialogs.materialDialog(
                                      msg: 'actualizados correctamente',
                                      title: 'datos',
                                      context: context,
                                      actions: [
                                        IconsButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        MenuScreen()));
                                          },
                                          text: 'Aceptar',
                                          iconData: Icons.check,
                                          color: Colors.pink,
                                          textStyle:
                                              TextStyle(color: Colors.white),
                                          iconColor: Colors.white,
                                        ),
                                      ]);
                              },
                              text: 'actualizar',
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
        )
      ],
    ));
  }
}
