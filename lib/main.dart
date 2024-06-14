import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tsport_mobile_app/widgets/bottom_navigation_bar.dart';

void main() async {
  await Supabase.initialize(
      url: 'https://iptnrpnttdzsfgozjmum.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlwdG5ycG50dGR6c2Znb3pqbXVtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTgxNjMyNDIsImV4cCI6MjAzMzczOTI0Mn0.vriszLz5WLz1sJiawjqJ7jTEusNonziCNvPbGFqbpW4');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TSport',
      theme: ThemeData(
        fontFamily: 'BeVietnamPro',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const BottomNavigation(),
    );
  }
}
