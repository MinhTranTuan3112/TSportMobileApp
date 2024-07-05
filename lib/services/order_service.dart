import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tsport_mobile_app/utils/custom_client.dart';
import 'dart:convert' show jsonDecode, jsonEncode;

class OrderService {
  Future callAddToCart(int shirtId, int quantity) async {
    final session = Supabase.instance.client.auth.currentSession;
    var token = session?.accessToken;
    final client = CustomClient({
      "Authorization": "Bearer $token",
    });

    var url = '/orders/add-to-cart';

    final response = await client.post(Uri.parse(url),
        body: jsonEncode({
          "shirt-id": shirtId,
          "quantity": quantity,
        }));

    if (response.statusCode != 200) {
      throw Exception("Error calling add to cart");
    }

    client.close();
  }
}
