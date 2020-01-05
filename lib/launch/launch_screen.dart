import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sport_score_app/utils/screen_util.dart';

class LaunchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.yellow,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/launch_ball.png', width: ScreenUtil().setWidth(100),),
            Image.asset('images/icon-sport.png',width: ScreenUtil().getScreenWidth()/1.5,)
          ],
        ),
      ),
    );
  }
}
