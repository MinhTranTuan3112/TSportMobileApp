import 'package:flutter/material.dart';
import 'package:tsport_mobile_app/services/auth_service.dart';
import 'package:tsport_mobile_app/utils/popup_utils.dart';
import 'package:tsport_mobile_app/widgets/email_text_field.dart';
import 'package:tsport_mobile_app/widgets/google_login_button.dart';
import 'package:tsport_mobile_app/widgets/password_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
            // key: _formKey,
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Đăng kí',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                EmailTextField(emailController: emailController),
                const SizedBox(height: 10),
                PasswordTextField(passwordController: passwordController),
                const SizedBox(height: 20),
                PasswordTextField(
                    passwordController: confirmPasswordController,
                    label: 'Xác nhận mật khẩu'),
                const SizedBox(height: 20),
                signUpButton(),
                const SizedBox(height: 20),
                const Text('Hoặc đăng nhập bằng'),
                const GoogleLoginButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future performSignUp() async {
    var message = "Đăng kí thành công";
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;
    if (password != confirmPassword) {
      message = "Mật khẩu không khớp";
      if (mounted) {
        PopupUtils.showPopup(context, message);
      }

      return;
    }

    await AuthService().callSupabaseSignUp(email, password);
    
    if (mounted) {
      PopupUtils.showPopup(context, message);
    }
  }

  Widget signUpButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: () async {
            await performSignUp();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              'ĐĂNG KÍ',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          )),
    );
  }
}
