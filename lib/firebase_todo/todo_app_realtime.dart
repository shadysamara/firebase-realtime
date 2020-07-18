import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/firebase_todo/task_fbDatabase.dart';

class TodoHomePage extends StatefulWidget {
  @override
  _TodoHomePageState createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  DatabaseReference databaseReference;
  StreamSubscription newTaskStream;
  StreamSubscription updateTaskStream;
  StreamSubscription deleteTaskStream;
  List<TaskFirebaseDb> tasksList = [];
  onNewTask(Event event) {
    setState(() {
      tasksList.add(TaskFirebaseDb.fromSnapshot(event.snapshot));
    });
  }

  onUpdatedTask(Event event) {
    TaskFirebaseDb taskFirebaseDb = tasksList.singleWhere((element) {
      return element.key == event.snapshot.key;
    });
    setState(() {
      int index = tasksList.indexOf(taskFirebaseDb);
      tasksList[index] = TaskFirebaseDb.fromSnapshot(event.snapshot);
    });
  }

  onDeletedTask(Event event) {
    TaskFirebaseDb taskFirebaseDb = tasksList.singleWhere((element) {
      return element.key == event.snapshot.key;
    });
    setState(() {
      int index = tasksList.indexOf(taskFirebaseDb);
      tasksList.removeAt(index);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    databaseReference = FirebaseDatabase.instance.reference();
    newTaskStream =
        databaseReference.child('tasks').onChildAdded.listen((event) {
      onNewTask(event);
    });

    updateTaskStream =
        databaseReference.child('tasks').onChildChanged.listen((event) {
      onUpdatedTask(event);
    });

    deleteTaskStream =
        databaseReference.child('tasks').onChildRemoved.listen((event) {
      onDeletedTask(event);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    deleteTaskStream.cancel();
    updateTaskStream.cancel();
    newTaskStream.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Center(
            child: Column(
      children: <Widget>[
        Expanded(
            child: ListView.builder(
          itemCount: tasksList.length,
          itemBuilder: (context, index) {
            return ListTile(
              trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    databaseReference
                        .child('tasks')
                        .child(tasksList[index].key)
                        .remove();
                  }),
              title: Text(tasksList[index].title),
              leading: Checkbox(
                value: tasksList[index].isComplete,
                onChanged: (value) {
                  tasksList[index].isComplete = !tasksList[index].isComplete;
                  databaseReference
                      .child('tasks')
                      .child(tasksList[index].key)
                      .set(tasksList[index].toJson());
                },
              ),
            );
          },
        )),
        RaisedButton(onPressed: () {
          databaseReference
              .child('tasks')
              .push()
              .set(TaskFirebaseDb(title: 'tasks1').toJson());
        })
      ],
    )));
  }
}
