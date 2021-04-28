import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'DetailVideo.dart';

rand() {
  Random rndNum = new Random();
  int rand = rndNum.nextInt(100);
  String id = "Vid" + rand.toString();
  return id;
}
// Random random = new Random();
// int rand = random.nextInt(100);

class AddVideo extends StatefulWidget {
  @override
  _AddVideoState createState() => _AddVideoState();
}

class _AddVideoState extends State<AddVideo> {

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

  final appTitle = 'Add Product';
  TextEditingController videoIdCtrl;
  TextEditingController videoNameCtrl;
  TextEditingController videoUrlCtrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProdName();
    videoIdCtrl = new TextEditingController(text: rand());
    videoNameCtrl = new TextEditingController();
    videoUrlCtrl = new TextEditingController();
  }

  Future<List> videoReg() async {
    var url = "https://192.168.43.36/e-technician/video.php";
    var data = {
      "vidId": videoIdCtrl.text,
      "prodName":prodNam,
      "vidName": videoNameCtrl.text,
      "vidUrl": videoUrlCtrl.text,
    };

    final res = await http.post(url, body: data);

    if (jsonDecode(res.body) == "Video already Added") {
      Fluttertoast.showToast(
          msg: "Video is added already", toastLength: Toast.LENGTH_SHORT);
    } else {
      if (jsonDecode(res.body) == "Success") {
        Fluttertoast.showToast(
            msg: "Video Added", toastLength: Toast.LENGTH_SHORT);
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
                  controller: videoIdCtrl,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Video Id',
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
                  controller: videoNameCtrl,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    labelText: 'Video Name',
                    hintText: 'Video Name',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: TextField(
                  controller: videoUrlCtrl,
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
                    labelText: 'Enter URL',
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: MaterialButton(
                  color: Colors.red,
                  onPressed: () => videoReg(),
                  child: Text("Add Video"),
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
    videoNameCtrl.clear();
    videoUrlCtrl.clear();
  }
}

class DisplayVideo extends StatefulWidget {
  @override
  _DisplayVideoState createState() => _DisplayVideoState();
}

class _DisplayVideoState extends State<DisplayVideo> {
  Future<List> getData() async {
    final response = await http.get("https://192.168.43.36/e-technician/showvideo.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    final appTitle = 'Manage Video';
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
                title: new Text(list[i]['videoName']),
                leading: new Icon(Icons.widgets),
                subtitle: new Text("URL : ${list[i]['videoUrl']} "),
              ),
            ),
          ),
        );
      },
    );
  }
}

