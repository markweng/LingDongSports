import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sport_score_app/utils/toast.dart';

class WebScreen extends StatefulWidget {
  final Map data;
  final String url;

  WebScreen({Key key, this.url, this.data}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _WebScreenState(data);
  }
}

class _WebScreenState extends State<WebScreen> {
  final Map data;
  String title = 'Loading...';
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;

  _WebScreenState(this.data);
  var url;
  @override
  void initState() {
    super.initState();
    url = data != null ? data['source'] : '';
    _onStateChanged = flutterWebViewPlugin.onStateChanged
        .listen((WebViewStateChanged state) async {
      if (state.type == WebViewState.finishLoad) {
        String webviewTitle =
            await flutterWebViewPlugin.evalJavascript("window.document.title");
        List strarr = webviewTitle.split('"');
        if (strarr.length > 2) {
          webviewTitle = strarr[1];
        }
        setState(() {
          title = webviewTitle;
        });
      }
    });
    _onHttpError = flutterWebViewPlugin.onHttpError
        .listen((WebViewHttpError state) async {});
  }

  @override
  void dispose() {
    _onStateChanged.cancel();
    _onHttpError.cancel();
    flutterWebViewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    if (data != null) {
      for (var item in data['bottomArr']) {
        var icon = null;
        switch (item['action_type']) {
          case 'Go_Url':
            icon = MdiIcons.home;
            break;
          case 'Go_Refresh':
            icon = MdiIcons.refresh;
            break;
          case 'Go_Forward':
            icon = MdiIcons.arrowRightBoldBox;
            break;
          case 'Go_Back':
            icon = MdiIcons.arrowLeftBoldBox;
            break;
          case 'Go_Clean':
            icon = MdiIcons.cached;
            break;
          default:
        }
        var btn = IconButton(
          icon: Icon(
            icon,
            color: Color(0xFF004747),
            size: 30,
          ),
          color: Colors.black,
          onPressed: () {
            switch (item['action_type']) {
              case 'Go_Url':
                flutterWebViewPlugin.launch(item['action_value']);
                break;
              case 'Go_Refresh':
                flutterWebViewPlugin.launch(url);
                break;
              case 'Go_Back':
                flutterWebViewPlugin.goBack();
                break;
              case 'Go_Forward':
                flutterWebViewPlugin.goForward();
                break;
              case 'Go_Clean':
                flutterWebViewPlugin.clearCache();
                Toast.show('清理缓存');
                break;

              default:
            }
          },
        );
        widgets.add(btn);
      }
    }
    return WebviewScaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.yellow,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: widgets),
      ),
      url: url,
      hidden: true,
      ignoreSSLErrors: true,
      initialChild: Center(
        child: SpinKitDoubleBounce(size: 40.0, color: Colors.blue),
      ),
    );
  }
}
