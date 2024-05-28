import 'package:flutter/material.dart';

class ShirtsScreen extends StatelessWidget {
  const ShirtsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return categoryBar();
  }

  Column categoryBar() {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: 30,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white
                  ),
                  onPressed: () => {},
                  child: const Text('Shirt category')));
          },
        ),
      )
    ],
  );
  }
}
