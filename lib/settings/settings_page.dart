import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sport_score_app/add_player/add_player_screen.dart';
import 'package:sport_score_app/add_team/add_team_screen.dart';
import 'package:sport_score_app/settings/about/about_us_screen.dart';
import 'package:sport_score_app/settings/feed_back/feed_back_screen.dart';
import 'package:sport_score_app/settings/game_rule/game_rule_screen.dart';
import 'package:sport_score_app/settings/settings_row.dart';
import 'package:sport_score_app/web/web_privacy_policy.dart';
import '../back_drop/flutter_backdrop.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

/// Implementation of Backdrop Widget starts here.

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: FrontPanelModel(FrontPanels.panelOne),
      child: ScopedModelDescendant<FrontPanelModel>(
        builder: (context, _, model) => Backdrop(
          appBarAnimatedLeadingMenuIcon: null,
          appBarTitle: Text('设置'),
          backLayer: BackPanel(),
          toggleFrontLayer: false,
          frontLayer: model.activePanel,
          frontHeader: model.panelTitle(context),
          frontHeaderHeight: 0.5,
          titleVisibleOnPanelClosed: false,
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

enum FrontPanels { panelOne, panelTwo }

class FrontPanelModel extends Model {
  FrontPanels _activePanel;

  FrontPanelModel(this._activePanel);

  FrontPanels get activePanelType => _activePanel;

  Widget panelTitle(BuildContext context) {
    return Container(
      child: Center(child: Container()),
    );
  }

  Widget get activePanel => PanelOne();

  void activate(FrontPanels panel) {
    _activePanel = panel;
    notifyListeners();
  }
}

class PanelOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          SettingsRow(
            title: '添加球员',
            icon: MdiIcons.accountPlusOutline,
            iconColor: Colors.blue,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return AddPlayerScreen();
              }));
            },
          ),
          SettingsRow(
            title: '添加球队',
            icon: MdiIcons.accountMultiplePlusOutline,
            iconColor: Colors.blue[200],
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return AddTeamScreen();
              }));
            },
          ),
          SettingsRow(
            title: '比赛规则',
            icon: MdiIcons.ruler,
            iconColor: Colors.orange,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return GameRuleScreen();
              }));
            },
          ),
          SettingsRow(
            title: '当前版本',
            text: 'v1.0.0',
            icon: MdiIcons.codeTagsCheck,
            iconColor: Colors.grey,
            onTap: () {},
          ),
          SettingsRow(
            title: '意见反馈',
            icon: MdiIcons.waze,
            iconColor: Colors.green,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return FeedBackScreen();
              }));
            },
          ),
          SettingsRow(
            title: '隐私政策',
            icon: MdiIcons.policeBadge,
            iconColor: Colors.red[200],
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return PrivacyPolicyWebScreen(url: 'http://www.sdkhub.top/documents/lingdongsports/privacypolicy.html',);
              }));
            },
          ),
          SettingsRow(
            title: '关于我们',
            icon: MdiIcons.airballoonOutline,
            iconColor: Colors.lightBlueAccent,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return AboutUsScreen();
              }));
            },
          ),
        ],
      ),
    );
  }
}

class BackPanel extends StatefulWidget {
  @override
  _BackPanelState createState() => _BackPanelState();
}

class _BackPanelState extends State<BackPanel> {
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
                    '',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  onPressed: () {
                    model.activate(FrontPanels.panelOne);
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
