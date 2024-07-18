import 'package:flutter/material.dart';
import 'package:tsport_mobile_app/models/shirt.dart';
// ignore: depend_on_referenced_packages
import 'package:tsport_mobile_app/screens/shirt_details_screen.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:tsport_mobile_app/screens/shirts_screen.dart';

class ShirtCard extends StatelessWidget {
  final ShirtItem shirt;
  const ShirtCard({super.key, required this.shirt});

  @override
  Widget build(BuildContext context) {
    return Card(color: Colors.white,
      child: GestureDetector(
        onTap: () => {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ShirtDetailsScreen(shirtId: shirt.id)))
        },
        child: Column(
          children: [
            Image.network(
              height: 150,
              width: 180,
              fit: BoxFit.cover,
              shirt.images.firstWhereOrNull((_) => true)?.url ??
                  'https://onlinetools.com/images/examples-onlineimagetools/empty-translucent-image.png',
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                // Return a placeholder widget or an error icon when the image fails to load
                return const Icon(Icons.error);
              },
            ),
            const SizedBox(height: 10),
            Text(
              shirt.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            if (shirt.shirtEdition.discountPrice != null) ...[
              Text(
                '${formatPrice(shirt.shirtEdition.stockPrice)} VNĐ',
                style: const TextStyle(decoration: TextDecoration.lineThrough,fontSize: 12),
                
              ),
              const SizedBox(height: 10),
              Text(
                '${formatPrice(shirt.shirtEdition.discountPrice ?? 0)} VNĐ',
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 12
                ),
              ),
            ] else ...[
              Text(
                '${formatPrice(shirt.shirtEdition.stockPrice)} VNĐ',
              ),
            ],
          ],
        ),
      ),
    );
  }
}
