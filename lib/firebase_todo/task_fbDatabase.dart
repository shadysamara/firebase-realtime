import 'package:firebase_database/firebase_database.dart';

class TaskFirebaseDb {
  String key;
  String title;
  bool isComplete;
  TaskFirebaseDb({this.isComplete = false, this.key, this.title});
  TaskFirebaseDb.fromSnapshot(DataSnapshot dataSnapshot) {
    this.key = dataSnapshot.key;
    this.title = dataSnapshot.value['title'];
    this.isComplete = dataSnapshot.value['isComplete'];
  }
  toJson() {
    return {'title': this.title, 'isComplete': this.isComplete};
  }
}
