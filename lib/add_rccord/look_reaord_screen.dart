import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sport_score_app/data_center/data_center.dart';
import 'package:sport_score_app/playgrount/edit_team_info.dart';
import 'package:sport_score_app/utils/toast.dart';

class LookRecordScreen extends StatefulWidget {
  final Map data;
  const LookRecordScreen({Key key, this.data}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LookRecordScreenState(data);
  }
}

class _LookRecordScreenState extends State {
  final Map data;
  List hisRoad = [];
  String date = '';
  int team1Score = 0;
  int team2Score = 0;
  int player11Score = 0;
  int player12Score = 0;
  int player21Score = 0;
  int player22Score = 0;
  int team1ShowClockScore = 0;
  int team2ShowClockScore = 0;

  _LookRecordScreenState(this.data);
  @override
  void initState() {
    super.initState();
    var today = DateTime.now();
    setState(() {
      date = data['date'];
      team1Score = data['team1Score'];
      team2Score = data['team2Score'];
      player11Score = data['player11Score'];
      player12Score = data['player12Score'];
      player21Score = data['player21Score'];
      player22Score = data['player22Score'];
      team1ShowClockScore = data['team1ShowClockScore'];
      team2ShowClockScore = data['team2ShowClockScore'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('记录比赛'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              '删除',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            onPressed: () {
              DataCenter.delATeam(data);
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[Image.asset('images/play_tennis.png')],
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    EditTeamInfo(scoreLeft: team1Score, scoreRight: team2Score),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 15,
                    ),
                    _buildProfileItem1(
                      this.data['team1']['name'],
                      '',
                      this.data['player11']['name'],
                      this.data['player12'] != null
                          ? this.data['player12']['name']
                          : '',
                      team1ShowClockScore,
                      this.data['player11']['image'],
                      this.data['player12'] != null
                          ? this.data['player12']['image']
                          : '',
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    _buildProfileItem2(
                      this.data['team2']['name'],
                      '',
                      this.data['player21']['name'],
                      this.data['player22'] != null
                          ? this.data['player22']['name']
                          : '',
                      team2ShowClockScore,
                      this.data['player21']['image'],
                      this.data['player22'] != null
                          ? this.data['player22']['image']
                          : '',
                    ),
                    SizedBox(
                      width: 15,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  date,
                  style: TextStyle(color: Color(0xFF666666), fontSize: 15),
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }

  Widget _buildProfileItem1(
      String teamName, image, player1, player2, score, image1, image2) {
    return Expanded(
      child: Card(
        elevation: 5,
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              // Image.asset('name',width: 80,height: 80,),

              Text(
                teamName,
                style: TextStyle(
                    color: Colors.red[400],
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
              SizedBox(
                height: 15,
              ),
             
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    child: Row(
                      children: <Widget>[
                        Card(
                          child: Row(
                            children: <Widget>[
                              Card(
                                clipBehavior: Clip.hardEdge,
                                child: Image.file(
                                  File(image1),
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(player1,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15)),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                        Card(
                          child: Container(
                            height: 30,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              this.player11Score.toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              this.data['isSingle'] != true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                            child: Row(
                          children: <Widget>[
                            Card(
                              child: Row(
                                children: <Widget>[
                                  Card(
                                    clipBehavior: Clip.hardEdge,
                                    child: Image.file(
                                      File(image2),
                                      width: 30,
                                      height: 30,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(player2,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              child: Container(
                                height: 30,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  this.player12Score.toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            )
                          ],
                        ))
                      ],
                    )
                  : Container(),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileItem2(
      String teamName, image, player1, player2, score, image1, image2) {
    return Expanded(
      child: Card(
        elevation: 5,
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Text(
                teamName,
                style: TextStyle(
                    color: Colors.red[400],
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
              SizedBox(
                height: 15,
              ),
             
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                      child: Row(
                    children: <Widget>[
                      Card(
                        child: Row(
                          children: <Widget>[
                            Card(
                              clipBehavior: Clip.hardEdge,
                              child: Image.file(
                                File(image1),
                                width: 30,
                                height: 30,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(player1,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15)),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                      Card(
                        child: Container(
                          height: 30,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            this.player21Score.toString(),
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      )
                    ],
                  ))
                ],
              ),
              SizedBox(
                height: 15,
              ),
              this.data['isSingle'] != true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                            child: Row(
                          children: <Widget>[
                            Card(
                              child: Row(
                                children: <Widget>[
                                  Card(
                                    clipBehavior: Clip.hardEdge,
                                    child: Image.file(
                                      File(image2),
                                      width: 30,
                                      height: 30,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(player2,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              child: Container(
                                height: 30,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  this.player22Score.toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            )
                          ],
                        ))
                      ],
                    )
                  : Container(),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
