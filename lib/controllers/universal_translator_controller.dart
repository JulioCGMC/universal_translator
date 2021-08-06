part of universal_translator;

class UniversalTranslatorController {
  static UniversalTranslatorController _instance;
  Locale _deviceLocation;
  String path;
  Map<String,dynamic> Function(String, Locale) _bodyPattern;
  String Function(Response) _responsePattern;
  Map<String, dynamic> _headers;
  HttpMethod _method;
  bool _automaticDetection;
  Locale _translateTo;
  Duration _cacheDuration;

  final UniversalTranslatorRepository _translatorRepository 
    = UniversalTranslatorRepository();

  UniversalTranslatorController._();
  factory UniversalTranslatorController() {
    return _instance;
  }

  static void init(String path, String Function(Response) responsePattern,
    Map<String,dynamic> Function(String, Locale) bodyPattern,
      {bool automaticDetection,
      Map<String, dynamic> headers,
      Locale translateTo,
      @required Duration cacheDuration, @required HttpMethod method}) {
    _instance = UniversalTranslatorController._()
      ..path = path
      .._responsePattern = responsePattern
      .._headers = headers
      .._bodyPattern = bodyPattern
      .._automaticDetection = automaticDetection
      .._cacheDuration = cacheDuration
      .._translateTo = translateTo
      .._method = method;
    var window = WidgetsBinding.instance?.window ?? ui.window;
    _instance._deviceLocation = window.locale;
  }

  Locale get translateTo {
    if (_translateTo != null) return _translateTo;
    if (_automaticDetection == true) {
      return _deviceLocation;
    }
    return Locale("en");
  }

  Future<String> translateText(String text) async =>
      _translatorRepository.translate(
        path: path,
          text: text,
          responsePattern: _responsePattern,
          target: translateTo,
          headers: _headers,
          method: _method,
          bodyPattern: _bodyPattern,
          cacheDuration: _cacheDuration);
}
