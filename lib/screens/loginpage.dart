import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simply_todo/screens/welcomescreen.dart';
import 'package:simply_todo/sharedprefrences.dart';

import 'package:simply_todo/utils/colors.dart';

// ignore: prefer_typing_uninitialized_variables
var name;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final myController = TextEditingController();
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topColor = Theme.of(context).brightness;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText("Hi there,",
                          textStyle: const TextStyle(
                              fontSize: 50,
                              color: AppColors.themeColor,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2),
                          speed: const Duration(milliseconds: 200)),
                    ],
                    isRepeatingAnimation: false,
                  ),
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                          "I'm ' Simply Todo ', let's know each other ^ _ ^ ",
                          textStyle: TextStyle(
                              color: topColor != Brightness.dark
                                  ? AppColors.mainLightText
                                  : AppColors.mainText,
                              fontSize: 40),
                          speed: const Duration(milliseconds: 100)),
                    ],
                    isRepeatingAnimation: false,
                  ),
                ],
              ),
              const SizedBox(
                height: 80,
              ),
              TextField(
                style: TextStyle(
                    fontSize: 40,
                    color: topColor != Brightness.dark
                        ? AppColors.mainLightText
                        : AppColors.mainText,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.secondary),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.themeColor),
                  ),
                  focusColor: AppColors.secondary,
                  hintText: "Enter your name here",
                ),
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                controller: myController,
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.secondary),
                  ),
                  onPressed: () {
                    name = myController.text;

                    setState(() {
                      saveData(name);
                    });

                    (myController.text != '')
                        ? Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WelcomeScreen(
                                      username: name,
                                    )))
                        : showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                                  insetAnimationDuration:
                                      const Duration(seconds: 1),
                                  title: const Text(" No name :("),
                                  content:
                                      const Text("You didn't enter any name!"),
                                  actions: <Widget>[
                                    CupertinoDialogAction(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("retry",
                                            style: TextStyle(
                                                color: AppColors.themeColor)))
                                  ],
                                ));
                  },
                  child: const Center(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                      child: Text("Let's Go!",
                          maxLines: 1,
                          style: TextStyle(fontSize: 30, letterSpacing: 1)),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
