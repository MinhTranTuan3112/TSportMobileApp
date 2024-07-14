import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:tsport_mobile_app/models/order_details_info.dart';
import 'package:tsport_mobile_app/screens/shirts_screen.dart';

class ShirtCardOrderDetails extends StatefulWidget {
  final OrderDetail orderDetail;
  const ShirtCardOrderDetails({
    super.key,
    required this.orderDetail,
  });

  @override
  State<ShirtCardOrderDetails> createState() => _ShirtCardOrderDetailsState();
}

class _ShirtCardOrderDetailsState extends State<ShirtCardOrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(
            widget.orderDetail.shirt.images
                    .firstWhereOrNull((_) => true)
                    ?.url ??
                'https://onlinetools.com/images/examples-onlineimagetools/empty-translucent-image.png',
            height: 100,
            width: 100),
        const SizedBox(width: 5),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.orderDetail.shirt.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              const SizedBox(height: 3),
              // Text(
              //   'Câu lạc bộ...',
              //   style: TextStyle(color: Colors.grey),
              // ),
              const SizedBox(height: 3),
              Text('Size: ${widget.orderDetail.size}'),
              const SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Số lượng: ${widget.orderDetail.quantity}'),
                  const SizedBox(width: 70),
                  Text(
                    '${formatPrice(widget.orderDetail.subtotal)} VNĐ',
                    style: const TextStyle(color: Colors.red),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
