// ignore: depend_on_referenced_packages
import 'dart:async';
// ignore: depend_on_referenced_packages, implementation_imports
import 'package:http/src/response.dart';
import 'package:tsport_mobile_app/models/pagedresult.dart';
import 'package:tsport_mobile_app/models/shirt.dart';
import 'package:tsport_mobile_app/models/shirt_details.dart';
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

  Future<List<ShirtItem>> fetchShirts(
      int pageKey, int pageSize, List<String> sizes,
      {String sortOption = ""}) async {
    final client = CustomClient({});

    var url = '/shirts?pageNumber=$pageKey&pageSize=$pageSize';

    if (sizes.isNotEmpty) {
      url += '&sizes=';
      for (int i = 0; i < sizes.length; ++i) {
        url += sizes[i].toString();
        if (i != sizes.length - 1) {
          url += '&sizes=';
        }
      }
    }

    switch (sortOption.toLowerCase()) {
      case "giá: cao - thấp":
        url += "&sortColumn=discountPrice&orderByDesc=true";
        break;
      case "giá: thấp - cao":
        url += "&sortColumn=discountPrice&orderByDesc=false";
        break;
      case "mới nhất trước":
        url += "&sortColumn=createdDate&orderByDesc=true";
        break;
      default:
        break;
    }

    final response = await client.get(Uri.parse(url));

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

  Future<ShirtDetails> fetchShirtDetailsById(int shirtId) async {
    final client = CustomClient({});

    final response = await client.get(Uri.parse('/shirts/$shirtId'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      final shirtDetails = ShirtDetails.fromJson(jsonResponse);

      client.close();
      return shirtDetails;
    } else if (response.statusCode == 404) {
      client.close();
      throw Exception('Shirt not found');
    }

    client.close();

    throw Exception('Failed to load shirt details');
  }
}
