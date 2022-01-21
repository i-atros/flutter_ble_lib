part of internal;

mixin LogLevelMixin on FlutterBLE {
  Future<void> setLogLevel(LogLevel logLevel) async {
    print("set log level to ${describeEnum(logLevel)}");
    return await _methodChannel.invokeMethod(
      MethodName.setLogLevel,
      <String, dynamic>{
        ArgumentName.logLevel: describeEnum(logLevel),
      },
    ).catchError((errorJson) =>
        Future.error(BleError.fromJson(jsonDecode(errorJson.details))));
  }

  Future<LogLevel> logLevel() async {
    String logLevelName =
        await _methodChannel.invokeMethod(MethodName.logLevel);
    return _logLevelFromString(logLevelName);
  }

  LogLevel _logLevelFromString(String logLevelName) {
    print("try to get log level from: $logLevelName");
    return LogLevel.values.firstWhere(
        (e) => e.toString() == 'LogLevel.' + logLevelName.toLowerCase());
  }
}
