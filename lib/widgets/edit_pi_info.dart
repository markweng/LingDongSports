import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sport_score_app/add_player/add_player_screen.dart';
import 'package:sport_score_app/add_rccord/add_record_page.dart';
import 'package:sport_score_app/add_team/add_team_screen.dart';
import 'package:sport_score_app/data_center/data_center.dart';
import 'package:sport_score_app/utils/screen_util.dart';
import 'package:sport_score_app/utils/toast.dart';
import 'package:sport_score_app/widgets/sel_item_btn.dart';
import 'dart:convert' as convert;

class EditPIInfo extends StatefulWidget {
  final bool isSingle;

  const EditPIInfo({Key key, this.isSingle}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _EditPIInfoState(isSingle);
  }
}

class _EditPIInfoState extends State {
  final bool isSingle;

  Map player11, player12, player21, player22, team1, team2;

  _EditPIInfoState(this.isSingle);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
        ),
        height: 500.0,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                '编辑队伍信息',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SelItemBtn(
                    title: '球队1',
                    text: team1 != null ? team1['name'] : '请选择',
                    onTap: () {
                      showTeamDialog(1, team1);
                    },
                  ),
                  SelItemBtn(
                      title: '球队2',
                      text: team2 != null ? team2['name'] : '请选择',
                      onTap: () {
                        showTeamDialog(2, team2);
                      }),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              // EditTeamInfo(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SelItemBtn(
                      title: '球员1',
                      text: player11 != null ? player11['name'] : '请选择',
                      onTap: () {
                        showPlayerDialog(11, player11);
                      }),
                  SelItemBtn(
                      title: '球员1',
                      text: player21 != null ? player21['name'] : '请选择',
                      onTap: () {
                        showPlayerDialog(21, player21);
                      }),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              this.isSingle
                  ? Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SelItemBtn(
                          title: '球员2',
                          text: player12 != null ? player12['name'] : '请选择',
                          onTap: () {
                            showPlayerDialog(12, player12);
                          },
                        ),
                        SelItemBtn(
                          title: '球员2',
                          text: player22 != null ? player22['name'] : '请选择',
                          onTap: () {
                            showPlayerDialog(22, player22);
                          },
                        ),
                      ],
                    ),

              SizedBox(
                height: 30,
              ),
              MaterialButton(
                minWidth: ScreenUtil().getScreenWidth() - 180,
                height: 44,
                color: Colors.limeAccent,
                child: Text('下一步'),
                onPressed: () {
                  if (this.team1 == null) {
                    Toast.show('选择球队1');
                    return;
                  }
                  if (this.team2 == null) {
                    Toast.show('选择球队2');
                    return;
                  }
                  if (this.player11 == null) {
                    Toast.show('选择球员');
                    return;
                  }
                  if (this.player21 == null) {
                    Toast.show('选择球员');
                    return;
                  }
                  if (!this.isSingle) {
                    if (this.player12 == null) {
                      Toast.show('选择球员');
                      return;
                    }
                    if (this.player22 == null) {
                      Toast.show('选择球员');
                      return;
                    }
                  }

                  Map data = {
                    'isSingle': this.isSingle,
                    'team1': this.team1,
                    'team2': this.team2,
                    'player11': this.player11,
                    'player21': this.player21,
                    'player12': this.player12,
                    'player22': this.player22,
                  };
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return AddRecordPage(
                          data: data,
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  showTeamDialog(int index, Map obj) async {
    List allPlayer = await DataCenter.getAllTeam();
    List<Widget> widgets = [];
    for (var i = 0; i < allPlayer.length; i++) {
      String item = allPlayer[i];
      Map obj = convert.jsonDecode(item);
      Function onseld = () {
        switch (index) {
          case 1:
            setState(() {
              team1 = obj;
            });
            break;
          case 2:
            setState(() {
              team2 = obj;
            });
            break;
          default:
        }
      };

      SimpleDialogOption op = SimpleDialogOption(
        onPressed: () {
          onseld();
          Navigator.pop(context);
        },
        child: Row(
          children: <Widget>[
            Icon(MdiIcons.accountGroup),
            SizedBox(
              width: 10,
            ),
            Text(obj['name'])
          ],
        ),
      );
      widgets.add(op);
    }
    if (widgets.length == 0) {
      SimpleDialogOption op = SimpleDialogOption(
        onPressed: () {
          Navigator.pop(context);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return AddTeamScreen();
              },
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                child: Column(
              children: <Widget>[
                Text('你还没有添加球队'),
                SizedBox(
                  height: 15,
                ),
                Card(
                  color: Colors.limeAccent,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Text('去添加'),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ))
          ],
        ),
      );
      widgets.add(op);
    }
    showDialog(
      //展示Dialog的方法
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Row(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('选择球队',
                            style: TextStyle(
                                color: Color(0xFF333333), fontSize: 15)),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return AddTeamScreen();
                            },
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            color: Colors.lime,
                            padding: EdgeInsets.all(5),
                            child: Text('添加',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ), //标题
          titlePadding: EdgeInsets.all(15), //标题的padding值
          children: widgets,
          contentPadding: EdgeInsets.all(10),
        );
      },
    );
  }

  showPlayerDialog(int index, Map obj) async {
    List allPlayer = await DataCenter.getAllPlayer();
    List<Widget> widgets = [];
    for (var i = 0; i < allPlayer.length; i++) {
      String item = allPlayer[i];
      Map obj = convert.jsonDecode(item);
      Function onseld = () {
        switch (index) {
          case 11:
            setState(() {
              player11 = obj;
            });
            break;
          case 12:
            setState(() {
              player12 = obj;
            });
            break;
          case 21:
            setState(() {
              player21 = obj;
            });
            break;
          case 22:
            setState(() {
              player22 = obj;
            });
            break;
          default:
        }
      };

      SimpleDialogOption op = SimpleDialogOption(
        onPressed: () {
          onseld();
          Navigator.pop(context);
        },
        child: Row(
          children: <Widget>[
            Icon(MdiIcons.accountOutline),
            SizedBox(
              width: 10,
            ),
            Text(obj['name'])
          ],
        ),
      );
      widgets.add(op);
    }
    if (widgets.length == 0) {
      SimpleDialogOption op = SimpleDialogOption(
        onPressed: () {
          Navigator.pop(context);
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return AddPlayerScreen();
          }));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                child: Column(
              children: <Widget>[
                Text('你还没有添加球员'),
                SizedBox(
                  height: 15,
                ),
                Card(
                  color: Colors.limeAccent,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Text('去添加'),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ))
          ],
        ),
      );
      widgets.add(op);
    }
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Row(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('选择球队',
                            style: TextStyle(
                                color: Color(0xFF333333), fontSize: 15)),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return AddPlayerScreen();
                            },
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            color: Colors.lime,
                            padding: EdgeInsets.all(5),
                            child: Text('添加',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ), //标题
          titlePadding: EdgeInsets.all(15), //标题的padding值
          children: widgets,
          contentPadding: EdgeInsets.all(10),
        );
      },
    );
  }
}
