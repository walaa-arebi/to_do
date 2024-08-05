import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do/features/tasks/model/task_model.dart';

class DataBaseService {

  final CollectionReference todoCollection = FirebaseFirestore.instance
      .collection("todos");
  User? user = FirebaseAuth.instance.currentUser;

  Future<DocumentReference> addTodoTask(String todoTask) async {
    return await todoCollection.add({
      'uid': user!.uid,
      'task': todoTask,
      'completed': false,
      'createdAt': Timestamp.now(),
    });
  }

  // Future<void> updateTodo(String id, String task) async {
  //   final updateTodoCollection = FirebaseFirestore.instance.collection("todos")
  //       .doc(id);
  //   return await updateTodoCollection.update({
  //     'task': task
  //   });
  // }


  Future<void> updateTodoStatus(String id, bool completed) async {
    return await todoCollection.doc(id).update({
      'completed': completed
    });
  }

  Future<void> deleteTodo(String id) async {
    return await todoCollection.doc(id).delete();
  }

  Stream<List<Task>> get todos {
    return todoCollection.where('uid', isEqualTo: user!.uid).snapshots().map(
        _todoListFromSnapshot);
  }


  List<Task> _todoListFromSnapshot(QuerySnapshot snapshot) {
   return snapshot.docs.map((doc) {
      return Task(
          id:doc.id,
          taskContent:doc['task'],
          isChecked:doc['completed'],
        createdAt: doc['createdAt']
      );
    }).toList()..sort((a, b) => b.createdAt.compareTo(a.createdAt));


  }
}