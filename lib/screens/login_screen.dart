import 'package:flutter/material.dart';
import 'package:tsport_mobile_app/main.dart';
import 'package:tsport_mobile_app/screens/signup_screen.dart';
import 'package:tsport_mobile_app/services/auth_service.dart';
import 'package:tsport_mobile_app/widgets/email_text_field.dart';
import 'package:tsport_mobile_app/widgets/google_login_button.dart';
import 'package:tsport_mobile_app/widgets/password_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Đăng nhập',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                // emailTextField(emailController),
                EmailTextField(emailController: emailController),
                const SizedBox(height: 10),
                PasswordTextField(passwordController: passwordController),
                const SizedBox(height: 20),
                forgotPasswordLink(),
                const SizedBox(height: 20),
                loginButton(),
                const SizedBox(height: 20),
                const Text('Hoặc đăng nhập bằng'),
                const GoogleLoginButton(),
                const SizedBox(height: 20),
                const Text('Chưa có tài khoản?'),
                const SizedBox(height: 10),
                signUpButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget signUpButton() {
    return SizedBox(
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignupScreen()));
            },
            child: const Text(
              'Đăng ký ngay',
              style: TextStyle(color: Colors.white),
            )));
  }

  Align forgotPasswordLink() {
    return const Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        child: Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Bạn quên mật khẩu?",
                style: TextStyle(color: Colors.black),
              ),
              Icon(
                Icons.arrow_right_alt,
                color: Colors.red,
                size: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> callLogin() async {
    var email = emailController.text;
    var password = passwordController.text;
    var authService = AuthService();
    var response = await authService.callSupabaseLogin(email, password);

    if (response.user != null) {
      final session = response.session;
      final accessToken = session?.accessToken;

      await authService.saveAccessToken(accessToken);
    }

    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) =>
                (const MyApp())), // replace 'YourApp' with your main widget that includes the BottomNavigationBar
        (Route<dynamic> route) => false,
      );
    }
  }

  SizedBox loginButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await callLogin();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              'ĐĂNG NHẬP',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          )),
    );
  }
}
