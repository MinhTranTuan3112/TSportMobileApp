import 'package:flutter/material.dart';
import 'package:tsport_mobile_app/widgets/footer.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 23, width: 23, child: SvgPicture.asset('assets/icons/sport-team-shirt-svgrepo-com.svg')),
            const SizedBox(width: 7),
            const Text('TSport'),
          ],
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.w900,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
