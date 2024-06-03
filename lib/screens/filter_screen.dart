import 'package:flutter/material.dart';
import 'package:tsport_mobile_app/utils/price_utils.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  RangeValues currentRangeValues = const RangeValues(50000, 500000);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bộ lọc'),
      ),
      body: Column(
        children: [
          Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 5),
              child: const Text('Khoảng giá')),
          const SizedBox(height: 10),
          priceSlider()
        ],
      ),
    );
  }

  RangeSlider priceSlider() {
    return RangeSlider(
      values: currentRangeValues,
      min: 50000,
      max: 500000,
      divisions: 10,
      labels: RangeLabels(
        '${PriceUtils.formatPrice(currentRangeValues.start.round().toDouble())} VNĐ',
        '${PriceUtils.formatPrice(currentRangeValues.end.round().toDouble())} VNĐ',
      ),
      onChanged: (RangeValues value) {
        setState(() {
          currentRangeValues = value;
        });
      },
      
    );
  }
}
