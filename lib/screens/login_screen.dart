import 'package:flutter/material.dart';
import 'package:tsport_mobile_app/services/auth_service.dart';

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
      body: Padding(
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
              emailTextField(emailController),
              const SizedBox(height: 10),
              passwordTextField(passwordController),
              const SizedBox(height: 20),
              forgotPasswordLink(),
              const SizedBox(height: 20),
              loginButton()
            ],
          ),
        ),
      ),
    );
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

    var response = await AuthService().callLogin(email, password);

    var message = "Sai email hoặc mật khẩu";
    if (response.statusCode == 201) {
      message = "Đăng nhập thành công";
    }

    if (mounted) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Thông báo'),
              content: Text("$message + ${response.statusCode}"),
              actions: [
                TextButton(
                    onPressed: () => {Navigator.of(context).pop()},
                    child: const Text('Ok'))
              ],
            );
          });
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

  Container passwordTextField(TextEditingController passwordController) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3))
          ]),
      child: TextFormField(
        controller: passwordController,
        decoration: const InputDecoration(
          labelText: 'Mật khẩu',
          labelStyle: TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none),
        ),
        obscureText: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Mật khẩu không được để trống";
          }
          

          return null;
        },
      ),
    );
  }

  Widget emailTextField(TextEditingController emailController) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3))
          ]),
      child: TextFormField(
        controller: emailController,
        decoration: const InputDecoration(
          labelText: 'Email',
          labelStyle: TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Email không được để trống";
          }

          if (!value.contains('@')) {
            return "Email không hợp lệ";
          }

          return null;
        },
      ),
    );
  }
}
