import 'package:flutter/material.dart';

class GameRuleScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GameRuleScreenState();
  }
}

class _GameRuleScreenState extends State {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('比赛规则'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(15),
              child: Container(
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Text(
                      '基本规则\n一、发球\n1、发球前的规定发球员在发球前应先站在端线后、中点和边线的假定延长线之间的区域里，用手将球向空中任何方向抛起，在球接触地面以前，用球拍击球。球拍接触球时，就算完成发球。\n2、发球时的规定发球员在整个发球动作中，不得通过行走或跑动改变原站的位置；两脚只准站在规定位置，不得触及其它区域。\n3、发球员的位置每局开始，先从右区端线后发球，得或失一分后，应换到左　区发球。发出的球应从网上越过，落到对面的对方发球区内，或其周　围线内。\n4、发球失误未击中球；发出的球，在落地前触及固定物（球网、中心带和网边白布除外）；违反发球站位的规定。发球有两次发球权。发球失误后，应在原发球位置进行第二次发球。\n5、发球无效发球触网后，仍然落到对方发球区内；接球员未作好接球准备；均应重发球。\n6、交换发球每局比赛终了，交换发球权。\n二、交换场地双方应在每盘的第1、3、5等单数局结束后，以及每盘结束双方局数之和为单数时交换场地。\n\n双打规则\n1、双打发球次序每盘第一局开始时，由发球方决定由何人首先发球，对方则同样地在第2局开始时定由何人首先发球。第3局由第1局发球方的另一球员发球。第4局由第2局发球方的另一球员发球，以下各局均按此次序发球。\n2、双方按发球次序接发球次序与发球相同，但同伴间应在每局中轮流接发球。\n3、双打还击接发球后，双方应轮流由其中任何一名队员还击。如运动员在其同队队员击球后，再以球拍触球，则判对方得分。'),
                      
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
