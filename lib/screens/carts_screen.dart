import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tsport_mobile_app/models/add_to_cart_request.dart';
import 'package:tsport_mobile_app/models/order_in_cart.dart';
import 'package:tsport_mobile_app/screens/login_screen.dart';
import 'package:tsport_mobile_app/screens/shirts_screen.dart';
import 'package:tsport_mobile_app/services/order_service.dart';
import 'package:tsport_mobile_app/widgets/cart_item.dart';
// import 'dart:developer' as logger;

class CartsScreen extends StatefulWidget {
  const CartsScreen({super.key});

  @override
  State<CartsScreen> createState() => _CartsScreenState();
}

class _CartsScreenState extends State<CartsScreen> {
  OrderInCart? _orderInCart;

  Future<void> fetchCartInfo() async {
    var orderInCart = await OrderService().fetchCartInfo();

    setState(() {
      _orderInCart = orderInCart;
    });
  }

  @override
  void initState() {
    // final user = Supabase.instance.client.auth.currentUser;
    // bool isAuthenticated = (user != null);
    // if (!isAuthenticated && mounted) {
    //   Navigator.pushReplacement(context,
    //       MaterialPageRoute(builder: (context) => const LoginScreen()));
    //   return;
    // }
    fetchCartInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            cartContent(),
          ],
        ),
      ),
    );
  }

  Future handleOrderSubmit() async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận'),
          content: const Text('Xác nhận đặt hàng?'),
          actions: <Widget>[
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pop(false), // User presses "No"
              child: const Text('Không'),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pop(true), // User presses "Yes"
              child: const Text('Có'),
            ),
          ],
        );
      },
    );

    if (confirmed != null && confirmed == false) {
      return;
    }

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
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Thành công'),
            content: const Text(
                'Đặt hàng thành công! Cảm ơn bạn đã mua hàng ở TSport!'),
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
      await fetchCartInfo();
    }
  }

  double getShirtPrice(Shirt shirt) {
    return shirt.shirtEdition.discountPrice ?? shirt.shirtEdition.stockPrice;
  }

  void updateOrderTotal() {
    setState(() {
      _orderInCart!.total = _orderInCart!.orderDetails.fold(
          0,
          (total, current) =>
              total + (getShirtPrice(current.shirt) * current.quantity));
    });
  }

  Widget vnPayButton() {
    return ElevatedButton(
        onPressed: () {}, child: const Text('Thanh toán qua VNPay'));
  }

  Widget cartContent() {
    if (_orderInCart == null || _orderInCart!.orderDetails.isEmpty) {
      return const Text(
        'Giỏ hàng của bạn đang trống.',
        style: TextStyle(fontSize: 20),
      );
    }

    return Column(
      children: [
        // SizedBox(
        //   height: 600, // Specify a fixed height for the ListView.builder
        //   child: ListView.builder(
        //     itemCount: _orderInCart!.orderDetails.length,
        //     itemBuilder: (context, index) {
        //       return CartItem(orderDetail: _orderInCart!.orderDetails[index]);
        //     },
        //   ),
        // ),
        if (_orderInCart != null && _orderInCart!.orderDetails.isNotEmpty)
          ...List.generate(_orderInCart!.orderDetails.length, (index) {
            return CartItem(
              orderDetail: _orderInCart!.orderDetails[index],
              onUpdateTotal: updateOrderTotal,
            );
          }),
        const SizedBox(height: 20),

        Center(
            child: Text(
          'Tổng cộng: ${formatPrice(_orderInCart!.total)} VNĐ',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )),

        const SizedBox(height: 10),
        // vnPayButton(),
        const SizedBox(height: 10),
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
