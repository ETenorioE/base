import 'package:flutter/material.dart';
import 'package:svmdiresa/models/obstetrician_model.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<ObstetricianModel>? data;

  CustomSearchDelegate({this.data});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }
    return FutureBuilder(
      initialData: data,
      builder: (context, AsyncSnapshot<List<ObstetricianModel>> snapshot){
        return ListView.builder(
        shrinkWrap: true,
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index){
          if(snapshot.hasData){
            return ListTile(
              title: Text('${snapshot.data![index].nom}'),
            );
          }else{
            return Text('data');
          }
        },
      );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Column();
  }

}