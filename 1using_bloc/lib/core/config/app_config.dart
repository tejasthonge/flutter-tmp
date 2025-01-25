enum Flavor {
  // ignore: constant_identifier_names
  Development,

  // ignore: constant_identifier_names
  Production,

  // ignore: constant_identifier_names
  Uat,
}

class AppConfig {
  String appName = '';
  Flavor flavorName = Flavor.Development;
  String apiBaseUrl = '';

  static final AppConfig _singleton = AppConfig._internal();
  AppConfig._internal();
  factory AppConfig() => _singleton;

  initConfig({required String appName, required Flavor flavorName, required String apiBaseUrl}) {
    _singleton.appName = appName;
    _singleton.flavorName = flavorName;
    _singleton.apiBaseUrl = apiBaseUrl;
  }

  String get title {
    return appName;
  }

  bool get isDebug {
    switch (flavorName) {
      case Flavor.Production:
        return false;
      case Flavor.Development:
        return false;
      case Flavor.Uat:
        return false;
      default:
        return true;
    }
  }
}
