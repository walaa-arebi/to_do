import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String id;
  String taskContent;
  bool isChecked;
  Timestamp createdAt;


  Task({required this.id, required this.taskContent, required this.isChecked,required this.createdAt});
}