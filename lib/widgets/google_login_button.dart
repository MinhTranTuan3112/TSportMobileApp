import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      alignment: Alignment.bottomCenter,
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding:
                const EdgeInsets.only(top: 27, bottom: 27, left: 27, right: 27),
          ),
          child: SizedBox(
              height: 20,
              width: 20,
              child: SvgPicture.asset('assets/icons/google.svg'))),
    );
  }
}
