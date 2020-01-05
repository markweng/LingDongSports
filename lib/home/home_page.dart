import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sport_score_app/data_center/data_center.dart';
import '../back_drop/flutter_backdrop.dart';
import 'dart:convert' as convert;

bool _toggleFrontLayer = false;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

/// Implementation of Backdrop Widget starts here.

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: FrontPanelModel(FrontPanels.panelOne),
      child: ScopedModelDescendant<FrontPanelModel>(
        builder: (context, _, model) => Backdrop(
          appBarAnimatedLeadingMenuIcon: AnimatedIcons.close_menu,
          appBarTitle: Text('灵动体育'),
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
  FrontPanels _activePanel;

  FrontPanelModel(this._activePanel);
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

  Widget get activePanel => _activePanel == FrontPanels.panelOne
      ? PanelOne(
          data: _data1,
        )
      : _activePanel == FrontPanels.panelTwo ? PanelTwo(
          data: _data2,
        ) : PanelThree(data: _data3,);

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
  // List records = DataCenter.getAllReacrd();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: new EdgeInsets.all(5.0),
      itemExtent: 100.0,
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        // String dataStr = records[index];
        // Map data = convert.jsonDecode(dataStr);
        return Card(
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
                      width: 80,
                      child: Text('data'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      color: Colors.yellow,
                      width: 60,
                      height: 60,
                    )
                  ],
                ),
                Text('10 : 10'),
                Row(
                  children: <Widget>[
                    Container(
                      color: Colors.yellow,
                      width: 60,
                      height: 60,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 80,
                      child: Text('data'),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class PanelTwo extends StatelessWidget {
  final List data;

  const PanelTwo({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List list = DataCenter.getAllPlayer();
    return ListView.builder(
      padding: new EdgeInsets.all(5.0),
      itemExtent: 100.0,
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        // String dataStr = records[index];
        // Map data = convert.jsonDecode(dataStr);
        return Card(
          child: Container(
            height: 80,
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      color: Colors.yellow,
                      width: 60,
                      height: 60,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('data'),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

}
class PanelThree extends StatelessWidget {
  final List data;

  const PanelThree({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List list = DataCenter.getAllPlayer();
    return ListView.builder(
      padding: new EdgeInsets.all(5.0),
      itemExtent: 100.0,
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        // String dataStr = records[index];
        // Map data = convert.jsonDecode(dataStr);
        return Card(
          child: Container(
            height: 80,
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      color: Colors.yellow,
                      width: 60,
                      height: 60,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('data'),
                  ],
                )
              ],
            ),
          ),
        );
      },
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
                    model.activate(FrontPanels.panelOne, data1, data2,data3);
                    _toggleFrontLayer = true;
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
