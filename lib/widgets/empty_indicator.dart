import 'package:flutter/material.dart';

class EmptyIndicator extends StatelessWidget {
  const EmptyIndicator({super.key, this.message = 'No items found'});
  final String message;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No items found'),
    );
  }
}
