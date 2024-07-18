import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tsport_mobile_app/main.dart';
import 'package:tsport_mobile_app/models/account_details.dart';
import 'package:tsport_mobile_app/models/basic_account.dart';
import 'package:tsport_mobile_app/screens/basic_info_screen.dart';
import 'package:tsport_mobile_app/screens/home_screen.dart';
import 'package:tsport_mobile_app/screens/login_screen.dart';
import 'package:tsport_mobile_app/screens/profile_order_screen.dart';
import 'package:tsport_mobile_app/services/account_service.dart';
import 'package:tsport_mobile_app/services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isHovered = false;
  BasicAccount? _account;
  bool isAuthenticated = (Supabase.instance.client.auth.currentUser != null);

  @override
  void initState() {
    super.initState();
    if (isAuthenticated) {
      fetchProfileInfo();
    }
  }

  Future fetchProfileInfo() async {
    final account = await AccountService().fetchBasicAccountInfo();
    setState(() {
      _account = account;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    bool isAuthenticated = (user != null);

    return !isAuthenticated
        ? unauthenticatedContent(context)
        : authenticatedContent();
  }

  Widget authenticatedContent() {
    return (_account == null)
        ? const Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                profileSection(),
                const SizedBox(height: 20),
                signOutButton()
              ],
            ),
          );
  }

  Widget profileSection() {
    return Column(children: [
      const Text('TSport Xin Chào',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
      const SizedBox(height: 20),
      Text('${_account?.email}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      const SizedBox(height: 20),
      profileContent()
    ]);
  }

  Widget profileContent() {
    return Column(
      children: [
        basicInfoSection(),
        const SizedBox(height: 20),
        orderSection(),
      ],
    );
  }

  Widget basicInfoSection() {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered =
              true; // You need to define a boolean state variable `isHovered`
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        color: isHovered
            ? Colors.grey.withOpacity(0.5)
            : Colors.transparent, // Change background color on hover
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BasicInfoScreen()),
            );
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('Thông tin cá nhân',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    // Text('${_account?.orders.length} đơn hàng',
                    //     style: const TextStyle(color: Colors.grey, fontSize: 15))
                  ],
                ),
                Icon(Icons.arrow_forward_ios_rounded, size: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget orderSection() {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered =
              true; // You need to define a boolean state variable `isHovered`
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        color: isHovered
            ? Colors.grey.withOpacity(0.5)
            : Colors.transparent, // Change background color on hover
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ProfileOrderScreen()),
            );
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('Đơn hàng của tôi',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    // Text('${_account?.orders.length} đơn hàng',
                    //     style: const TextStyle(color: Colors.grey, fontSize: 15))
                  ],
                ),
                Icon(Icons.arrow_forward_ios_rounded, size: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton signOutButton() {
    return ElevatedButton(
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
        child: const Text('Đăng xuất'));
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
