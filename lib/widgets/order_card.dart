import 'package:flutter/material.dart';
import 'package:tsport_mobile_app/models/account_details.dart';
import 'package:tsport_mobile_app/models/paged_order.dart';
import 'package:tsport_mobile_app/screens/order_details_screen.dart';
import 'package:tsport_mobile_app/screens/shirts_screen.dart';
import 'package:tsport_mobile_app/utils/order_utils.dart';

class OrderCard extends StatefulWidget {
  final PagedOrder order;
  const OrderCard({
    super.key,
    required this.order,
  });

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
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
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text('Mã đơn: ${widget.order.code}'),
            const SizedBox(height: 10),
            Text('Ngày đặt: ${widget.order.orderDate}',
                style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text('Số lượng: ${widget.order.orderDetails.length}'),
                const Text(''),
                Text('Tổng: ${formatPrice(widget.order.total)} VNĐ',
                    style: const TextStyle(color: Colors.red))
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                detailsButton(widget.order.id),
                Text('Trạng thái: ${OrderUtils.getStatusLabel(widget.order.status)}')
              ],
            )
          ],
        ),
      ),
    );
  }

  ElevatedButton detailsButton(int orderId) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(15.0), // Set the border radius if needed
            side: const BorderSide(
                color: Colors.black,
                width: 2), // Set border color and width here
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderDetailsScreen(orderId: orderId)),
          );
        },
        child: const Text('Xem chi tiết'));
  }
}
