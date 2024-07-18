import 'package:flutter/material.dart';

class ErrorIndicator extends StatelessWidget {
  final String message;
  final VoidCallback onTryAgain;

  const ErrorIndicator(
      {required this.message, required this.onTryAgain, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: onTryAgain,
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
}
