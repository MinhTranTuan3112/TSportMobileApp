import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

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
    return const Column(
      children: [Text('Tổng tiền: 300.000 VNĐ')],
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
        Row(
          children: [
            Image.network(
                'https://product.hstatic.net/1000341630/product/hong-nam6745_da517aea17ca4a0491ed4ba8931a6f5a_master.jpg',
                height: 100,
                width: 100),
            const SizedBox(width: 5),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Áo thể thao...',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Câu lạc bộ...',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 3),
                  Text('Size: XL'),
                  SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Số lượng: 3'),
                      SizedBox(width: 70),
                      Text('100.000 VNĐ', style: TextStyle(color: Colors.red),)
                    ],
                  )
                ],
              ),
            )
          ],
        )
      ]),
    );
  }

  Widget infoContent() {
    return const Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Mã đơn: 12345'),
              Text(
                '12-02-2021',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Số lượng áo: 3'), Text('(Trạng thái)')],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Được đặt bởi abc@gmail.com'), Text('')],
          )
        ],
      ),
    );
  }
}
