import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tsport_mobile_app/models/account_details.dart';
import 'package:tsport_mobile_app/models/basic_account.dart';
import 'package:tsport_mobile_app/models/update_account_request.dart';
import 'package:tsport_mobile_app/utils/custom_client.dart';
import 'dart:convert'; // Import json decoder
// ignore: depend_on_referenced_packages, implementation_imports
import 'package:http/src/response.dart';
import 'dart:convert' show jsonDecode, jsonEncode;

class AccountService {
  Future<AccountDetails?> fetchDetailsCustomerProfileInfo() async {
    final session = Supabase.instance.client.auth.currentSession;
    var token = session?.accessToken;
    final client = CustomClient({
      "Authorization": "Bearer $token",
    });

    final response =
        await client.get(Uri.parse('/accounts/customer/details-info'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      final accountDetails = AccountDetails.fromJson(jsonResponse);

      client.close();

      return accountDetails;
    }

    client.close();
    return null;
  }

  Future<BasicAccount?> fetchBasicAccountInfo() async {
    final session = Supabase.instance.client.auth.currentSession;
    var token = session?.accessToken;
    final client = CustomClient({
      "Authorization": "Bearer $token",
    });

    final response =
        await client.get(Uri.parse('/accounts/customer/basic-info'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      final basicAccount = BasicAccount.fromJson(jsonResponse);

      client.close();

      return basicAccount;
    }

    client.close();
    return null;
  }

  Future<Response> updateCustomerInfo(UpdateAccountRequest request) async {
    
    final session = Supabase.instance.client.auth.currentSession;
    var token = session?.accessToken;
    final client = CustomClient({
      "Authorization": "Bearer $token",
    });

    final response = await client.put(
      Uri.parse('/accounts/customers'),
      body: jsonEncode(request.toJson()),
    );

    return response;
  }
}
