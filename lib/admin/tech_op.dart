import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Detailuser.dart';

class DisplayPendUsers extends StatefulWidget {
  @override
  _DisplayPendUsersState createState() => _DisplayPendUsersState();
}

class _DisplayPendUsersState extends State<DisplayPendUsers> {
  Future<List> getData() async {
    final response = await http.get("https://192.168.43.36/e-technician/getuser.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    final appTitle = 'Manage Pending Users';
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),

      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new ItemList(
            list: snapshot.data,
          )
              : new Center(
            child: new CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: ()=>Navigator.of(context).push(
                new MaterialPageRoute(
                    builder: (BuildContext context)=> new DetailUser(list: list, index: i,)
                )
            ),
            child: Card(
              child: new ListTile(
                title: new Text(list[i]['uname']),
                leading: new Icon(Icons.widgets),
                subtitle: new Text("Type : ${list[i]['type']} "),
              ),
            ),
          ),
        );
      },
    );
  }
}
