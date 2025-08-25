import 'dart:async';

import 'package:event_bus/event_bus.dart';


class InitEventBus {
  static EventBus eventBus = EventBus();

  static get disposeEvent => eventBus.destroy();
}

class EventBusUtil {
  static EventBus? _eventBus;

  static EventBus getInstance() {
    _eventBus ??= EventBus();
    return _eventBus!;
  }

  static StreamSubscription<T> listen<T>(Function(T event) onData) {
    _eventBus ??= EventBus();
    return _eventBus!.on<T>().listen(onData);
  }

  static void fire<T>(T e) {
    _eventBus ??= EventBus();
    _eventBus?.fire(e);
  }
}
