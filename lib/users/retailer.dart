import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class retailer extends StatefulWidget {
  @override
  _retailerState createState() => _retailerState();
}

class _retailerState extends State<retailer> {
  final appTitle = 'Retailer';
  TextEditingController unamectrl = new TextEditingController();
  TextEditingController emailctrl = new TextEditingController();

  Future<List> register() async {
    var url = "https://192.168.1.8/e-technician/retailer.php";
    var data = {
      "username": unamectrl.text,
      "email": emailctrl.text,
    };

    final res = await http.post(url, body: data);

    if (jsonDecode(res.body) == "Email already Registered") {
      Fluttertoast.showToast(
          msg: "account exists, Please login", toastLength: Toast.LENGTH_SHORT);
    } else {
      if (jsonDecode(res.body) == "Success") {
        Fluttertoast.showToast(
            msg: "account created", toastLength: Toast.LENGTH_SHORT);
      } else {
        Fluttertoast.showToast(msg: "Error", toastLength: Toast.LENGTH_SHORT);
      }
    }
  }

  List<String> _gender = ['Male', 'Female']; // Option 2
  String _selectedGender; // Option 2

  List<String> _type = ['Retailer', 'Technician', 'Customer']; // Option 2
  String _selectedType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Retailer'),
      ),
    );
  }
}
