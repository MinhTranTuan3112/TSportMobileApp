import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items:  [
        const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/shirt-svgrepo-com.svg'),
          label: 'Áo thể thao',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Giỏ hàng',
        ),
        const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Cá nhân')
      ],
    );
  }
}
