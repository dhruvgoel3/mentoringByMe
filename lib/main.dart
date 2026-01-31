import 'package:firebase/firebase.dart' as Firebase;
import 'package:flutter/material.dart';
import 'package:mentoring_meet_1/bottom_nav_bar.dart';
import 'package:mentoring_meet_1/view/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: LoginScreen(),
    );
  }
}
