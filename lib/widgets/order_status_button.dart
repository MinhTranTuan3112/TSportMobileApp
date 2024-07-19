import 'package:flutter/material.dart';

class OrderStatusButton extends StatelessWidget {
  const OrderStatusButton(
      {super.key,
      required this.status,
      required this.onPressed,
      this.isActive = false});

  final String status;
  final bool isActive;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          foregroundColor: isActive ? Colors.white : Colors.black,
          backgroundColor: isActive ? Colors.red : Colors.transparent),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(2.5),
        child: SizedBox(
          child: Text(getStatusLabel(status)),
        ),
      ),
    );
  }

  String getStatusLabel(String status) {
    String label = "";
    switch (status.toLowerCase()) {
      case "pending":
        label = "Đang chờ";
        break;
      case "processed":
        label = "Đã xác nhận";
        break;
      case "cancelled":
        label = "Đã hủy";
        break;
      default:
        label = "Unknown";
        break;
    }

    return label;
  }
}
