import 'package:flutter/material.dart';

class CartItem extends StatefulWidget {
  const CartItem({super.key});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int _quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: Card(
        elevation: 5,
        child: Row(
          children: [
            Image.network(
                height: 120,
                width: 120,
                'https://product.hstatic.net/1000341630/product/hong-nam6745_da517aea17ca4a0491ed4ba8931a6f5a_master.jpg'),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Áo đấu...',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                  const Row(
                    children: [
                      Row(
                        children: [
                          Text('Size: '),
                          Text(
                            'S',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      SizedBox(width: 20),
                      Row(
                        children: [
                          Text('Màu sắc: '),
                          Text(
                            'Đỏ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      )
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
