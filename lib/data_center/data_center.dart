import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

import 'package:sport_score_app/utils/event_util.dart';

const String players = 'PLAYER_LIST';
const String teams = 'TEAM_LIST';
const String records = 'RECORD_LIST';

class DataCenter {
  static addAPlayer(Map data) async {
    List list = await DataCenter.getAllPlayer();
    int idNO = list.length + 1;
    data['id'] = idNO;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String strData = convert.jsonEncode(data);

    list.add(strData);
    Iterable newList = list.reversed;
    String listStr = convert.jsonEncode(newList.toList());
    await prefs.setString(players, listStr);
    EventBusUtil.getInstance().fire(PageEvent());
  }

  static getAllPlayer() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String res = prefs.getString(players);
      List list = convert.jsonDecode(res);
      return Future.value(list);
    } catch (e) {
      return Future.value([]);
    }
  }
  static delAPlayer(Map data) async{
    List list = await DataCenter.getAllPlayer();
    int idNO = data['id'];
    for (String item in list) {
      Map json = convert.jsonDecode(item);
      if(json['id'] == idNO) {
        list.remove(item);
        break;
      }
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String listStr = convert.jsonEncode(list.toList());
    await prefs.setString(players, listStr);
    EventBusUtil.getInstance().fire(PageEvent());
  }
  static addATeam(Map data) async {
    List list = await DataCenter.getAllTeam();
    int idNO = list.length + 1;
    data['id'] = idNO;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String strData = convert.jsonEncode(data);
    list.add(strData);
    Iterable newList = list.reversed;
    String listStr = convert.jsonEncode(newList.toList());
    await prefs.setString(teams, listStr);

    EventBusUtil.getInstance().fire(PageEvent());
  }

  static getAllTeam() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String res = prefs.getString(teams);
      List list = convert.jsonDecode(res);
      return Future.value(list);
    } catch (e) {
      return Future.value([]);
    }
  }
  static delATeam(Map data) async{
    List list = await DataCenter.getAllTeam();
    int idNO = data['id'];
    for (String item in list) {
      Map json = convert.jsonDecode(item);
      if(json['id'] == idNO) {
        list.remove(item);
        break;
      }
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String listStr = convert.jsonEncode(list.toList());
    await prefs.setString(teams, listStr);
    EventBusUtil.getInstance().fire(PageEvent());
  }
  static addAReacrd(Map data) async {
    List list = await DataCenter.getAllReacrd();
    int idNO = list.length + 1;
    data['id'] = idNO;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String strData = convert.jsonEncode(data);
    list.add(strData);
    Iterable newList = list.reversed;
    String listStr = convert.jsonEncode(newList.toList());
    await prefs.setString(records, listStr);
    EventBusUtil.getInstance().fire(PageEvent());
  }

  static getAllReacrd() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String res = prefs.getString(records);
      List list = convert.jsonDecode(res);
      return Future.value(list);
    } catch (e) {
      return Future.value([]);
    }
  }
   static delAReacrd(Map data) async{
    List list = await DataCenter.getAllReacrd();
    int idNO = data['id'];
    for (String item in list) {
      Map json = convert.jsonDecode(item);
      if(json['id'] == idNO) {
        list.remove(item);
        break;
      }
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String listStr = convert.jsonEncode(list.toList());
    await prefs.setString(records, listStr);
    EventBusUtil.getInstance().fire(PageEvent());
  }
}
