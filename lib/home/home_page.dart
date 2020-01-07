import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sport_score_app/add_player/add_player_screen.dart';
import 'package:sport_score_app/add_player/look_player_screen.dart';
import 'package:sport_score_app/add_rccord/look_reaord_screen.dart';
import 'package:sport_score_app/add_team/add_team_screen.dart';
import 'package:sport_score_app/add_team/look_team_screen.dart';
import 'package:sport_score_app/data_center/data_center.dart';
import 'package:sport_score_app/utils/event_util.dart';
import '../back_drop/flutter_backdrop.dart';
import 'dart:convert' as convert;

bool _toggleFrontLayer = false;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

/// Implementation of Backdrop Widget starts here.

class _HomePageState extends State<HomePage> {
  StreamSubscription<PageEvent> sss;
  StreamSubscription<PanelEvent> sss1;

  var _data1 = [];
  var _data2 = [];
  var _data3 = [];
  FrontPanels frontPanel = FrontPanels.panelOne;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();

    sss = EventBusUtil.getInstance().on<PageEvent>().listen((data) {
      _getData();
    });
    sss1 = EventBusUtil.getInstance().on<PanelEvent>().listen((panel) {
      switch (panel.panel) {
        case 0:
          frontPanel = FrontPanels.panelOne;
          break;
        case 1:
          frontPanel = FrontPanels.panelTwo;
          break;
        case 2:
          frontPanel = FrontPanels.panelThree;
          break;
        default:
      }
    });
  }

  _getData() async {
    List players = await DataCenter.getAllPlayer();
    List teams = await DataCenter.getAllTeam();
    List records = await DataCenter.getAllReacrd();

    setState(() {
      _data1 = records == null ? [] : records;
      _data2 = players == null ? [] : players;
      _data3 = teams == null ? [] : teams;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: FrontPanelModel(frontPanel, _data1, _data2, _data3),
      child: ScopedModelDescendant<FrontPanelModel>(
        builder: (context, _, model) => Backdrop(
          appBarAnimatedLeadingMenuIcon: AnimatedIcons.close_menu,
          appBarTitle: Text('凌动体育'),
          backLayer: BackPanel(),
          toggleFrontLayer: _toggleFrontLayer,
          frontLayer: model.activePanel,
          frontHeader: model.panelTitle(context),
          frontHeaderHeight: 35.0,
          titleVisibleOnPanelClosed: true,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
      ),
    );
  }
}

/// Creation of Model Class to be used for changing frontLayer
/// as well as on clicking of any option on backLayer

enum FrontPanels { panelOne, panelTwo, panelThree }

class FrontPanelModel extends Model {
  final List list1, list2, list3;

  FrontPanels _activePanel;

  FrontPanelModel(this._activePanel, this.list1, this.list2, this.list3);
  var _data1 = [];
  var _data2 = [];
  var _data3 = [];
  FrontPanels get activePanelType => _activePanel;

  Widget panelTitle(BuildContext context) {
    return Container(
      child: Center(
        child: _activePanel == FrontPanels.panelOne
            ? Text('比赛记录')
            : _activePanel == FrontPanels.panelTwo
                ? Text('所有球员')
                : Text('所有球队'),
      ),
    );
  }

  Widget get activePanel {
    _data1 = list1;
    _data2 = list2;
    _data3 = list3;
    return _activePanel == FrontPanels.panelOne
        ? PanelOne(
            data: _data1,
          )
        : _activePanel == FrontPanels.panelTwo
            ? PanelTwo(
                data: _data2,
              )
            : PanelThree(
                data: _data3,
              );
  }

  void activate(FrontPanels panel, List data1, data2, data3) {
    _data1 = data1;
    _data2 = data2;
    _data3 = data3;
    _activePanel = panel;
    notifyListeners();
  }
}

class PanelOne extends StatelessWidget {
  final List data;
  const PanelOne({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return data.length > 0
        ? ListView.builder(
            padding: new EdgeInsets.all(5.0),
            itemExtent: 100.0,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              Map item = convert.jsonDecode(data[index]);
              print(item.toString());
              return GestureDetector(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return LookRecordScreen(data: item,);
                      }
                    )
                  );
                },
                child: Card(
                  child: Container(
                    height: 80,
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                item['team1']['name'],
                                style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Card(
                              elevation: 3,
                              clipBehavior: Clip.hardEdge,
                              child: Image.file(
                                File(
                                  item['team1']['image'],
                                ),
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${item['team1Score'].toString()} : ${item['team2Score'].toString()}',
                          style: TextStyle(
                              color: Color(0xFF666666),
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: <Widget>[
                            Card(
                              elevation: 3,
                              clipBehavior: Clip.hardEdge,
                              child: Image.file(
                                File(
                                  item['team2']['image'],
                                ),
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              child: Text(
                                item['team2']['name'],
                                style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        : Center(
            child: Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Card(
                  elevation: 5,
                  child: Image.asset(
                    'images/tennis_bg.jpg',
                    height: 80,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '暂无比赛记录,\n可以试着点击下面🎾可以添加记录',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF999999)),
                ),
              ],
            )),
          );
  }
}

class PanelTwo extends StatelessWidget {
  final List data;

  const PanelTwo({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return data.length > 0
        ? ListView.builder(
            padding: new EdgeInsets.all(5.0),
            itemExtent: 100.0,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              Map item = convert.jsonDecode(data[index]);
              return GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return LookPlayerScreen(data: item);
                  }));
                },
                child: Card(
                  child: Container(
                    height: 80,
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Card(
                              elevation: 3,
                              clipBehavior: Clip.hardEdge,
                              child: Image.file(
                                File(
                                  item['image'],
                                ),
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              item['name'],
                              style: TextStyle(
                                  color: Color(0xFF666666), fontSize: 18),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        : Center(
            child: Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Card(
                  elevation: 5,
                  child: Image.asset(
                    'images/tennis_player.jpg',
                    height: 80,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '暂无球员记录',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF999999)),
                ),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  color: Colors.lime,
                  child: Text(
                    '去添加',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return AddPlayerScreen();
                    }));
                  },
                )
              ],
            )),
          );
  }
}

class PanelThree extends StatelessWidget {
  final List data;
  const PanelThree({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return data.length > 0
        ? ListView.builder(
            padding: new EdgeInsets.all(5.0),
            itemExtent: 100.0,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              Map item = convert.jsonDecode(data[index]);
              return GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return LookTeamScreen(
                      data: item,
                    );
                  }));
                },
                child: Card(
                  child: Container(
                    height: 80,
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Card(
                              elevation: 5,
                              clipBehavior: Clip.hardEdge,
                              child: Image.file(
                                File(
                                  item['image'],
                                ),
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              item['name'],
                              style: TextStyle(
                                  color: Color(0xFF666666), fontSize: 18),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        : Center(
            child: Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Card(
                  elevation: 5,
                  child: Image.asset(
                    'images/tennis_bg.jpg',
                    height: 80,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '暂无球队记录',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF999999)),
                ),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  color: Colors.lime,
                  child: Text(
                    '去添加',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return AddTeamScreen();
                    }));
                  },
                )
              ],
            )),
          );
  }
}

class BackPanel extends StatefulWidget {
  @override
  _BackPanelState createState() => _BackPanelState();
}

class _BackPanelState extends State<BackPanel> {
  List data1 = [];
  List data2 = [];
  List data3 = [];
  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    List players = await DataCenter.getAllPlayer();
    List teams = await DataCenter.getAllTeam();
    List records = await DataCenter.getAllReacrd();

    setState(() {
      data1 = records == null ? [] : records;
      data2 = players == null ? [] : players;
      data3 = teams == null ? [] : teams;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Container(
        margin: EdgeInsets.only(top: 16.0),
        child: ListView(
          itemExtent: 70.0,
          children: <Widget>[
            ScopedModelDescendant<FrontPanelModel>(
              rebuildOnChange: false,
              builder: (context, _, model) {
                return FlatButton(
                  child: Text(
                    '所有比赛',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  onPressed: () async {
                    await _getData();
                    model.activate(FrontPanels.panelOne, data1, data2, data3);
                    _toggleFrontLayer = true;
                    EventBusUtil.getInstance().fire(PanelEvent(0));
                  },
                );
              },
            ),
            ScopedModelDescendant<FrontPanelModel>(
              rebuildOnChange: false,
              builder: (context, _, model) {
                return FlatButton(
                  child: Text(
                    '所有球员',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  onPressed: () async {
                    await _getData();
                    model.activate(FrontPanels.panelTwo, data1, data2, data3);
                    _toggleFrontLayer = true;
                    EventBusUtil.getInstance().fire(PanelEvent(1));
                  },
                );
              },
            ),
            ScopedModelDescendant<FrontPanelModel>(
              rebuildOnChange: false,
              builder: (context, _, model) {
                return FlatButton(
                  child: Text(
                    '所有球队',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  onPressed: () async {
                    await _getData();
                    model.activate(FrontPanels.panelThree, data1, data2, data3);
                    _toggleFrontLayer = true;
                    EventBusUtil.getInstance().fire(PanelEvent(2));
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
