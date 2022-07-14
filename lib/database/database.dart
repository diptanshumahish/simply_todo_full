import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Todo {
  int? id;
  final int isImp;
  final String title;
  DateTime creationDate;
  final String task;

  Todo(
      {this.id,
      required this.isImp,
      required this.title,
      required this.creationDate,
      required this.task});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'isImp': isImp,
      'title': title,
      'creationDate': creationDate.toString(),
      'task': task
    };
  }

  @override
  String toString() {
    return 'Todo{id: $id,isImp:$isImp,title:$title,creationDate:$creationDate:$task}';
  }
}

class DatabaseConnect {
  Database? _database;
  Future<Database> get database async {
    final dbpath = await getDatabasesPath();
    const dbname = 'todo.db';
    final path = join(dbpath, dbname);

    _database = await openDatabase(path, version: 1, onCreate: _createDb);

    return _database!;
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
CREATE TABLE todo(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  isImp INTEGER,
  title TEXT,
  creationDate TEXT,
  task TEXT
)

''');
  }

  //FUNCTION TO ADD DATA
  Future<void> insertTodo(Todo todo) async {
    final db = await database;
    await db.insert('todo', todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //FUNCTION TO DELETE A todo
  Future<void> deletTodo(Todo todo) async {
    final db = await database;
    await db.delete(
      'todo',
      where: 'id==?', //will check for id
      whereArgs: [todo.id],
    );
  }

  //fetch data
  Future<List<Todo>> getTodo() async {
    final db = await database;
    List<Map<String, dynamic>> items =
        await db.query('todo', orderBy: 'id DESC');
    //convert maps to list of todo
    return List.generate(
        items.length,
        (i) => Todo(
            id: items[i]['id'],
            isImp: items[i]['isImp'],
            title: items[i]['title'],
            creationDate: DateTime.parse(items[i]['creationDate']),
            task: items[i]['task']));
  }
}
