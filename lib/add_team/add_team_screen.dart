import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sport_score_app/data_center/data_center.dart';
import 'package:sport_score_app/utils/screen_util.dart';
import 'package:sport_score_app/utils/toast.dart';

class AddTeamScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddteamScreenState();
  }
}

class _AddteamScreenState extends State {
  TextEditingController _nameController;
  File _image;

  @override
  void initState() {
    _nameController = TextEditingController();

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
        title: Text('添加球队'),
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
                          this.getImage();
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
            MaterialButton(
              height: 49,
              minWidth: ScreenUtil().getScreenWidth() - 30,
              color: Colors.limeAccent,
              child: Text('保存'),
              onPressed: () async {
                if (_image == null) {
                  Toast.show('请拍摄球对头像');
                  return;
                }
                if (_nameController.text.length == 0) {
                  Toast.show('请填写球对名字');
                  return;
                }
                String path = await _save();
                Map data = {'name': _nameController.text, 'image': path};
                await DataCenter.addATeam(data);
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

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
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
    // if (!file.existsSync()) {
    //   Toast.show('success');
    // }
    return file.path;
  }
}
