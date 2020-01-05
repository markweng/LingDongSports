import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SelItemDailog extends StatelessWidget {
  final List data;

  const SelItemDailog({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Container(
        // color: Colors.brown,
        padding: EdgeInsets.only(bottom: 30),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: RaisedButton(
            child: Text(data.toString()),
            onPressed: () => {Navigator.of(context).pop('')},
          ),
        ),
      ),
    );
  }
}
