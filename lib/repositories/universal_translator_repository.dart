part of universal_translator;

class UniversalTranslatorRepository {
  Dio _dio = Dio();
  
  UniversalTranslatorRepository() {
    // Set cache data for Dio
    _dio..interceptors.add(DioCacheManager(CacheConfig()).interceptor);
  }

  Future<String?> translate(
      {required String path,
      required String? Function(Response) responsePattern,
      required HttpMethod method,
      required Function(String, Locale) bodyPattern,
      required Map<String, dynamic> headers,
      required Locale target,
      required bool forceRefresh,
      required Duration cacheDuration,
      required String text
    }) async {
    try {
      Response response;
      Map<String, dynamic> body = bodyPattern(text, target);
      Options _head = buildCacheOptions(cacheDuration, forceRefresh: forceRefresh);
      _head.headers = headers;
      
      switch (method) {
        case HttpMethod.get:
          response = await _dio.get(path, 
            queryParameters: body,
            options: _head
          );
        break;
        case HttpMethod.post:
          response = await _dio.post(path, 
            data: body,
            options: _head
          );
        break;
      }
      return responsePattern(response);
    } catch (e) {
      print(e);
    }
    return text;
  }

}
