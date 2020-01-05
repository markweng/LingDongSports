import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sport_score_app/utils/screen_util.dart';

class EditTeamInfo extends StatelessWidget {
  final int scoreLeft, scoreRight;

  const EditTeamInfo({Key key, this.scoreLeft, this.scoreRight}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      padding: EdgeInsets.all(2),
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.green[300],
            height: (ScreenUtil().getScreenWidth() - 30) *
                8.23 /
                23.77 *
                1.37 /
                10.97,
            width: ScreenUtil().getScreenWidth() - 30,
            child: Row(children: <Widget>[
              Expanded(
                child: Row(),
              )
            ]),
          ),
          SizedBox(
            height: 2,
          ),
          Container(
            height: (ScreenUtil().getScreenWidth() - 30) * 8.23 / 23.77,
            width: ScreenUtil().getScreenWidth() - 30,
            child: Row(children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.green[200],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(this.scoreLeft < 10 ? '0${this.scoreLeft.toString()}' : this.scoreLeft.toString(), style: TextStyle(color: Colors.white, fontSize: 40,fontWeight: FontWeight.w700),),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 2,
              ),
              _buildLeft(),
              SizedBox(
                width: 2,
              ),
              _buildRight(),
              SizedBox(
                width: 2,
              ),
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.green[200],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(this.scoreRight < 10 ? '0${this.scoreRight.toString()}' : this.scoreRight.toString(), style: TextStyle(color: Colors.white, fontSize: 40,fontWeight: FontWeight.w700),)
                    ],
                  ),
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 2,
          ),
          Container(
            color: Colors.green[300],
            height: (ScreenUtil().getScreenWidth() - 30) *
                8.23 /
                23.77 *
                1.37 /
                10.97,
            width: ScreenUtil().getScreenWidth() - 30,
            child: Row(children: <Widget>[
              Expanded(
                child: Row(),
              )
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildLeft() {
    return Expanded(
      flex: 3,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.green[300],
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Expanded(
            child: Container(
              color: Colors.green[300],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRight() {
    return Expanded(
      flex: 3,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.green[300],
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Expanded(
            child: Container(
              color: Colors.green[300],
            ),
          )
        ],
      ),
    );
  }
}
