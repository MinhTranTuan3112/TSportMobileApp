import 'package:flutter/material.dart';
import 'package:tsport_mobile_app/models/order_details_info.dart';
import 'package:tsport_mobile_app/services/order_service.dart';

import '../widgets/shirt_card_order_details.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int orderId;
  const OrderDetailsScreen({super.key, required this.orderId});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  OrderDetailsInfo? _order;

  @override
  void initState() {
    super.initState();
    fetchOrderDetailsInfo();
  }

  Future fetchOrderDetailsInfo() async {
    final order = await OrderService().fetchOrderDetailsInfo(widget.orderId);
    setState(() {
      _order = order;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết đơn hàng',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
      ),
      body: Column(
        children: [
          infoContent(),
          const SizedBox(height: 10),
          orderShirtsContent(),
          const SizedBox(height: 20),
          bottomInfoContent()
        ],
      ),
    );
  }

  Widget bottomInfoContent() {
    return Column(
      children: [Text('Tổng tiền: ${_order?.total} VNĐ')],
    );
  }

  Widget orderShirtsContent() {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 2, // Spread radius
              blurRadius: 7, // Blur radius
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: Column(children: [
        ..._order?.orderDetails.map((orderDetail) {
          return ShirtCardOrderDetails(orderDetail: orderDetail);
        }).toList() ?? []
      ]),
    );
  }

  Widget infoContent() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Mã đơn: ${_order?.id}'),
              Text(
                '${_order?.orderDate}',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Số lượng áo: ${_order?.orderDetails.length}'),
              const Text('(Trạng thái)')
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Được đặt bởi ${_order?.createdAccount.email}'),
              const Text('')
            ],
          )
        ],
      ),
    );
  }
}
