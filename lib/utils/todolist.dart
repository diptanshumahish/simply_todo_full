// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:simply_todo/database/database.dart';
import 'package:simply_todo/screens/taskcards.dart';
import 'package:simply_todo/utils/colors.dart';

class TodoList extends StatefulWidget {
  const TodoList({
    Key? key,
  }) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  var db = DatabaseConnect();
  void addItem(Todo todo) async {
    await db.insertTodo(todo);
    setState(() {});
  }

  void deleteItem(Todo todo) async {
    await db.deletTodo(todo);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final topColor = Theme.of(context).brightness;
    return FutureBuilder(
      future: db.getTodo(),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        var data = snapshot.data;
        var dataLength = data!.length;
        return dataLength == 0
            ? Text(
                "You haven't created any todo!, Tap on the '+' icon to add one!",
                style: TextStyle(
                    letterSpacing: 1,
                    fontSize: 25,
                    color: topColor != Brightness.dark
                        ? AppColors.mainLightText
                        : AppColors.mainText.withAlpha(180)))
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: dataLength,
                itemBuilder: (context, i) => AddTask(
                    id: data[i].id,
                    isImp: data[i].isImp,
                    task: data[i].task,
                    title: data[i].title,
                    creationDate: data[i].creationDate,
                    inserFunction: () {},
                    deleteFunction: () {}));
      },
    );
  }
}
