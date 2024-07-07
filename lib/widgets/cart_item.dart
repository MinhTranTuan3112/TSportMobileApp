import 'package:flutter/material.dart';
import 'package:tsport_mobile_app/models/order_in_cart.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
class CartItem extends StatefulWidget {
  final OrderDetail orderDetail;
  const CartItem({super.key, required this.orderDetail});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int _quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      // width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 5,
        child: Row(
          children: [
            Image.network(
                height: 120,
                width: 120,
                widget.orderDetail.shirt.images.firstWhereOrNull((_) => true)?.url ??
                  'https://onlinetools.com/images/examples-onlineimagetools/empty-translucent-image.png'),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.orderDetail.shirt.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                   Row(
                    children: [
                      Row(
                        children: [
                          const Text('Size: '),
                          Text(
                            widget.orderDetail.size,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      // SizedBox(width: 20),
                      // Row(
                      //   children: [
                      //     Text('Màu sắc: '),
                      //     Text(
                      //       'Đỏ',
                      //       style: TextStyle(fontWeight: FontWeight.bold),
                      //     )
                      //   ],
                      // )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (_quantity > 0) {
                              _quantity--;
                            }
                          });
                        },
                        style: ButtonStyle(
                          shape: WidgetStateProperty.all<CircleBorder>(
                            const CircleBorder(),
                          ),
                          padding: WidgetStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(
                                  16)), // adjust padding as needed
                        ),
                        child: const Icon(Icons.remove),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "$_quantity", // Replace with your quantity variable
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _quantity++;
                          });
                        },
                        style: ButtonStyle(
                          shape: WidgetStateProperty.all<CircleBorder>(
                            const CircleBorder(),
                          ),
                          padding: WidgetStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(
                                  16)), // adjust padding as needed
                        ),
                        child: const Icon(Icons.add),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
