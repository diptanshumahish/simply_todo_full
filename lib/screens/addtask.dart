// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:simply_todo/database/database.dart';
import 'package:simply_todo/notifications/local_notifications.dart';
import 'package:simply_todo/screens/homescreen.dart';
import 'package:simply_todo/sharedprefrences.dart';
import 'package:simply_todo/utils/colors.dart';
import 'package:simply_todo/utils/todolist.dart';

TimeOfDay time = TimeOfDay.now();
bool isAlarm = false;

// ignore: must_be_immutable
class AddTask extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var username;
  // ignore: prefer_typing_uninitialized_variables
  var insertFunction;
  AddTask({Key? key, required this.insertFunction, required this.username})
      : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  late final LocalNotificationService service;
  @override
  void initState() {
    service = LocalNotificationService();
    service.initialize();
    super.initState();
  }

  void loadPref() async {
    setState(() {});
  }

  var db = DatabaseConnect();
  void addItem(Todo todo) async {
    await db.insertTodo(todo);
    setState(() {});
  }

  final titleController = TextEditingController();
  final taskController = TextEditingController();
  bool state = false;
  @override
  Widget build(BuildContext context) {
    final topColor = Theme.of(context).brightness;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: SafeArea(
          child: Center(
              child: Container(
            // ignore: sort_child_properties_last
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                CupertinoIcons.back,
                                color: AppColors.mainText,
                              )),
                          const Text("Add Todo",
                              style: TextStyle(
                                  color: AppColors.mainText,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30)),
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(showPicker(
                              displayHeader: true,
                              accentColor: AppColors.secondary,
                              focusMinutePicker: true,
                              blurredBackground: true,
                              cancelStyle: TextStyle(
                                  color: topColor == Brightness.dark
                                      ? AppColors.mainText
                                      : AppColors.mainLightText,
                                  letterSpacing: 2,
                                  fontSize: 25,
                                  fontFamily:
                                      GoogleFonts.amaticSc().fontFamily),
                              okStyle: TextStyle(
                                  color: topColor == Brightness.dark
                                      ? AppColors.mainText
                                      : AppColors.mainLightText,
                                  letterSpacing: 2,
                                  fontSize: 25,
                                  fontFamily:
                                      GoogleFonts.amaticSc().fontFamily),
                              context: context,
                              value: time,
                              onChange: (TimeOfDay newTime) {
                                time = newTime;
                                isAlarm = true;
                                setState(() {});
                              },
                              minuteInterval: MinuteInterval.ONE,
                            ));
                          },
                          icon: const Icon(
                            CupertinoIcons.alarm,
                            color: AppColors.mainText,
                          ))
                    ],
                  ),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width - 10,
                    color: AppColors.mainLightText,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Add the title of your task",
                      style:
                          TextStyle(color: AppColors.mainText, fontSize: 25)),
                  const SizedBox(
                    height: 10,
                  ),
                  CupertinoTextField(
                    decoration: BoxDecoration(
                        color: AppColors.mainText,
                        borderRadius: BorderRadius.circular(6)),
                    controller: titleController,
                    cursorColor: AppColors.secondary,
                    autofocus: true,
                    style: const TextStyle(color: AppColors.mainLightText),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Add your task here",
                      style:
                          TextStyle(color: AppColors.mainText, fontSize: 25)),
                  const SizedBox(
                    height: 10,
                  ),
                  CupertinoTextField(
                    decoration: BoxDecoration(
                        color: AppColors.mainText,
                        borderRadius: BorderRadius.circular(6)),
                    style: const TextStyle(color: AppColors.mainLightText),
                    controller: taskController,
                    cursorColor: AppColors.secondary,
                    maxLines: 4,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.themeColor),
                      ),
                      child: const Center(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 70, vertical: 5),
                          child: Text("Add", style: TextStyle(fontSize: 25)),
                        ),
                      ),
                      onPressed: () async {
                        var newtodo = Todo(
                            isImp: 1,
                            title: titleController.text,
                            creationDate: DateTime.now(),
                            task: taskController.text);
                        addItem(newtodo);
                        const TodoList();
                        AddTask(
                            username: widget.username, insertFunction: () {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomePage(user: username)));
                        if (isAlarm) {
                          await service.initialize();
                          setState(() {
                            service.showScheduleNotification(
                                id: 10,
                                title: titleController.text.toString(),
                                body: taskController.text.toString(),
                                minutes: (time.hour * 60 + time.minute) -
                                    (DateTime.now().hour * 60 +
                                        DateTime.now().minute));
                          });
                        }
                      }),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      "tap on the '\u{23F0}'  icon , and I'll remind you to complete your task:)",
                      maxLines: 2,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.5,
                          color: AppColors.mainText.withAlpha(150),
                          fontSize: 23))
                ],
              ),
            ),
            decoration: BoxDecoration(
                color: AppColors.secondary,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(1, 1), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(10)),
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width - 50,
          )),
        ),
      ),
    );
  }
}
