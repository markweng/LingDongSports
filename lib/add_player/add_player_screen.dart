import 'dart:io';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sport_score_app/data_center/data_center.dart';
import 'package:sport_score_app/utils/screen_util.dart';
// import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:sport_score_app/utils/toast.dart';

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
  File _image;
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
                      GestureDetector(
                        onTap: () {
                          this._takePic();
                        },
                        child: Card(
                          clipBehavior: Clip.hardEdge,
                          elevation: 5,
                          child: _image == null
                              ? Icon(
                                  MdiIcons.cameraAccount,
                                  size: 50,
                                )
                              : Image.file(
                                  _image,
                                  width: 60,
                                  height: 60,
                                ),
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
                if (_image == null) {
                  Toast.show('请拍摄球员头像');
                  return;
                }
                if (_nameController.text.length == 0) {
                  Toast.show('请填写球员名字');
                  return;
                }
                if (_heightController.text.length == 0) {
                  Toast.show('请填写球员身高');
                  return;
                }
                if (_ageController.text.length == 0) {
                  Toast.show('请填写球员年龄');
                  return;
                }

                String path = await _save();
                Map data = {
                  'name': _nameController.text,
                  'height': _heightController.text,
                  'age': _ageController.text,
                  'image': path
                };
                print(data.toString());
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

  _takePic() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo),
                title: Text("相册"),
                onTap: () {
                  Navigator.of(context).pop();
                  getImage(0);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera),
                title: Text("相机"),
                onTap: () {
                  Navigator.of(context).pop();
                  getImage(1);
                },
              ),
              SizedBox(
                height: 30,
              )
            ],
          );
        });
  }

  Future getImage(int type) async {
    var image = await ImagePicker.pickImage(
        source: type == 0 ? ImageSource.gallery : ImageSource.camera);
    if (image == null) {
      return;
    }
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: false),
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
        cancelButtonTitle: '取消',
        doneButtonTitle: '完成',
      ),
    );
    setState(() {
      _image = croppedFile;
    });
  }

  Future _save() async {
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String documentsPath = documentsDir.path;
    String path = _image.path;
    List pathArr = path.split('/');
    String lastStr = pathArr.last;
    File file = File('$documentsPath/$lastStr');
    if (!file.existsSync()) {
      file.createSync();
    }
    List<int> imageBytes = await _image.readAsBytes();
    file.writeAsBytesSync(imageBytes);
    if (!file.existsSync()) {
      Toast.show('success');
    }
    return file.path;
  }
}
