import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SettingsRow extends StatelessWidget {
  final IconData icon;
  final String title, text;
  final Function onTap;
  final Color iconColor;

  const SettingsRow({Key key, this.icon, this.title, this.text, this.onTap, this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.only(left: 15, right: 15, top: 10),
        child: GestureDetector(
          onTap: this.onTap,
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(this.icon,color: this.iconColor,),
                    SizedBox(width: 10,),
                    Text(this.title, style: TextStyle(color: Color(0xFF333333)),),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(this.text ?? '', style: TextStyle(color: Colors.grey[500]),),
                    SizedBox(width: 10,),
                    Icon(MdiIcons.chevronRight,color: Colors.grey,)
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
