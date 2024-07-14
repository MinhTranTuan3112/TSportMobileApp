import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tsport_mobile_app/models/account_details.dart';
import 'package:tsport_mobile_app/services/account_service.dart';

import '../widgets/order_card.dart';
import '../widgets/order_status_button.dart';

class ProfileOrderScreen extends StatefulWidget {
  const ProfileOrderScreen({super.key});

  @override
  State<ProfileOrderScreen> createState() => _ProfileOrderScreenState();
}

class _ProfileOrderScreenState extends State<ProfileOrderScreen> {
  AccountDetails? _account;

  bool isAuthenticated = (Supabase.instance.client.auth.currentUser != null);

  @override
  void initState() {
    super.initState();
    if (isAuthenticated) {
      fetchProfileInfo();
    }
  }

  Future fetchProfileInfo() async {
    final account = await AccountService().fetchCustomerProfileInfo();
    setState(() {
      _account = account;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Đơn hàng của tôi',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30))),
      body: bodyContent(),
    );
  }

  Widget bodyContent() {
    return Column(
      children: [
        const SizedBox(height: 20),
        statusBar(),
        const SizedBox(height: 20),
        orderList()
      ],
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
    // Check if the orders list is not empty
    if (_account?.orders != null && _account!.orders.isNotEmpty) {
      return Column(
        children: [
          // Map through the orders and display them
          ..._account!.orders.map((order) => OrderCard(order: order)),
        ],
      );
    }
    // Display "No order" text if the orders list is empty
    return const Center(
      child: Text('Không có đơn hàng nào'),
    );
  }
}
