import 'package:flutter_demo/base/event/event.dart';
import 'package:flutter_demo/base/event/http_error_event.dart';

class Code {
  static const NETWORK_ERROR = -1;
  static const NETWORK_TIMEOUT = -2;
  static const NETWORK_JSON_EXCEPTION = -3;
  static const GITHUB_API_REFUSED = -4;

  static const SUCCESS = 200;

  static errorHandleFunction(int code, message, noTip) {
    if (noTip) {
      return message;
    }
    if (message != null &&
        message is String &&
        (message.contains("Connection refused"))) {
      code = GITHUB_API_REFUSED;
    }
    eventBus.fire(HttpErrorEvent(code, message));
    return message;
  }
}
