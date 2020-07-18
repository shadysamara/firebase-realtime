// import 'dart:async';
// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:login_firebase/firebase_todo/models/task_model.dart';

// class FirebaseDbTodo extends StatefulWidget {
//   @override
//   _FirebaseDbTodoState createState() => _FirebaseDbTodoState();
// }

// class _FirebaseDbTodoState extends State<FirebaseDbTodo> {
//   List<TaskModel> tasksList = [];
//   List<TaskModel> completeTaskList = [];

//   StreamSubscription onAddedTaskListener;

//   StreamSubscription onChangedTaskListener;

//   @override
//   void initState() {
//     super.initState();
//     DatabaseReference databaseReference =
//         FirebaseDatabase.instance.reference().child('TODO');

//     onAddedTaskListener = databaseReference
//         .orderByChild('isComplete')
//         .equalTo(false)
//         .onChildAdded
//         .listen((event) {
//       newTaskEventHandler(event);
//     });
//     onChangedTaskListener = databaseReference.onChildChanged.listen((event) {
//       updateTaskEventHandler(event);
//     });
//   }

//   newTaskEventHandler(Event event) {
//     setState(() {
//       tasksList.add(TaskModel.fromJson(event.snapshot));
//     });
//   }

//   updateTaskEventHandler(Event event) {
//     TaskModel taskModel = tasksList.singleWhere((element) {
//       return element.key == event.snapshot.key;
//     });
//     setState(() {
//       tasksList[tasksList.indexOf(taskModel)] =
//           TaskModel.fromJson(event.snapshot);
//     });
//   }

//   addNewTask(TaskModel taskModel) {
//     FirebaseDatabase.instance
//         .reference()
//         .child('TODO')
//         .push()
//         .set(taskModel.toJson());
//   }

//   updateTask(TaskModel taskModel) {
//     taskModel.isComplete = !taskModel.isComplete;
//     FirebaseDatabase.instance
//         .reference()
//         .child('TODO')
//         .child(taskModel.key)
//         .set(taskModel.toJson());
//   }

//   removeTask(TaskModel taskModel) {
//     FirebaseDatabase.instance
//         .reference()
//         .child('TODO')
//         .child(taskModel.key)
//         .remove();
//     setState(() {
//       tasksList.removeAt(tasksList.indexOf(taskModel));
//     });
//   }

//   getAllTasks() async {
//     DataSnapshot dataSnapshot =
//         await FirebaseDatabase.instance.reference().child('TODO').once();
//     print(json.encode(dataSnapshot.value));
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('TODO'),
//         ),
//         body: ListView.builder(
//           itemCount: tasksList.length,
//           itemBuilder: (context, index) {
//             return ListTile(
//               title: Text(tasksList[index].title),
//               trailing: Checkbox(
//                 value: tasksList[index].isComplete,
//                 onChanged: (value) {
//                   updateTask(tasksList[index]);
//                 },
//               ),
//               leading: IconButton(
//                   icon: Icon(Icons.delete),
//                   onPressed: () {
//                     removeTask(tasksList[index]);
//                   }),
//             );
//           },
//         ));
//   }
// }
