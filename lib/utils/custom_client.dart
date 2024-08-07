// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart' show kIsWeb; // Import kIsWeb
// import 'dart:io' show Platform;


class CustomClient extends http.BaseClient {
  final Map<String, String> headers;
  final http.Client _inner = http.Client();
  final String baseUrl; 
  final String deployBaseUrl = "https://tsportapi.azurewebsites.net/api";
  final String localPort = "http://localhost:7091/api";
  //4G: 192.168.126.177
  //Wifi: 192.168.100.4
  //Deploy: https://tsportapi.azurewebsites.net/

   CustomClient(this.headers)
      : baseUrl = kIsWeb ? "http://localhost:8080/api" : "https://tsportapi.azurewebsites.net/api";

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
