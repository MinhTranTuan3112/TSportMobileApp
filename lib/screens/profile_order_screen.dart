import 'package:flutter/material.dart';

import '../widgets/order_card.dart';
import '../widgets/order_status_button.dart';

class ProfileOrderScreen extends StatefulWidget {
  const ProfileOrderScreen({super.key});

  @override
  State<ProfileOrderScreen> createState() => _ProfileOrderScreenState();
}

class _ProfileOrderScreenState extends State<ProfileOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Đơn hàng của tôi',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30))),
      body: Column(
        children: [
          const SizedBox(height: 20),
          statusBar(),
          const SizedBox(height: 20),
          orderList()
        ],
      ),
    );
  }

  Widget statusBar() {
    final statuses = ["Đã giao", "Đang giao", "Đã hủy"];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...statuses.map((status) => OrderStatusButton(status: status)),
      ],
    );
  }

  Widget orderList() {
    return const Column(
      children: [OrderCard(), OrderCard()],
    );
  }
}
