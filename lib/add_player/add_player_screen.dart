import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sport_score_app/data_center/data_center.dart';
import 'package:sport_score_app/utils/screen_util.dart';

class AddPlayerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddPlayerScreenState();
  }
}

class _AddPlayerScreenState extends State {
  TextEditingController _nameController;
  TextEditingController _heightController;
  TextEditingController _ageController;
  @override
  void initState() {
    _nameController = TextEditingController();
    _heightController = TextEditingController();
    _ageController = TextEditingController();
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
        title: Text('添加球员'),
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
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(20)),
                        child: IconButton(
                          icon: Icon(
                            MdiIcons.cameraAccount,
                            size: 50,
                          ),
                          iconSize: 60,
                          onPressed: () {},
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
                        height: 65,
                        child: TextField(
                          controller: _nameController,
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
                        height: 65,
                        child: TextField(
                          controller: _heightController,
                          decoration: InputDecoration(labelText: '身高'),
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
                        height: 65,
                        child: TextField(
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
            MaterialButton(
              height: 49,
              minWidth: ScreenUtil().getScreenWidth() - 30,
              color: Colors.limeAccent,
              child: Text('保存'),
              onPressed: () async {
                Map data = {
                  'name': _nameController.text,
                  'height': _heightController.text,
                  'age': _heightController.text
                };
                await DataCenter.addAPlayer(data);
                
                Navigator.of(context).pop();
              },
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
