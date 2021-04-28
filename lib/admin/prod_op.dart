import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'detail.dart';

rand() {
  Random rndnum = new Random();
  int rand = rndnum.nextInt(100);
  String id = "Prod" + rand.toString();
  return id;
}
// Random random = new Random();
// int rand = random.nextInt(100);

class AddProd extends StatefulWidget {
  @override
  _AddProdState createState() => _AddProdState();
}

class _AddProdState extends State<AddProd> {
  final appTitle = 'Add Product';
  TextEditingController prodIdCtrl;
  TextEditingController prodNameCtrl;
  TextEditingController prodVerCtrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prodIdCtrl = new TextEditingController(text: rand());
    prodNameCtrl = new TextEditingController();
    prodVerCtrl = new TextEditingController();
  }

  Future<List> prodRegister() async {
    var url = "https://192.168.43.36/e-technician/product.php";
    var data = {
      "prodid": prodIdCtrl.text,
      "prodname": prodNameCtrl.text,
      "prodver": prodVerCtrl.text,
      "mfdyear": selectedYear,
      "prodtype": selectedType,
    };

    final res = await http.post(url, body: data);

    if (jsonDecode(res.body) == "Product already Added") {
      Fluttertoast.showToast(
          msg: "Product is added already", toastLength: Toast.LENGTH_SHORT);
    } else {
      if (jsonDecode(res.body) == "Success") {
        Fluttertoast.showToast(
            msg: "Product Added", toastLength: Toast.LENGTH_SHORT);
      } else {
        Fluttertoast.showToast(msg: "Error", toastLength: Toast.LENGTH_SHORT);
      }
    }
  }

  List<String> _year = [
    '2010',
    '2011',
    '2012',
    '2013',
    '2014',
    '2015',
    '2016',
    '2017'
  ]; // Option 2
  String selectedYear; // Option 2

  List<String> _type = ['Electrical', 'Electronics']; // Option 2
  String selectedType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        color: Colors.lightBlueAccent,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: TextField(
                  readOnly: true,
                  controller: prodIdCtrl,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    //hintText: 'Enter your name',
                    labelText: 'Product Id',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: TextField(
                  controller: prodNameCtrl,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    labelText: 'Product Name',
                    hintText: 'Product Name',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: prodVerCtrl,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    labelText: 'Product Version',
                    hintText: 'Product Version',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 21, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  width: 300,
                  height: 50,
                  child: DropdownButton(
                    // iconEnabledColor: Colors.white,
                    hint:
                        Text('Manufactured Year'), // Not necessary for Option 1
                    value: selectedYear,
                    onChanged: (newValue) {
                      setState(() {
                        selectedYear = newValue;
                      });
                    },
                    items: _year.map((location) {
                      return DropdownMenuItem(
                        child: new Text(location),
                        value: location,
                      );
                    }).toList(),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 21, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  width: 300,
                  height: 50,
                  child: DropdownButton(
                    hint: Text('Type of product'), // Not necessary for Option 1
                    value: selectedType,
                    onChanged: (newValue) {
                      setState(() {
                        selectedType = newValue;
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
                child: MaterialButton(
                  color: Colors.red,
                  onPressed: () => prodRegister(),
                  child: Text("Submit"),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: MaterialButton(
                  color: Colors.red,
                  onPressed: () => clear(),
                  child: Text("Reset"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  clear() {
    prodNameCtrl.clear();
    prodVerCtrl.clear();
    selectedYear = "";
    selectedType = "";
  }
}

class DisplayProd extends StatefulWidget {
  @override
  _DisplayProdState createState() => _DisplayProdState();
}

class _DisplayProdState extends State<DisplayProd> {
  Future<List> getData() async {
    final response = await http.get("https://192.168.43.36/e-technician/showprod.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    final appTitle = 'Manage Product';
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
                  builder: (BuildContext context)=> new Detail(list: list, index: i,)
              )
            ),
            child: Card(
              child: new ListTile(
                title: new Text(list[i]['prodName']),
                leading: new Icon(Icons.widgets),
                subtitle: new Text("Product Type : ${list[i]['prodType']} \nProduct Version : ${list[i]['prodVer']} \nManufactured Year : ${list[i]['mfdYear']}"),
              ),
            ),
          ),
        );
      },
    );
  }
}

