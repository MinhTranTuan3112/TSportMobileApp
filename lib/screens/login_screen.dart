import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tsport_mobile_app/main.dart';
import 'package:tsport_mobile_app/screens/profile_screen.dart';
import 'package:tsport_mobile_app/screens/signup_screen.dart';
import 'package:tsport_mobile_app/services/auth_service.dart';
import 'package:tsport_mobile_app/widgets/email_text_field.dart';
import 'package:tsport_mobile_app/widgets/google_login_button.dart';
import 'package:tsport_mobile_app/widgets/password_text_field.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  void initState() {
    // _setupAuthListener();
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future handleGoogleSignIn() async {
    await _googleSignIn();
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

  void _setupAuthListener() {
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const ProfileScreen(),
          ),
        );
      }
    });
  }

  Future<AuthResponse> _googleSignIn() async {
    /// TODO: update the Web client ID with your own.
    ///
    /// Web Client ID that you registered with Google Cloud.
    const webClientId =
        '15377455728-jl74dh9qpe1jou9mrq0e7gh1lvt1ah47.apps.googleusercontent.com';

    /// TODO: update the iOS client ID with your own.
    ///
    /// iOS Client ID that you registered with Google Cloud.
    const iosClientId = 'my-ios.apps.googleusercontent.com';

    // Google sign in on Android will work without providing the Android
    // Client ID registered on Google Cloud.

    final GoogleSignIn googleSignIn = GoogleSignIn(
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    return Supabase.instance.client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
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
                googleLoginButton(),
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
    try {
      var email = emailController.text;
      var password = passwordController.text;
      var authService = AuthService();
      var response = await authService.callSupabaseLogin(email, password);

      if (response.user != null) {
        final session = response.session;
        final accessToken = session?.accessToken;

        await authService.saveAccessToken(accessToken);
      } else {
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Thông báo'),
              content: const SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Sai email hoặc mật khẩu'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ],
            );
          },
        );
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
    } catch (e) {
      print(e);
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

  Widget googleLoginButton() {
    return Container(
        margin: const EdgeInsets.only(top: 30),
        alignment: Alignment.bottomCenter,
        child: ElevatedButton(
            onPressed: () async {
              await handleGoogleSignIn();
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.only(
                  top: 27, bottom: 27, left: 27, right: 27),
            ),
            child: SizedBox(
                height: 20,
                width: 20,
                child: SvgPicture.asset('assets/icons/google.svg'))));
  }
}
