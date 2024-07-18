import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({super.key});

  @override
  // ignore: override_on_non_overriding_member
  Widget build(BuildContext context) {
    return appBar();
  }

  static AppBar appBar() {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 23,
                        width: 23,
                        child: SvgPicture.asset(
                            'assets/icons/sport-team-shirt-svgrepo-com.svg')),
                    const SizedBox(width: 3),
                    const Text('TSport'),
                  ],
                )),
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: Container(
            //     // margin: const EdgeInsets.all(10),
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     child: const Icon(Icons.keyboard_arrow_left_rounded, size: 30),
            //   ),
            // ),
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: Container(
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     child: const Icon(Icons.search),
            //   ),
            // )
          ],
        ),
      ),
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.w900,
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
    );
  }
}
