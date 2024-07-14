import 'package:tsport_mobile_app/models/club_filter.dart';
import 'package:tsport_mobile_app/utils/custom_client.dart';
import 'dart:convert' show jsonDecode, jsonEncode;
// ignore: depend_on_referenced_packages, implementation_imports
import 'package:http/src/response.dart';
import 'dart:convert'; // Import json decoder

class ClubService {

  Future<List<ClubFilter>> fetchClubsFilters() async {
    final client = CustomClient({});
    try {
      final response = await client.get(Uri.parse('/clubs/getall'));

      if (response.statusCode != 200) {
        throw Exception("Error calling get clubs filters");
      }

      final jsonResponse = await jsonDecode(response.body);

      final List<ClubFilter> clubs = jsonResponse
          .map<ClubFilter>((json) => ClubFilter.fromJson(json))
          .toList();

      return clubs;
    } catch (e) {
      throw Exception("Error calling get clubs filters: $e");
    } finally {
      client.close();
    }
  }

}
