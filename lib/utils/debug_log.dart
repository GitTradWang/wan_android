import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;

///是否在生产环境中
bool inProduction = const bool.fromEnvironment("dart.vm.product");

debug(Object msg, {String tag = 'DEMO', Object error, StackTrace stackTrace, Zone zone = Zone.root, jsonFormat = false}) {
  if (!inProduction) {
    String message;
    if (jsonFormat) {
      message = _convertObject(msg);
    } else {
      message = msg?.toString() ?? 'null';
    }
    developer.log(message, name: tag, level: 0, zone: zone, error: error, stackTrace: stackTrace);
  }
}

String _convertObject(Object message) {
  String result;
  try {
    result = JsonEncoder.withIndent(' ').convert(message);
  } catch (e) {
    result = message.toString();
  }
  return result;
}
