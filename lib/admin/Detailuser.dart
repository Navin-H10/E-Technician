import 'dart:convert';
import 'package:e_technician/admin/admin_home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class DetailUser extends StatefulWidget {
  final List list;
  final int index;
  DetailUser({this.index, this.list});
  @override
  _DetailUserState createState() => _DetailUserState();
}

class _DetailUserState extends State<DetailUser> {
  Future<void> deleteData() async {
    var url = "https://192.168.43.36/e-technician/deleteusr.php";
    final res = await http.post(url, body: {
      "name": widget.list[widget.index]['uname'],
    });
    if (jsonDecode(res.body) == "Success") {
      Fluttertoast.showToast(
          msg: "${widget.list[widget.index]['uname']} user is deleted", toastLength: Toast.LENGTH_SHORT);
    } else {
      Fluttertoast.showToast(msg: "Error", toastLength: Toast.LENGTH_SHORT);
    }
  }

  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text(
          "Are you sure want to delete '${widget.list[widget.index]['uname']}'"),
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

  Future<void> approve() async {
    var url = "https://192.168.43.36/e-technician/insusr.php";
    final res = await http.post(url, body: {
      "name": widget.list[widget.index]['uname'],
      "pass": widget.list[widget.index]['pass'],
      "gender": widget.list[widget.index]['gender'],
      "address": widget.list[widget.index]['address'],
      "type": widget.list[widget.index]['type'],
      "email": widget.list[widget.index]['email'],
      "phone": widget.list[widget.index]['phone'],

    });
    if (jsonDecode(res.body) == "Success") {
      Fluttertoast.showToast(
          msg: "${widget.list[widget.index]['uname']} user is approved", toastLength: Toast.LENGTH_SHORT);
    } else {
      Fluttertoast.showToast(msg: "Error", toastLength: Toast.LENGTH_SHORT);
    }
  }
  void confApprove() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text(
          "Are you sure want to approve '${widget.list[widget.index]['uname']}'"),
      actions: [
        // ignore: deprecated_member_use
        new RaisedButton(
          child: new Text("OK Approve!", style: new TextStyle(color: Colors.black),),
          color: Colors.red,
          onPressed: () {
            approve();
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
        appBar: AppBar(title: Text("${widget.list[widget.index]['uname']}")),
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
                    widget.list[widget.index]['uname'],
                    style:
                    TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Gender : ${widget.list[widget.index]['gender']}",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    "Email: ${widget.list[widget.index]['email']}",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    "Type of User: ${widget.list[widget.index]['type']}",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    "Phone: ${widget.list[widget.index]['phone']}",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      // ignore: deprecated_member_use
                      RaisedButton(
                        child: Text("APPROVE"),
                        color: Colors.green,
                        onPressed: () => confApprove(),
                      ),
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

class DetailAppUser extends StatefulWidget {
  final List list;
  final int index;
  DetailAppUser({this.index, this.list});
  @override
  _DetailAppUserState createState() => _DetailAppUserState();
}

class _DetailAppUserState extends State<DetailAppUser> {
  Future<void> deleteData() async {
    var url = "https://192.168.43.36/e-technician/deleteusr.php";
    final res = await http.post(url, body: {
      "name": widget.list[widget.index]['uname'],
    });
    if (jsonDecode(res.body) == "Success") {
      Fluttertoast.showToast(
          msg: "${widget.list[widget.index]['uname']} user is deleted", toastLength: Toast.LENGTH_SHORT);
    } else {
      Fluttertoast.showToast(msg: "Error", toastLength: Toast.LENGTH_SHORT);
    }
  }

  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text(
          "Are you sure want to delete '${widget.list[widget.index]['uname']}'"),
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
        appBar: AppBar(title: Text("${widget.list[widget.index]['uname']}")),
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
                    widget.list[widget.index]['uname'],
                    style:
                    TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Gender : ${widget.list[widget.index]['gender']}",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    "Email: ${widget.list[widget.index]['email']}",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    "Type of User: ${widget.list[widget.index]['type']}",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    "Phone: ${widget.list[widget.index]['phone']}",
                    style: TextStyle(fontSize: 18.0),
                  ),
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
