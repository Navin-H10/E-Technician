import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

void main() => runApp(registerUser());

class registerUser extends StatefulWidget {
  @override
  _registerUserState createState() => _registerUserState();
}

class _registerUserState extends State<registerUser> {
  final appTitle = 'Register';
  TextEditingController unamectrl = new TextEditingController();
  TextEditingController passctrl = new TextEditingController();
  TextEditingController addressctrl = new TextEditingController();
  TextEditingController emailctrl = new TextEditingController();
  TextEditingController phonectrl = new TextEditingController();

  Future<List> register() async {
    String url = "https://192.168.43.36/e-technician/register.php";
    var data = {
      "username": unamectrl.text,
      "pass": passctrl.text,
      "gender": _selectedGender,
      "address": addressctrl.text,
      "type": _selectedType,
      "email": emailctrl.text,
      "phone": phonectrl.text,
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
  String _selectedType; // Option 2

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
                    //labelText: 'Enter your name',
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
                // decoration: BoxDecoration(
                //   color: Colors.white,
                //   borderRadius: BorderRadius.circular(12),
                // ),
                child: Container(
                  width: 500,
                  height: 50,
                  child: DropdownButton(
                    // iconEnabledColor: Colors.white,
                    hint: Text('gender'), // Not necessary for Option 1
                    value: _selectedGender,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedGender = newValue;
                      });
                    },
                    items: _gender.map((location) {
                      return DropdownMenuItem(

                        child: new Text(location),
                        value: location,
                      );
                    }).toList(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: TextField(
                  controller: addressctrl,
                  keyboardType: TextInputType.multiline,
                  maxLines: 8,
                  maxLength: 1000,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    labelText: 'Enter your address',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                // decoration: BoxDecoration(
                //   color: Colors.white,
                //   borderRadius: BorderRadius.circular(12),
                // ),
                child: Container(
                  width: 500,
                  height: 50,
                  child: DropdownButton(
                    hint: Text('Type of user'), // Not necessary for Option 1
                    value: _selectedType,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedType = newValue;
                      });
                    },
                    items: _type.map((location) {
                      return DropdownMenuItem(
                        child: new Text(location),
                        value: location,
                      );
                    }).toList(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailctrl,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    hintText: 'Enter your email',
                    labelText: 'Enter your email',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: phonectrl,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    hintText: 'Enter your contact',
                    labelText: 'Enter your contact',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: MaterialButton(
                  color: Colors.red,
                  onPressed: () => register(),
                  child: Text("Register"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

