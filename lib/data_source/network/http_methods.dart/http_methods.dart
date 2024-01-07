import '../../../flutter_google_maps.dart';

class HttpMethods {
  static final _client = Client();

  static final Map<String, String> _headers = {
    'Content-Type': 'application/json',
  };

  /// GET
  static Future<Response> get({
    String queryParams = "",
    required String uri,
  }) async {
    try {
      Response response = await _client.get(
        Uri.parse(uri + queryParams),
        headers: _headers,
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        throw HttpErrors.fromCode(HttpErrorsEnum.invalidData);
      }
    } on HttpErrors catch (_) {
      throw const HttpErrors();
    }
  }

  /// POST
  static Future<Response> post({
    required Object params,
    required String uri,
  }) async {
    Response response = await _client.post(
      Uri.parse(uri),
      headers: _headers,
      body: params,
    );
    return response;
  }

  /// PUT
  static Future<Response> put({
    required Object params,
    required String uri,
  }) async {
    Response response = await _client.put(
      Uri.parse(uri),
      headers: _headers,
    );
    return response;
  }

  /// PATCH
  static Future<Response> patch({
    required Object params,
    required String uri,
  }) async {
    Response response = await _client.patch(
      Uri.parse(uri),
      headers: _headers,
    );
    return response;
  }

  /// DELETE
  static Future<Response> delete({
    required Object params,
    required String uri,
  }) async {
    Response response = await _client.delete(
      Uri.parse(uri),
      headers: _headers,
    );
    return response;
  }
}
