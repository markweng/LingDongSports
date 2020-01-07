import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sport_score_app/data_center/data_center.dart';

class LookPlayerScreen extends StatefulWidget {
  final Map data;

  const LookPlayerScreen({Key key, this.data}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LookPlayerScreenState(data);
  }
}

class _LookPlayerScreenState extends State {
  final Map data;
  TextEditingController _nameController;
  TextEditingController _heightController;
  TextEditingController _ageController;
  File _image;

  _LookPlayerScreenState(this.data);
  @override
  void initState() {
    _nameController = TextEditingController(text: data['name']);
    _heightController = TextEditingController(text: data['height']);
    _ageController = TextEditingController(text: data['age']);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _heightController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('球员信息'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              DataCenter.delAPlayer(data);
              Navigator.of(context).pop();
            },
            child: Text(
              '删除',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Card(
                        clipBehavior: Clip.hardEdge,
                        elevation: 5,
                        child: Image.file(
                          File(data['image']),
                          width: 60,
                          height: 60,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 200,
                        height: 70,
                        child: TextField(
                          controller: _nameController,
                          enabled: false,
                          decoration: InputDecoration(labelText: '姓名'),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 200,
                        height: 70,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          enabled: false,
                          controller: _heightController,
                          decoration: InputDecoration(labelText: '身高(CM)'),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 200,
                        height: 70,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          enabled: false,
                          controller: _ageController,
                          decoration: InputDecoration(labelText: '年龄'),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
