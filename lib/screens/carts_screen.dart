import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tsport_mobile_app/models/order_in_cart.dart';
import 'package:tsport_mobile_app/screens/login_screen.dart';
import 'package:tsport_mobile_app/services/auth_service.dart';
import 'package:tsport_mobile_app/services/order_service.dart';
import 'package:tsport_mobile_app/widgets/cart_item.dart';

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
                    return CartItem(
                        orderDetail: _orderInCart!.orderDetails[index]);
                  },
                ),
              ),
            // CartItem(),
            // CartItem(),
          ],
        ),
      ),
    );
  }
}
