import 'package:e_technician/admin/know_op.dart';
import 'package:e_technician/admin/know_op1.dart';
import 'package:e_technician/admin/prod_op.dart';
import 'package:e_technician/admin/tech_op.dart';
import 'package:e_technician/admin/tech_op1.dart';

import 'package:flutter/material.dart';


class admin_home extends StatefulWidget {
  @override
  _admin_homeState createState() => _admin_homeState();
}

class _admin_homeState extends State<admin_home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Admin'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          prodmgmtcard(),
          knowmgmtcard(),
          rntmgmtcard(),
          taskmgmtcard(),
        ],
      ),
    );
  }

  Widget prodmgmtcard() => Card(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.album),
                title: Text('Products Management'),
                //subtitle: Text(''),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text('Add Product Info'),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddProd(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    child: const Text('Manage Product Info'),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DisplayProd(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        ),
      );

  Widget knowmgmtcard() => Card(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.album),
                title: Text('Knowledge Management'),
                //subtitle: Text(''),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text('Add Videos'),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddVideo(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    child: const Text('Manage Videos'),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DisplayVideo(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text('Add Faq'),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddFaq(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 22),
                  TextButton(
                    child: const Text('Manage Faq'),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DisplayFaq(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 23),
                ],
              ),
            ],
          ),
        ),
      );

  Widget rntmgmtcard() => Card(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.album),
                title: Text('Retailer n Technician Management'),
                //subtitle: Text(''),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text('Manage Pending users'),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DisplayPendUsers(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    child: const Text('Manage Approved users'),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DisplayAppUsers(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        ),
      );

  Widget taskmgmtcard() => Card(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.album),
                title: Text('Tasks Management'),
                //subtitle: Text(''),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text('Show Pending Complaints'),
                    onPressed: () {/* ... */},
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        ),
      );
}
