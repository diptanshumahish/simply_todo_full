import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simply_todo/screens/loginpage.dart';
import 'package:simply_todo/screens/support.dart';
import 'package:simply_todo/utils/colors.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: AppColors.secondary,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration:
                    BoxDecoration(color: AppColors.mainText.withAlpha(30)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Container()),
                      const Text("Have a great day !",
                          style: TextStyle(
                              color: AppColors.mainText,
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                              letterSpacing: 2)),
                      const Text("Add more ease to your daily life ;)",
                          style: TextStyle(
                              color: AppColors.mainText,
                              fontSize: 25,
                              letterSpacing: 2))
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                {
                  showGeneralDialog(
                    barrierLabel: "Label",
                    barrierDismissible: false,
                    barrierColor:
                        const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                    transitionDuration: const Duration(milliseconds: 300),
                    context: context,
                    pageBuilder: (context, anim1, anim2) {
                      return const LoginPage();
                    },
                    transitionBuilder: (context, anim1, anim2, child) {
                      return SlideTransition(
                        position: Tween(
                                begin: const Offset(-1, 0),
                                end: const Offset(0, 0))
                            .animate(anim1),
                        child: child,
                      );
                    },
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColors.mainText.withAlpha(30)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Change nickname",
                            style: TextStyle(
                                fontSize: 30,
                                letterSpacing: 2,
                                color: AppColors.mainText)),
                        Icon(CupertinoIcons.heart_circle_fill,
                            color: AppColors.mainText)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: (() {
                {
                  showGeneralDialog(
                    barrierLabel: "Label",
                    barrierDismissible: false,
                    barrierColor:
                        const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                    transitionDuration: const Duration(milliseconds: 300),
                    context: context,
                    pageBuilder: (context, anim1, anim2) {
                      return const SupportPage();
                    },
                    transitionBuilder: (context, anim1, anim2, child) {
                      return SlideTransition(
                        position: Tween(
                                begin: const Offset(-1, 0),
                                end: const Offset(0, 0))
                            .animate(anim1),
                        child: child,
                      );
                    },
                  );
                }
              }),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColors.mainText.withAlpha(30)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Check it out <3",
                            style: TextStyle(
                                fontSize: 30,
                                letterSpacing: 2,
                                color: AppColors.mainText)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            const Center(
                child: Text(
              "Version 1.0.0",
              style: TextStyle(fontSize: 25, color: AppColors.mainText),
            )),
            const SizedBox(height: 20)
          ],
        ));
  }
}
