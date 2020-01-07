import 'package:flutter/material.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AboutUsScreenState();
  }
}

class _AboutUsScreenState extends State {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('关于我们'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Card(
              child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      child: Image.asset(
                        'images/app_logo.png',
                        width: 80,
                        height: 80,
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '       凌动体育是为网球运动者制作的一款记录比赛得分的应用，使用该应用可以记录球员，球队，比赛信息。\n        若使用该应用遇到问题，可以直接在应用内向我们反馈，也可以通过邮箱联系我们。',
                          style: TextStyle(color: Color(0xFF666666)),
                        ),
                      )
                    ],
                  ),
                ),
                Text('邮箱地址: lingdongapp@163.com',
                    style: TextStyle(color: Color(0xFF333333)),),
                    SizedBox(height: 20,)
              ],
            ),
          )),
        ),
      ),
    );
  }
}
