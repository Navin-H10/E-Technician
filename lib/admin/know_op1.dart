import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'DetailVideo.dart';

randFaq() {
  Random rndNum = new Random();
  int rand = rndNum.nextInt(100);
  String id = "Faq" + rand.toString();
  return id;
}
// Random random = new Random();
// int rand = random.nextInt(100);

class AddFaq extends StatefulWidget {
  @override
  _AddFaqState createState() => _AddFaqState();
}

class _AddFaqState extends State<AddFaq> {

  String prodNam;
  // ignore: deprecated_member_use
  List data = List();

  Future getProdName() async{
    var resp = await http.get("https://192.168.43.36/e-technician/showprod.php",headers: {"Accept":"application/json"});
    var jsonBody = resp.body;
    var jsonData = json.decode(jsonBody);

    setState(() {
      data = jsonData;
    });
    print(jsonData);
    return "success";
  }

  final appTitle = 'Add Faq';
  TextEditingController faqIdCtrl;
  TextEditingController queCtrl;
  TextEditingController ansCtrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProdName();
    faqIdCtrl = new TextEditingController(text: randFaq());
    queCtrl = new TextEditingController();
    ansCtrl = new TextEditingController();
  }

  Future<List> videoReg() async {
    var url = "https://192.168.43.36/e-technician/video.php";
    var data = {
      "vidId": faqIdCtrl.text,
      "prodName":prodNam,
      "vidName": queCtrl.text,
      "vidUrl": ansCtrl.text,
    };

    final res = await http.post(url, body: data);

    if (jsonDecode(res.body) == "faq already Added") {
      Fluttertoast.showToast(
          msg: "Faq is added already", toastLength: Toast.LENGTH_SHORT);
    } else {
      if (jsonDecode(res.body) == "Success") {
        Fluttertoast.showToast(
            msg: "Faq Added", toastLength: Toast.LENGTH_SHORT);
      } else {
        Fluttertoast.showToast(msg: "Error", toastLength: Toast.LENGTH_SHORT);
      }
    }
  }

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
                  controller: faqIdCtrl,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Faq Id',
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
                    value: prodNam,
                    hint: Text('Product Name'), // Not necessary for Option 1
                    items: data.map((data) {
                      return DropdownMenuItem(
                        child: new Text(data['prodName']),
                        value: data['prodName'],
                      );
                    }).toList(),

                    onChanged: (newValue) {
                      setState(() {
                        prodNam = newValue;
                      });
                    },

                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: TextField(
                  controller: queCtrl,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    labelText: 'Question',
                    hintText: 'Question',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: TextField(
                  controller: ansCtrl,
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
                    labelText: 'Answer',
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: MaterialButton(
                  color: Colors.red,
                  onPressed: () => videoReg(),
                  child: Text("Add Faq"),
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
    queCtrl.clear();
    ansCtrl.clear();
  }
}

class DisplayFaq extends StatefulWidget {
  @override
  _DisplayFaqState createState() => _DisplayFaqState();
}

class _DisplayFaqState extends State<DisplayFaq> {
  Future<List> getData() async {
    final response = await http.get("https://192.168.43.36/e-technician/showfaq.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    final appTitle = 'Manage Faq';
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
                    builder: (BuildContext context)=> new DetailVideo(list: list, index: i,)
                )
            ),
            child: Card(
              child: new ListTile(
                title: new Text(list[i]['question']),
                leading: new Icon(Icons.widgets),
                subtitle: new Text("Answer : ${list[i]['answer']} "),
              ),
            ),
          ),
        );
      },
    );
  }
}