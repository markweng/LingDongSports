import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SelItemBtn extends StatelessWidget {
  final String title, text;
  final Function onTap;
  const SelItemBtn({Key key, this.text, this.onTap, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(this.title, style: TextStyle(color: Colors.white,fontSize: 15, fontWeight: FontWeight.w500),),
          ],
        ),
        GestureDetector(
      onTap: this.onTap,
      child: Card(
        child: Container(
          width: 100,
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(this.text, style: TextStyle(color: Color(0xFF666666), fontSize: 12),),
              ),
              Icon(
                MdiIcons.arrowRightBoldHexagonOutline,
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
    )
      ],
    );
  }
}
