import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sport_score_app/data_center/data_center.dart';
import 'package:sport_score_app/playgrount/edit_team_info.dart';
import 'package:sport_score_app/utils/toast.dart';

class AddRecordPage extends StatefulWidget {
  final Map data;
  const AddRecordPage({Key key, this.data}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddRecordPageState(data);
  }
}

class _AddRecordPageState extends State {
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

  _AddRecordPageState(this.data);
  @override
  void initState() {
    super.initState();
    var today = DateTime.now();
    setState(() {
      date =
          '${today.year.toString()}-${today.month.toString()}-${today.day.toString()} ${today.hour.toString()}:${today.minute.toString()}:${today.second.toString()}';
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
              '保存',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            onPressed: () {
              if (this.player11Score == 0 &&
                  this.player12Score == 0 &&
                  this.player21Score == 0 &&
                  this.player21Score == 0) {
                Toast.show('你还没有记录，不需要保存');
                return;
              }
              Map data = {
                'date': this.date,
                'team1Score': this.team1Score,
                'team2Score': this.team2Score,
                'player11Score': this.player11Score,
                'player12Score': this.player12Score,
                'player21Score': this.player21Score,
                'player22Score': this.player22Score,
                'isSingle': this.data['isSingle']
              };
              DataCenter.addAReacrd(data);
              Toast.show('保存成功');
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MaterialButton(
                      child: Row(
                        children: <Widget>[
                          Icon(MdiIcons.undoVariant),
                          Text('回退')
                        ],
                      ),
                      onPressed: () {
                        if (this.hisRoad.length > 1) {
                          this.hisRoad.removeLast();
                          Map last = this.hisRoad.last;
                          setState(() {
                            hisRoad = this.hisRoad;
                            date = last['date'];
                            team1Score = last['team1Score'];
                            team2Score = last['team2Score'];
                            player11Score = last['player11Score'];
                            player12Score = last['player12Score'];
                            player21Score = last['player21Score'];
                            player22Score = last['player22Score'];
                            team1ShowClockScore = last['team1ShowClockScore'];
                            team2ShowClockScore = last['team2ShowClockScore'];
                          });
                        } else {
                          setState(() {
                            hisRoad = [];
                            team1Score = 0;
                            team2Score = 0;
                            player11Score = 0;
                            player12Score = 0;
                            player21Score = 0;
                            player22Score = 0;
                            team1ShowClockScore = 0;
                            team2ShowClockScore = 0;
                          });
                        }
                      },
                    ),
                    MaterialButton(
                      child: Row(
                        children: <Widget>[Icon(MdiIcons.refresh), Text('重置')],
                      ),
                      onPressed: () {
                        var today = DateTime.now();
                        String dates =
                            '${today.year.toString()}-${today.month.toString()}-${today.day.toString()} ${today.hour.toString()}:${today.minute.toString()}:${today.second.toString()}';

                        setState(() {
                          hisRoad = [];
                          date = dates;
                          team1Score = 0;
                          team2Score = 0;
                          player11Score = 0;
                          player12Score = 0;
                          player21Score = 0;
                          player22Score = 0;
                          team1ShowClockScore = 0;
                          team2ShowClockScore = 0;
                        });
                      },
                    ),
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
                        team1ShowClockScore),
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
                        team2ShowClockScore),
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
                SizedBox(height: 8,),
                Text(
                  '提示：点击球员来增加得分',
                  style: TextStyle(color: Color(0xFF999999), fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }

  Widget _buildProfileItem1(
    String teamName,
    image,
    player1,
    player2,
    score,
  ) {
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
              Container(
                width: 60,
                height: 40,
                color: Colors.grey[300],
                child: Center(
                  child: Text(
                    score.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        team1Score = team1ShowClockScore == 40
                            ? team1Score + 1
                            : team1Score;
                        int score = team1ShowClockScore == 15
                            ? 30
                            : team1ShowClockScore == 30
                                ? 40
                                : team1ShowClockScore == 0 ? 15 : 0;
                        team1ShowClockScore = score;
                        player11Score++;
                      });
                      Map data = {
                        'date': this.date,
                        'team1Score': this.team1Score,
                        'team2Score': this.team2Score,
                        'player11Score': this.player11Score,
                        'player12Score': this.player12Score,
                        'player21Score': this.player21Score,
                        'player22Score': this.player22Score,
                        'team1ShowClockScore': this.team1ShowClockScore,
                        'team2ShowClockScore': this.team2ShowClockScore,
                      };
                      this.hisRoad.add(data);
                    },
                    child: Row(
                      children: <Widget>[
                        Card(
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 30,
                                height: 30,
                                color: Colors.grey[300],
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
                            onTap: () {
                              setState(
                                () {
                                  team1Score = team1ShowClockScore == 40
                                      ? team1Score + 1
                                      : team1Score;
                                  int score = team1ShowClockScore == 15
                                      ? 30
                                      : team1ShowClockScore == 30
                                          ? 40
                                          : team1ShowClockScore == 0 ? 15 : 0;
                                  team1ShowClockScore = score;
                                  player12Score++;
                                },
                              );
                              Map data = {
                                'date': this.date,
                                'team1Score': this.team1Score,
                                'team2Score': this.team2Score,
                                'player11Score': this.player11Score,
                                'player12Score': this.player12Score,
                                'player21Score': this.player21Score,
                                'player22Score': this.player22Score,
                                'team1ShowClockScore': this.team1ShowClockScore,
                                'team2ShowClockScore': this.team2ShowClockScore,
                              };
                              this.hisRoad.add(data);
                            },
                            child: Row(
                              children: <Widget>[
                                Card(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 30,
                                        height: 30,
                                        color: Colors.grey[300],
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
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
    String teamName,
    image,
    player1,
    player2,
    score,
  ) {
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
              Container(
                width: 60,
                height: 40,
                color: Colors.grey[300],
                child: Center(
                  child: Text(
                    score.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          team2Score = team2ShowClockScore == 40
                              ? team2Score + 1
                              : team2Score;
                          int score = team2ShowClockScore == 15
                              ? 30
                              : team2ShowClockScore == 30
                                  ? 40
                                  : team2ShowClockScore == 0 ? 15 : 0;
                          team2ShowClockScore = score;
                          player21Score++;
                        });
                        Map data = {
                          'date': this.date,
                          'team1Score': this.team1Score,
                          'team2Score': this.team2Score,
                          'player11Score': this.player11Score,
                          'player12Score': this.player12Score,
                          'player21Score': this.player21Score,
                          'player22Score': this.player22Score,
                          'team1ShowClockScore': this.team1ShowClockScore,
                          'team2ShowClockScore': this.team2ShowClockScore,
                        };
                        this.hisRoad.add(data);
                      },
                      child: Row(
                        children: <Widget>[
                          Card(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 30,
                                  height: 30,
                                  color: Colors.grey[300],
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
                            onTap: () {
                              setState(() {
                                team2Score = team2ShowClockScore == 40
                                    ? team2Score + 1
                                    : team2Score;
                                int score = team2ShowClockScore == 15
                                    ? 30
                                    : team2ShowClockScore == 30
                                        ? 40
                                        : team2ShowClockScore == 0 ? 15 : 0;
                                team2ShowClockScore = score;
                                player22Score++;
                              });
                              Map data = {
                                'date': this.date,
                                'team1Score': this.team1Score,
                                'team2Score': this.team2Score,
                                'player11Score': this.player11Score,
                                'player12Score': this.player12Score,
                                'player21Score': this.player21Score,
                                'player22Score': this.player22Score,
                                'team1ShowClockScore': this.team1ShowClockScore,
                                'team2ShowClockScore': this.team2ShowClockScore,
                              };
                              this.hisRoad.add(data);
                            },
                            child: Row(
                              children: <Widget>[
                                Card(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 30,
                                        height: 30,
                                        color: Colors.grey[300],
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
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
