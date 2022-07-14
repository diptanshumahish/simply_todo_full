import 'package:flutter/material.dart';

import 'package:simply_todo/screens/splashscreen.dart';
import 'package:simply_todo/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Apptheme.light(),
      darkTheme: Apptheme.dark(),
      home: const SplashScreen(),
    );
  }
}
