import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tsport_mobile_app/models/order_in_cart.dart';
import 'package:tsport_mobile_app/utils/custom_client.dart';
import 'dart:convert' show jsonDecode, jsonEncode;

class OrderService {
  Future callAddToCart(int shirtId, int quantity, String size) async {
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
          "size": size,
        }));

    if (response.statusCode != 200) {
      throw Exception("Error calling add to cart");
    }

    client.close();
  }

  Future<OrderInCart> fetchCartInfo() async {
    final session = Supabase.instance.client.auth.currentSession;
    var token = session?.accessToken;
    final client = CustomClient({
      "Authorization": "Bearer $token",
    });

    final response = await client.get(Uri.parse('/orders/get-cart'));

    if (response.statusCode != 200) {
      throw Exception("Error fetching cart info");
    }

    final jsonResponse = await jsonDecode(response.body);

    final orderInCart = OrderInCart.fromJson(jsonResponse);

    client.close();

    return orderInCart;
  }
}
