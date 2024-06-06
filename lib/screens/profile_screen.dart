import 'package:flutter/material.dart';
import 'package:tsport_mobile_app/screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  final bool isLogin = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Đăng nhập để mua hàng ngay với TSport'),
        ElevatedButton(
            onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()))
                },
            child: const Text('Đăng nhập'))
      ],
    );
  }
}
