import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tsport_mobile_app/models/account_details.dart';
import 'package:tsport_mobile_app/models/add_to_cart_request.dart';
import 'package:tsport_mobile_app/models/order_details_info.dart';
import 'package:tsport_mobile_app/models/order_in_cart.dart';
import 'package:tsport_mobile_app/models/paged_order.dart';
import 'package:tsport_mobile_app/models/pagedresult.dart';
import 'package:tsport_mobile_app/utils/custom_client.dart';
import 'dart:convert' show jsonDecode, jsonEncode;
// ignore: depend_on_referenced_packages, implementation_imports
import 'package:http/src/response.dart';
import 'dart:convert'; // Import json decoder

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

  Future<OrderInCart?> fetchCartInfo() async {
    final session = Supabase.instance.client.auth.currentSession;
    var token = session?.accessToken;
    final client = CustomClient({
      "Authorization": "Bearer $token",
    });

    final response = await client.get(Uri.parse('/orders/get-cart'));

    if (response.statusCode != 200) {
      return null;
    }

    final jsonResponse = await jsonDecode(response.body);

    final orderInCart = OrderInCart.fromJson(jsonResponse);

    client.close();

    return orderInCart;
  }

  Future<Response> fetchConfirmOrder(
      int orderId, List<AddToCartRequest> requests) async {
    final session = Supabase.instance.client.auth.currentSession;
    var token = session?.accessToken;
    final client = CustomClient({
      "Authorization": "Bearer $token",
    });

    // Convert the list of AddToCartRequest objects into a list of maps
    final requestBody =
        jsonEncode(requests.map((request) => request.toJson()).toList());

    final response =
        await client.post(Uri.parse('/orders/$orderId'), body: requestBody);
    client.close();

    return response;
  }

  Future<OrderDetailsInfo> fetchOrderDetailsInfo(int orderId) async {
    final session = Supabase.instance.client.auth.currentSession;
    var token = session?.accessToken;
    final client = CustomClient({
      "Authorization": "Bearer $token",
    });

    final response = await client.get(Uri.parse('/orders/$orderId'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      final orderDetailsInfo = OrderDetailsInfo.fromJson(jsonResponse);

      client.close();
      return orderDetailsInfo;
    }

    client.close();

    throw Exception('Failed to fetch order details info');
  }

  Future<List<PagedOrder>> fetchOrders(
      int pageKey, int pageSize,
      int? createdAccountId, String? status) async {
    final session = Supabase.instance.client.auth.currentSession;
    var token = session?.accessToken;
    final client = CustomClient({
      "Authorization": "Bearer $token",
    });

    var url = '/orders?pageNumber=$pageKey&pageSize=$pageSize';

    if (createdAccountId != null) {
      url += '&createdAccountId=$createdAccountId';
    }

    if (status != null) {
      url += '&status=$status';
    }

    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      final pagedResult =
          PagedResult<PagedOrder>.fromJson(jsonResponse, PagedOrder.fromJson);

      final orders = pagedResult.items;

      client.close();

      return orders;
    }

    client.close();

    throw Exception('Failed to fetch paged orders');
  }

}
