import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: Technician(),
  ));
}

class Technician extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-Technician'),
      ),
    );
  }
}
