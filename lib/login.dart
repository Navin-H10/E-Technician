import 'dart:convert';
import 'dart:async';

import 'package:e_technician/users/customer.dart';
import 'package:e_technician/users/retailer.dart';
import 'package:e_technician/users/technician.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'admin/admin_home.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  final appTitle = 'Login';
  TextEditingController unamectrl;
  TextEditingController passctrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    unamectrl = new TextEditingController();
    passctrl = new TextEditingController();
  }

  Future<List> login() async {
    var url = "https://192.168.43.36/e-technician/login.php";
    var data = {
      "username": unamectrl.text,
      "password": passctrl.text,
    };

    final res = await http.post(url, body: data);
    var ch = jsonDecode(res.body);
    switch(ch){
      case "Retailer": {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => retailer(),
          ),
        );
        break;}
      case "Technician": {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => technician(),
          ),
        );
        break;
      }
      case "Customer": {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => customer(),
          ),
        );
        break;
      }
      case "Admin": {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => admin_home(),
          ),
        );
        break;
      }
      default: {
        Fluttertoast.showToast(
            msg: "Account does not exist", toastLength: Toast.LENGTH_SHORT);
        break;
      }
    }
    // if (jsonDecode(res.body) == "Success") {
    //   Fluttertoast.showToast(
    //       msg: "Login is successful", toastLength: Toast.LENGTH_SHORT);
    // } else {
    //   Fluttertoast.showToast(
    //       msg: "Account does not exist", toastLength: Toast.LENGTH_SHORT);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        color: Colors.lightBlueAccent,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: TextField(
                  controller: unamectrl,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Enter your name',
                    labelText: 'Enter your name',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: TextField(
                  obscureText: true,
                  controller: passctrl,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    labelText: 'Password',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: MaterialButton(
                  color: Colors.blueAccent,
                  onPressed: () {
                    login();
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => admin_home(),
                    //   ),
                    // );
                  },
                  child: Text("Login"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
