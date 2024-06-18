import 'package:flutter/material.dart';

final colors = [
  'Đỏ',
  'Cam',
  'Vàng'
];

class ColorDropdownButton extends StatefulWidget {
  const ColorDropdownButton({super.key});

  @override
  State<ColorDropdownButton> createState() => _ColorDropdownButtonState();
}

class _ColorDropdownButtonState extends State<ColorDropdownButton> {
  String? dropdownValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.red),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: const Text('Màu sắc'),
          value: dropdownValue,
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(color: Colors.black),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: colors.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
    ;
  }
}
