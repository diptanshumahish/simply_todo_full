// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simply_todo/screens/homescreen.dart';
import 'package:simply_todo/screens/loginpage.dart';
import 'package:simply_todo/sharedprefrences.dart';
import 'package:simply_todo/utils/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void loadPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = (prefs.getString('fname') ?? 0);
    });
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), (() async {
      showGeneralDialog(
        barrierLabel: "Label",
        barrierDismissible: false,
        barrierColor: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
        transitionDuration: const Duration(milliseconds: 600),
        context: context,
        pageBuilder: (context, anim1, anim2) {
          return (username != 0)
              ? HomePage(
                  user: username,
                )
              : const LoginPage();
        },
        transitionBuilder: (context, anim1, anim2, child) {
          return SlideTransition(
            position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
                .animate(anim1),
            child: child,
          );
        },
      );
    }));
    super.initState();
    loadPref();
  }

  @override
  Widget build(BuildContext context) {
    final topColor = Theme.of(context).brightness;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    color: AppColors.themeColor,
                    boxShadow: [
                      (topColor == Brightness.light)
                          ? BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(
                                  1, 1), // changes position of shadow
                            )
                          : BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              spreadRadius: 0,
                              blurRadius: 0,
                              offset: const Offset(0, 0),
                            )
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Simply",
                          style: TextStyle(
                              color: AppColors.mainText,
                              fontSize: 50,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2)),
                      SizedBox(height: 15),
                      Text("Todo ^~^",
                          style: TextStyle(
                              letterSpacing: 1.8,
                              color: AppColors.mainText,
                              fontSize: 40))
                    ],
                  ),
                )),
            const SizedBox(height: 40),
            SizedBox(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoActivityIndicator(
                    color: AppColors.secondary,
                  ),
                  Text(
                    "version 1.0.0",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                      color: topColor != Brightness.dark
                          ? AppColors.mainLightText
                          : AppColors.mainText,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
