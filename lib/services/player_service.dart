import 'package:tsport_mobile_app/models/player_filter.dart';
import 'package:tsport_mobile_app/utils/custom_client.dart';
import 'dart:convert' show jsonDecode, jsonEncode;
// ignore: depend_on_referenced_packages, implementation_imports
import 'package:http/src/response.dart';
import 'dart:convert';

class PlayerService {
  Future<List<PlayerFilter>> fetchPlayerFilters() async {
    final client = CustomClient({});
    try {
      final response = await client.get(Uri.parse('/players/getall'));

      if (response.statusCode != 200) {
        throw Exception("Error calling get players filters");
      }

      final jsonResponse = await jsonDecode(response.body);

      final List<PlayerFilter> players = jsonResponse
          .map<PlayerFilter>((json) => PlayerFilter.fromJson(json))
          .toList();

      return players;
    } catch (e) {
      throw Exception("Error calling get players filters: $e");
    } finally {
      client.close();
    }
  }
}
