import 'package:flutter/material.dart';

class OrderStatusButton extends StatelessWidget {
  const OrderStatusButton({
    super.key,
    required this.status,
  });

  final String status;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black, backgroundColor: Colors.transparent),
      onPressed: () => {},
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: SizedBox(
          child: Text(status),
        ),
      ),
    );
  }
}
