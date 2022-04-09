import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  var taskcollections = FirebaseFirestore.instance.collection('tasks');

  Future insertTask(String tasks) async {
    return await taskcollections.doc(uid).collection('tasks').add({
      'tasks': tasks,
      'time': DateTime.now(),
    });
  }

  Future updateTask(String tasks, DocumentSnapshot documentSnapshot) async {
    return await taskcollections
        .doc(uid)
        .collection('tasks')
        .doc(documentSnapshot.id)
        .update({
      'tasks': tasks,
      'time': DateTime.now(),
    });
  }

  Future deleteTask(String tasks, DocumentSnapshot documentSnapshot) async {
    return await taskcollections
        .doc(uid)
        .collection('tasks')
        .doc(documentSnapshot.id)
        .delete();
  }

  Stream get taskData {
    return taskcollections
        .doc(uid)
        .collection('tasks')
        .orderBy('time')
        .snapshots();
  }
}
