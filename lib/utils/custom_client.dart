// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import 'dart:io' show Platform;


class CustomClient extends http.BaseClient {
  final Map<String, String> headers;
  final http.Client _inner = http.Client();
  final String baseUrl;

   CustomClient(this.headers)
      : baseUrl = Platform.isAndroid ? "http://192.168.100.4:8080/api" : "http://localhost:8080/api";

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final newUri = Uri.parse("$baseUrl${request.url}");

    final newRequest = http.Request(request.method, newUri)
      ..headers.addAll(headers)
      ..headers.addAll(request.headers)
      ..headers['Content-Type'] = 'application/json';

    final byteStream = request.finalize();
    await byteStream.forEach((bytes) {
      newRequest.bodyBytes = bytes;
    });

    //Same as
    // newRequest.headers.addAll(request.headers);
    // newRequest.headers.addAll(headers);

    return _inner.send(newRequest);
  }
}
