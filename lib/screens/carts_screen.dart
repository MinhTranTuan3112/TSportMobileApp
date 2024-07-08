import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tsport_mobile_app/models/add_to_cart_request.dart';
import 'package:tsport_mobile_app/models/order_in_cart.dart';
import 'package:tsport_mobile_app/screens/login_screen.dart';
import 'package:tsport_mobile_app/services/auth_service.dart';
import 'package:tsport_mobile_app/services/order_service.dart';
import 'package:tsport_mobile_app/widgets/cart_item.dart';
import 'dart:developer' as logger;

class CartsScreen extends StatefulWidget {
  const CartsScreen({super.key});

  @override
  State<CartsScreen> createState() => _CartsScreenState();
}

class _CartsScreenState extends State<CartsScreen> {
  OrderInCart? _orderInCart;

  Future<void> fetchCartInfo() async {
    var orderInCart = await OrderService().fetchCartInfo();

    if (mounted) {
      setState(() {
        _orderInCart = orderInCart;
      });
    }
  }

  @override
  void initState() {
    fetchCartInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final user = Supabase.instance.client.auth.currentUser;
    // bool isAuthenticated = (user != null);
    // if (!isAuthenticated && mounted) {
    //   Navigator.push(context,
    //       MaterialPageRoute(builder: (context) => const LoginScreen()));
    // }

    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          children: [
            cartContent(),
          ],
        ),
      ),
    );
  }

  Future handleOrderSubmit() async {
    final requests = _orderInCart!.orderDetails.map((od) {
      return AddToCartRequest(
          // Assuming AddToCartRequest takes parameters like productId and quantity
          shirtId: od.shirtId,
          quantity: od.quantity,
          size: od.size);
    }).toList();

    final response =
        await OrderService().fetchConfirmOrder(_orderInCart!.id, requests);
    if (response.statusCode == 200) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Thành công'),
              content:
                  const Text('Đặt hàng thành công! Cảm ơn bạn đã mua hàng ở TSport!'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  Column cartContent() {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          'Giỏ hàng',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        const SizedBox(height: 20),
        if (_orderInCart == null || _orderInCart!.orderDetails.isEmpty)
          const Text(
            'Cart is empty',
            style: TextStyle(fontSize: 20),
          )
        else
          SizedBox(
            height: 500, // Specify a fixed height for the ListView.builder
            child: ListView.builder(
              itemCount: _orderInCart!.orderDetails.length,
              itemBuilder: (context, index) {
                return CartItem(orderDetail: _orderInCart!.orderDetails[index]);
              },
            ),
          ),
        ElevatedButton(
            onPressed: () async {
              await handleOrderSubmit();
            },
            child: const Text('Xác nhận đặt hàng và thanh toán'))
        // CartItem(),
        // CartItem(),
      ],
    );
  }
}
