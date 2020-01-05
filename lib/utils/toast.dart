import 'package:fluttertoast/fluttertoast.dart';

class Toast {
  static show(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.TOP,
      timeInSecForIos: 1,
    );
  }
}
