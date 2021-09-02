part of universal_translator;

class UniversalTranslatorInit extends StatelessWidget {
  /// The path of the desired API.
  final String path;
  
  /// The `header` to make the API access.
  final Map<String, dynamic>? headers;

  /// The accepted HTTP method.
  final HttpMethod method;

  /// The ancestor of all the text to translate.
  final Widget Function() builder;

  /// The duration of the Translate Api cache
  final Duration cacheDuration;

  /// Forces the connection to refresh and erases the cache data
  final bool forceRefresh;

  /// Turn this `true` in case you don't know the `target` device language.
  final bool? automaticDetection;

  /// The language in which the text should appear
  final Locale? translateTo;

  /// The pattern that will be received from the API, this must be trated and 
  /// returned as a translated `String?` to be used normally
  final String? Function(Response response) responsePattern;

  /// The pattern that will be sended to make the request,
  /// `originalText` in this case is the text that will be translated
  /// `translateTo` is the language defined in the parameter above or 
  /// the detected phone language, in case `automaticDetection` is set to [true]
  final Map<String,dynamic> Function(String originalText, Locale translateTo) bodyPattern;

  const UniversalTranslatorInit(this.path,
      {required this.builder,
      required this.bodyPattern,
      required this.responsePattern,
      this.headers,
      this.automaticDetection,
      this.translateTo,
      this.cacheDuration = const Duration(days: 7),
      this.forceRefresh = false,
      this.method = HttpMethod.post})
      : assert(automaticDetection == true || translateTo != null,
            'Please select a language to translate');

  @override
  Widget build(BuildContext context) {
    UniversalTranslatorController.init(this.path, responsePattern, bodyPattern,
        headers: headers,
        translateTo: translateTo,
        automaticDetection: automaticDetection,
        cacheDuration: cacheDuration,
        forceRefresh: forceRefresh,
        method: method);
    return builder();
  }
}
