import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

const String players = 'PLAYER_LIST';
const String teams = 'TEAM_LIST';
const String records = 'RECORD_LIST';
class DataCenter {
  static addAPlayer(Map data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String strData = convert.jsonEncode(data);
    List list = await DataCenter.getAllPlayer();
    list.add(strData);
    Iterable newList = list.reversed;
    String listStr = convert.jsonEncode(newList.toList());
    await prefs.setString(players, listStr);
  }

  static  getAllPlayer() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String res = prefs.getString(players);
      List list = convert.jsonDecode(res);
      return Future.value(list);
    } catch (e) {
      return Future.value([]);
    }
  }

  static addATeam(Map data) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
    String strData = convert.jsonEncode(data);
    List list = await DataCenter.getAllTeam();
    list.add(strData);
    Iterable newList = list.reversed;
    String listStr = convert.jsonEncode(newList.toList());
    await prefs.setString(teams, listStr);
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

  static addAReacrd(Map data) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
    String strData = convert.jsonEncode(data);
    List list = await DataCenter.getAllReacrd();
    list.add(strData);
    Iterable newList = list.reversed;
    String listStr = convert.jsonEncode(newList.toList());
    await prefs.setString(records, listStr);
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
}
