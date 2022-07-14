import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simply_todo/database/database.dart';
import 'package:simply_todo/screens/homescreen.dart';
import 'package:simply_todo/sharedprefrences.dart';
import 'package:simply_todo/utils/colors.dart';

class FullScreenCard extends StatefulWidget {
  final int id;
  final int isImp;
  final String task;
  final String title;
  final DateTime creationDate;

  const FullScreenCard({
    Key? key,
    required this.id,
    required this.isImp,
    required this.task,
    required this.title,
    required this.creationDate,
  }) : super(key: key);

  @override
  State<FullScreenCard> createState() => _FullScreenCardState();
}

class _FullScreenCardState extends State<FullScreenCard> {
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

    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.secondary,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
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
                          Text(widget.title,
                              style: const TextStyle(
                                  color: AppColors.mainText,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30)),
                        ],
                      ),
                      const Icon(
                        CupertinoIcons.heart,
                        color: AppColors.mainText,
                      ),
                    ],
                  ),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width - 10,
                    color: AppColors.mainLightText,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.mainText.withAlpha(50)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Your Task:",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: AppColors.mainText,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2),
                                ),
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
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    AppColors.themeColor),
                              ),
                              onPressed: () {
                                deleteItem(anotherTodo);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage(
                                              user: username,
                                            )));
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text("Delete!",
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 30, letterSpacing: 1)),
                                    SizedBox(width: 20),
                                    Icon(Icons.clear)
                                  ],
                                ),
                              )),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
