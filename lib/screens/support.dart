import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:simply_todo/utils/colors.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  @override
  Widget build(BuildContext context) {
    final topColor = Theme.of(context).brightness;
    return Dismissible(
      key: const Key("value"),
      onDismissed: Navigator.of(context).pop,
      direction: DismissDirection.endToStart,
      child: Scaffold(
          body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: AppColors.secondary),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(CupertinoIcons.back,
                                  color: AppColors.mainText)),
                          const Text("Back to App",
                              style: TextStyle(
                                  letterSpacing: 2,
                                  fontSize: 25,
                                  color: AppColors.mainText)),
                        ],
                      ),
                      const Text(
                        "Thanks for using this app, hope you like the aesthetics of the app :)",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            fontSize: 25,
                            color: AppColors.mainText),
                      ),
                      const Spacer(),
                      const Text(
                        "Made with \u{2661} by Diptanshu",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            fontSize: 20,
                            color: AppColors.mainText),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              launchUrlString(
                                  "https://www.instagram.com/_diptanshuu_");
                            },
                            icon: const Icon(
                              FeatherIcons.instagram,
                              size: 20,
                            ),
                            color: AppColors.mainText.withAlpha(200),
                          ),
                          IconButton(
                            onPressed: () {
                              launchUrlString(
                                  "https://www.facebook.com/diptanshumahish");
                            },
                            icon: const Icon(
                              FeatherIcons.facebook,
                              size: 20,
                            ),
                            color: AppColors.mainText.withAlpha(200),
                          ),
                          IconButton(
                            onPressed: () {
                              launchUrlString(
                                  "https://www.github.com/diptanshumahish");
                            },
                            icon: const Icon(
                              FeatherIcons.github,
                              size: 20,
                            ),
                            color: AppColors.mainText.withAlpha(200),
                          ),
                          IconButton(
                            onPressed: () {
                              launchUrlString(
                                  "mailto:diptanshumahish2016@gmail.com");
                            },
                            icon: const Icon(
                              FeatherIcons.mail,
                              size: 20,
                            ),
                            color: AppColors.mainText.withAlpha(200),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  children: [
                    (topColor == Brightness.dark)
                        ? Image.asset("assets/images/simplyy.png")
                        : Image.asset(
                            color: AppColors.mainLightText,
                            "assets/images/simplyy.png",
                          ),
                    Text(
                      "Thanks for using the paid ad-free version of the App :) , it really supports small developers like me!",
                      style: TextStyle(
                        fontSize: 25,
                        letterSpacing: 2,
                        color: topColor != Brightness.dark
                            ? AppColors.mainLightText
                            : AppColors.mainText,
                      ),
                    )
                  ],
                ),
              ),
            ))
          ],
        ),
      )),
    );
  }
}
