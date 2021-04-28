import 'dart:io';

import 'package:e_technician/admin/admin_home.dart';
import 'package:e_technician/login.dart';
import 'package:e_technician/register.dart';
import 'package:flutter/material.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(new MaterialApp(
    home: homepg(),
  ));
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

class homepg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'E-Technician';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          // leading: Icon(Icons.menu),
          title: Text(appTitle),
          actions: [
            //Icon(Icons.favorite),
            // ignore: deprecated_member_use
            FlatButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => homepg(),
                  ),
                );
              },
              child: Text("Home"),
            ),
            // ignore: deprecated_member_use
            FlatButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => login(),
                  ),
                );
              },
              child: Text("Login"),
            ),
            // ignore: deprecated_member_use
            FlatButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => registerUser(),
                  ),
                );
              },
              child: Text("Register"),
            ),
          ],
          backgroundColor: Colors.teal,
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.jpeg"),
                  fit: BoxFit.cover)),
        ),
      ),
    );
  }
}
