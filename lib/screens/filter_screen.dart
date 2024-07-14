import 'package:flutter/material.dart';
import 'package:tsport_mobile_app/models/shirt_filter_data.dart';
import 'package:tsport_mobile_app/utils/price_utils.dart';

class FilterScreen extends StatefulWidget {
  final List<String> selectedSize;
  final double? selectedStartPrice;
  final double? selectedEndPrice;
  const FilterScreen({super.key, required this.selectedSize, this.selectedStartPrice, this.selectedEndPrice});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  RangeValues currentRangeValues = const RangeValues(0, 500000);
  var sizes = [
    'S',
    'M',
    'L',
    'XL',
    'XXL',
  ];

  var isSelected = {
    'S': false,
    'M': false,
    'L': false,
    'XL': false,
    'XXL': false
  };

  @override
  void initState() {
    super.initState();
    for (var size in widget.selectedSize) {
      isSelected[size] = true;
    }

    if (widget.selectedStartPrice != null && widget.selectedEndPrice != null) {
      currentRangeValues = RangeValues(widget.selectedStartPrice!, widget.selectedEndPrice!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bộ lọc'),
      ),
      body: Column(
        children: [
          priceFilterSection(),
          sizeFilterSection(),
          const SizedBox(height: 20),
          applyButton()
        ],
      ),
    );
  }

  Widget applyButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: () {
            var selectedSizes = isSelected.entries
                .where((e) => e.value == true)
                .map((e) => e.key)
                .toList();
            var startPrice = currentRangeValues.start.round().toDouble();
            var endPrice = currentRangeValues.end.round().toDouble();

            var filterData = ShirtFilterData(sizes: selectedSizes);

            if (startPrice < endPrice) {
              filterData.startPrice = startPrice;
              filterData.endPrice = endPrice;
            }

            // Navigator.pop(context, selectedSizes);
            Navigator.pop(context, filterData);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              'Áp dụng',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          )),
    );
  }

  Widget sizeFilterSection() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 10),
          margin: const EdgeInsets.only(top: 20),
          child: const Text(
            'Size',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3))
              ]),
          child: Wrap(
            spacing: 10,
            children: sizes.map((String size) {
              return ChoiceChip(
                label: Text(size),
                selected: isSelected[size] ?? false,
                selectedColor: Colors.red,
                onSelected: (bool selected) {
                  setState(() {
                    isSelected[size] = selected;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Column priceFilterSection() {
    return Column(
      children: [
        Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 10),
            child: const Text(
              'Khoảng giá',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3))
              ]),
          child: RangeSlider(
            values: currentRangeValues,
            min: 0,
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
          ),
        ),
      ],
    );
  }
}
