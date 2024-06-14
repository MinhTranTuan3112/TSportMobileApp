import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tsport_mobile_app/main.dart';
import 'package:tsport_mobile_app/screens/home_screen.dart';
import 'package:tsport_mobile_app/screens/login_screen.dart';
import 'package:tsport_mobile_app/services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    bool isAuthenticated = (user != null);

    return !isAuthenticated
        ? unauthenticatedContent(context)
        : authenticatedContent(user);
  }

  Widget authenticatedContent(User user) {
    return Column(
      children: [
        Text('Chào mừng ${user.email} đến với TSport'),
        const SizedBox(height: 20),
        ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Xác nhận'),
                    content: const Text('Xác nhận muốn đăng xuất?'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Hủy'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Đồng ý'),
                        onPressed: () async {
                          await AuthService().signOut();
                          if (mounted) {
                            Navigator.pushAndRemoveUntil(
                              // ignore: use_build_context_synchronously
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      (const MyApp())), // replace 'YourApp' with your main widget that includes the BottomNavigationBar
                              (Route<dynamic> route) => false,
                            );
                          }
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text('Đăng xuất'))
      ],
    );
  }

  Future performSignout() async {
    await AuthService().signOut();
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (Route<dynamic> route) => false,
      );
    }
  }

  Widget unauthenticatedContent(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Đăng nhập để mua hàng ngay với TSport',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
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
