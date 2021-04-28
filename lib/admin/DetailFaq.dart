import 'dart:convert';

import 'package:e_technician/admin/admin_home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class DetailFaq extends StatefulWidget {
  final List list;
  final int index;
  DetailFaq({this.index, this.list});
  @override
  _DetailFaqState createState() => _DetailFaqState();
}

class _DetailFaqState extends State<DetailFaq> {
  Future<void> deleteData() async {
    var url = "https://192.168.43.36/e-technician/deleteFaq.php";
    final res = await http.post(url, body: {
      "id": widget.list[widget.index]['faqId'],
    });
    if (jsonDecode(res.body) == "Success") {
      Fluttertoast.showToast(
          msg: "${widget.list[widget.index]['question']} video is deleted", toastLength: Toast.LENGTH_SHORT);
    } else {
      Fluttertoast.showToast(msg: "Error", toastLength: Toast.LENGTH_SHORT);
    }
  }

  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text(
          "Are you sure want to delete '${widget.list[widget.index]['question']}'"),
      actions: [
        // ignore: deprecated_member_use
        new RaisedButton(
          child: new Text("OK DELETE!", style: new TextStyle(color: Colors.black),),
          color: Colors.red,
          onPressed: () {
            deleteData();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => admin_home(),
              ),
            );
          },
        ),
        // ignore: deprecated_member_use
        new RaisedButton(
          child: new Text("CANCEL", style: new TextStyle(color: Colors.black)),
          color: Colors.green,
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("${widget.list[widget.index]['question']}")),
        body: Container(
          height: 250.0,
          padding: const EdgeInsets.all(20.0),
          child: Card(
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                  ),
                  Text(
                    widget.list[widget.index]['question'],
                    style:
                    TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Answer : ${widget.list[widget.index]['answer']}",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  // Text(
                  //   "Product Type: ${widget.list[widget.index]['prodType']}",
                  //   style: TextStyle(fontSize: 18.0),
                  // ),
                  // Text(
                  //   "Product Version: ${widget.list[widget.index]['prodVer']}",
                  //   style: TextStyle(fontSize: 18.0),
                  // ),
                  // Text(
                  //   "Manufactured Year: ${widget.list[widget.index]['mfdYear']}",
                  //   style: TextStyle(fontSize: 18.0),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      // ignore: deprecated_member_use
                      RaisedButton(
                        child: Text("DELETE"),
                        color: Colors.red,
                        onPressed: () => confirm(),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
