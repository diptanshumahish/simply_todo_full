// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:simply_todo/notifications/local_notifications.dart';
import 'package:simply_todo/screens/addtask.dart';
import 'package:simply_todo/sharedprefrences.dart';
import 'package:simply_todo/utils/colors.dart';
import 'package:simply_todo/utils/drawer.dart';
import 'package:simply_todo/utils/todolist.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  late var user;
  HomePage({Key? key, this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final LocalNotificationService service;

  final myController = TextEditingController();
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    username = widget.user;
    service = LocalNotificationService();
    service.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final topColor = Theme.of(context).brightness;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        // ignore: sort_child_properties_last
        child: Icon(
          CupertinoIcons.add_circled,
          size: 50,
          color: (topColor == Brightness.dark) ? Colors.white : Colors.black,
        ),
        backgroundColor: AppColors.transparent,
        elevation: 0,
        onPressed: () {
          {
            showGeneralDialog(
              barrierLabel: "Label",
              barrierDismissible: false,
              barrierColor: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
              transitionDuration: const Duration(milliseconds: 350),
              context: context,
              pageBuilder: (context, anim1, anim2) {
                return AddTask(
                  username: username,
                  insertFunction: () {},
                );
              },
              transitionBuilder: (context, anim1, anim2, child) {
                return SlideTransition(
                  position:
                      Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
                          .animate(anim1),
                  child: child,
                );
              },
            );
          }
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.transparent,
        title: Center(
          child: Row(
            children: const [
              Text(
                "Simply",
                style: TextStyle(
                    letterSpacing: 2,
                    color: AppColors.themeColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
              ),
              Text("Todo",
                  style: TextStyle(
                      letterSpacing: 2,
                      color: AppColors.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 40))
            ],
          ),
        ),
        leading: Builder(
            builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(
                  CupertinoIcons.bars,
                  size: 27,
                ),
                color: topColor != Brightness.dark
                    ? AppColors.mainLightText
                    : AppColors.mainText)),
        actions: [
          IconButton(
            onPressed: () async {
              {
                showGeneralDialog(
                  barrierLabel: "Label",
                  barrierDismissible: false,
                  barrierColor:
                      const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                  transitionDuration: const Duration(milliseconds: 200),
                  context: context,
                  pageBuilder: (context, anim1, anim2) {
                    return AddTask(
                      username: username,
                      insertFunction: () {},
                    );
                  },
                  transitionBuilder: (context, anim1, anim2, child) {
                    return SlideTransition(
                      position: Tween(
                              begin: const Offset(0, 1),
                              end: const Offset(0, 0))
                          .animate(anim1),
                      child: child,
                    );
                  },
                );
              }
            },
            icon: const Icon(
              CupertinoIcons.add,
              size: 27,
            ),
            color: topColor != Brightness.dark
                ? AppColors.mainLightText
                : AppColors.mainText,
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome,",
                style: TextStyle(
                    color: topColor != Brightness.dark
                        ? AppColors.mainLightText
                        : AppColors.mainText,
                    letterSpacing: 0.9,
                    fontSize: 35),
              ),
              Text(
                username.toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.5,
                    color: AppColors.themeColor,
                    fontSize: 45),
              ),
              Text(
                "hope you are doing well!",
                style: TextStyle(
                    letterSpacing: 0.9,
                    color: topColor != Brightness.dark
                        ? AppColors.mainLightText
                        : AppColors.mainText,
                    fontSize: 35),
              ),
              const TodoList(),
            ],
          ),
        ),
      ),
      drawer: const NavigationDrawer(),
    );
  }
}
