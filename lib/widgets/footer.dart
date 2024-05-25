import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items:  [
        const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang Chủ'),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/shirt-svgrepo-com.svg'),
          label: 'Áo đấu',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Giỏ hàng',
        ),
      ],
    );
  }
}
