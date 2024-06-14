import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tsport_mobile_app/screens/carts_screen.dart';
import 'package:tsport_mobile_app/screens/home_screen.dart';
import 'package:tsport_mobile_app/screens/profile_screen.dart';
import 'package:tsport_mobile_app/screens/shirts_screen.dart';
import 'package:tsport_mobile_app/widgets/main_app_bar.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  final List<Widget> widgets = const [
    HomeScreen(),
    ShirtsScreen(),
    CartsScreen(),
    ProfileScreen()
  ];

  void selectHome() {
    setState(() {
      _selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar.appBar(),
      body: Center(child: widgets.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/shirt-svgrepo-com.svg'),
            label: 'Áo thể thao',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Giỏ hàng',
          ),
          const BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Cá nhân')
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
