
import 'package:event_bus/event_bus.dart';
import 'package:sport_score_app/settings/settings_page.dart';
export 'dart:async';
class EventBusUtil {
  static EventBus _eventBus;
 
  static EventBus getInstance() {
    if (_eventBus == null) {
      _eventBus = new EventBus();
    }
    return _eventBus;
  }
 
 
}
 
class PageEvent{
  PageEvent();
}

class PanelEvent{
  int panel;
  PanelEvent(this.panel);
}