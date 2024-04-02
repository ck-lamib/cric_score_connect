import 'dart:developer';

class CustomLogger {
  static trace(Object? message, {Object? error}) {
    log("".padLeft(15, "<<=>>"));
    log(
      message.toString(),
      error: error,
    );
    log("".padLeft(15, "<<=>>"));
  }
}
