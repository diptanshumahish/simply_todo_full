import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simply_todo/database/database.dart';
import 'package:simply_todo/screens/fullscreentask.dart';
import 'package:simply_todo/sharedprefrences.dart';
import 'package:simply_todo/utils/colors.dart';

import 'homescreen.dart';

class AddTask extends StatefulWidget {
  final int id;
  final int isImp;
  final String task;
  final String title;
  final DateTime creationDate;
  final Function inserFunction;
  final Function deleteFunction;
  const AddTask(
      {Key? key,
      required this.id,
      required this.isImp,
      required this.task,
      required this.title,
      required this.creationDate,
      required this.inserFunction,
      required this.deleteFunction})
      : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    var anotherTodo = Todo(
        id: widget.id,
        isImp: widget.isImp,
        title: widget.title,
        creationDate: widget.creationDate,
        task: widget.task);
    var db = DatabaseConnect();
    void deleteItem(Todo todo) async {
      await db.deletTodo(todo);
      setState(() {});
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
          decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 10,
                    width: 10,
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                  ),
                ),
                Flexible(
                  child: InkWell(
                    onTap: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => FullScreenCard(
                                    title: widget.title,
                                    task: widget.task,
                                    creationDate: widget.creationDate,
                                    id: widget.id,
                                    isImp: widget.isImp,
                                  ))));
                    }),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          widget.task,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 30,
                              color: AppColors.mainText,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          DateFormat('jm').format(widget.creationDate),
                          style: const TextStyle(
                              fontSize: 25,
                              color: AppColors.mainText,
                              letterSpacing: 1.5),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      deleteItem(anotherTodo);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage(
                                    user: username,
                                  )));
                    },
                    icon: const Icon(CupertinoIcons.delete)),
              ],
            ),
          )),
    );
  }
}
