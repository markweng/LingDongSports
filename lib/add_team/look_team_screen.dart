import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sport_score_app/data_center/data_center.dart';


class LookTeamScreen extends StatefulWidget {
  final Map data;

  const LookTeamScreen({Key key, this.data}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LookteamScreenState(data);
  }
}

class _LookteamScreenState extends State {
  final Map data;
  TextEditingController _nameController;
  File _image;

  _LookteamScreenState(this.data);

  @override
  void initState() {
    _nameController = TextEditingController(text: data['name']);

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('球队信息'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              DataCenter.delATeam(data);
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
                          enabled: false,
                          controller: _nameController,
                          decoration: InputDecoration(labelText: '名称'),
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
