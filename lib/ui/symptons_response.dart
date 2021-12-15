import 'package:flutter/material.dart';
import 'package:svmdiresa/models/tick_response.dart';
import 'package:svmdiresa/provider/ticket_provider.dart';
import 'package:svmdiresa/ui/widgets/custom_button.dart';

class SymptonResponseScreen extends StatefulWidget {
  const SymptonResponseScreen({Key? key}) : super(key: key);

  @override
  State<SymptonResponseScreen> createState() => _SymptonResponseScreenState();
}

class _SymptonResponseScreenState extends State<SymptonResponseScreen> {
  TicketProvider ticketProvider = TicketProvider();
  String? number;
  List<TickResponseModel> response = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    await ticketProvider
        .getTicket()
        .then((value) => setState(() {
              number = value[0].tickId;
            }))
        .then((value) =>
            ticketProvider.getResponse(number).then((value) => setState(() {
                  response = value;
                })));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Text('respuesta a los sintomas'.toUpperCase()),
              Text('Consulta N° $number')
            ],
          ),
          backgroundColor: Colors.pink,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0, left: 13, top: 15),
              child: Text(
                'RESPUESTA DE LA OBSTETRA',
                style: TextStyle(color: Colors.pink),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                color: Colors.pink,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        for (var e in response)
                          Text(
                            '${e.sinId}'.toUpperCase(),
                            style: TextStyle(color: Colors.white),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButtonPrimary(
                onTap: () async {
                  Navigator.pushNamed(context, '/symptons');
                },
                text: 'nuevos sintomas',
              ),
            )
          ],
        ));
  }
}
