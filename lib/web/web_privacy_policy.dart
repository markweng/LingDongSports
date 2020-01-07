import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PrivacyPolicyWebScreen extends StatefulWidget {
  final String url;

  PrivacyPolicyWebScreen({Key key, this.url}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _PrivacyPolicyWebScreenState();
  }
}

class _PrivacyPolicyWebScreenState extends State<PrivacyPolicyWebScreen> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '隐私政策',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF333333),
            fontSize: 18,
          ),
        ),
      ),
      url: widget.url,
      hidden: true,
      ignoreSSLErrors: true,
      initialChild: Center(
        child: SpinKitDoubleBounce(size: 40.0, color: Colors.blue),
      ),
    );
  }
}
