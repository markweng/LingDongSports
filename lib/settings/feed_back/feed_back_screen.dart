import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sport_score_app/utils/screen_util.dart';
import 'package:sport_score_app/utils/toast.dart';

class FeedBackScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FeedBackScreenState();
  }
}

class _FeedBackScreenState extends State {
  TextEditingController ctr;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ctr = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    ctr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('意见反馈'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(15),
              child: Container(
                height: 150,
                child: TextField(
                  maxLines: 10,
                  controller: ctr,
                  decoration: InputDecoration(
                      filled: true,
                      labelText: '请输入您的反馈',
                      
                      labelStyle: TextStyle(color: Colors.grey)),
                ),
              ),
            ),
            MaterialButton(
              height: 49,
              minWidth: ScreenUtil().getScreenWidth() - 30,
              color: Colors.limeAccent,
              child: Text('提交'),
              onPressed: () async {
                if (ctr.text.length > 0) {
                  Toast.show('感谢您的反馈');
                  Timer(Duration(seconds: 1), () {
                    Navigator.of(context).pop();
                  });
                } else {
                  Toast.show('请输入您的反馈');
                }
              },
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
