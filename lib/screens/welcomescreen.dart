import 'package:flutter/material.dart';
import 'package:simply_todo/screens/homescreen.dart';
import 'package:simply_todo/utils/colors.dart';

// ignore: must_be_immutable
class WelcomeScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var username;
  WelcomeScreen({Key? key, required this.username}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), (() {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    user: widget.username,
                  )));
    }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final topColor = Theme.of(context).brightness;

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Welcome,",
              style: TextStyle(
                  color: topColor != Brightness.dark
                      ? AppColors.secondary
                      : AppColors.mainText,
                  fontSize: 50)),
          Text(widget.username,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style:
                  const TextStyle(color: AppColors.themeColor, fontSize: 60)),
          Text("We're happy to have you onboard",
              style: TextStyle(
                  color: topColor != Brightness.dark
                      ? AppColors.mainLightText
                      : AppColors.mainText,
                  fontSize: 45))
        ],
      )),
    ));
  }
}
