import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tsport_mobile_app/widgets/cart_item.dart';

class CartsScreen extends StatelessWidget {
  const CartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              'Giỏ hàng',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(height: 20),
            CartItem(),
            CartItem(),
          ],
        ),
      ),
    );
  }
}
