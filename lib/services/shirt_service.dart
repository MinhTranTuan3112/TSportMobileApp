// ignore: depend_on_referenced_packages
import 'dart:async';
// ignore: depend_on_referenced_packages, implementation_imports
import 'package:http/src/response.dart';
import 'package:tsport_mobile_app/models/pagedresult.dart';
import 'package:tsport_mobile_app/models/shirt.dart';
import 'package:tsport_mobile_app/utils/custom_client.dart';
import 'dart:convert'; // Import json decoder
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class ShirtService {
  ShirtService();

  Future<Response> fetchPagedShirts() async {
    final client = CustomClient({});

    final response = await client.get(Uri.parse('/shirts'));

    client.close();

    return response;
  }

  Future<List<ShirtItem>> fetchShirts(int pageKey, int pageSize) async {
    final client = http.Client();

    final response = await client.get(Uri.parse('http://localhost:8080/api/shirts?pageNumber=$pageKey&pageSize=$pageSize'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      final pagedResult =
          PagedResult<ShirtItem>.fromJson(jsonResponse, ShirtItem.fromJson);

      final shirts = pagedResult.items;

      client.close();
      return shirts;
    }

    client.close();

    throw Exception('Failed to load shirts');
  }
}
