import 'package:tsport_mobile_app/models/season_filter.dart';
import 'dart:convert' show jsonDecode, jsonEncode;
// ignore: depend_on_referenced_packages, implementation_imports
import 'package:http/src/response.dart';
import 'dart:convert';

import 'package:tsport_mobile_app/utils/custom_client.dart'; // Import json decoder
class SeasonService {

  Future<List<SeasonFilter>> fetchSeasonFilters() async {
    final client = CustomClient({});
    try {
      final response = await client.get(Uri.parse('/seasons/getall'));

      if (response.statusCode != 200) {
        throw Exception("Error calling get seasons filters");
      }

      final jsonResponse = await jsonDecode(response.body);

      final List<SeasonFilter> seasons = jsonResponse
          .map<SeasonFilter>((json) => SeasonFilter.fromJson(json))
          .toList();
      
      return seasons;

    } catch (e) {
      throw Exception("Error calling get seasons filters: $e");
    } finally {
      client.close();
    }
  }
}