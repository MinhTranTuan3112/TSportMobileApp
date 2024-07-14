import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tsport_mobile_app/models/account_details.dart';
import 'package:tsport_mobile_app/utils/custom_client.dart';
import 'dart:convert'; // Import json decoder

class AccountService {
  Future<AccountDetails?> fetchCustomerProfileInfo() async {
    final session = Supabase.instance.client.auth.currentSession;
    var token = session?.accessToken;
    final client = CustomClient({
      "Authorization": "Bearer $token",
    });

    final response = await client.get(Uri.parse('/accounts/view-my-info'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      final accountDetails = AccountDetails.fromJson(jsonResponse);

      client.close();

      return accountDetails;
    }

    client.close();
    return null;
  }
}
