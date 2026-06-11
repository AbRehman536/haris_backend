import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/task.dart';

class TaskService{
  String taskCollection = "TaskCollection";

  ///Create Task
  Future createTask(TaskModel model)async{
    DocumentReference documentReference =
    await FirebaseFirestore.instance
    .collection(taskCollection)
    .doc();
   return await FirebaseFirestore.instance
       .collection(taskCollection)
       .doc(documentReference.id)
       .set(model.toJson(documentReference.id));
  }
  ///Update Task
  Future updateTask(TaskModel model)async{
    return await FirebaseFirestore.instance
        .collection(taskCollection)
        .doc(model.docId)
        .update({"title" : model.title, "description" : model.description});
  }
  ///Delete Task
  Future deleteTask(String taskID)async{
    return await FirebaseFirestore.instance
        .collection(taskCollection)
        .doc(taskID)
        .delete();
  }
  ///Mark As Completed
  Future markAsCompletedTask(String taskID, bool isCompleted)async{
    return await FirebaseFirestore.instance
        .collection(taskCollection)
        .doc(taskID)
        .update({"isCompleted" : isCompleted,});
  }
  ///Get All Task
  Stream<List<TaskModel>> getAllTask(){
    return FirebaseFirestore.instance
        .collection(taskCollection)
        .snapshots()
        .map((taskList) => taskList.docs
        .map((taskJson) => TaskModel.fromJson(taskJson.data())).toList());
  }
  ///Get Completed Task
  Stream<List<TaskModel>> getCompletedTask(){
    return FirebaseFirestore.instance  //Connection with firebase firestore
        .collection(taskCollection) //Table-Collection Name
        .where("isCompleted", isEqualTo: true) // Query Condition
        .snapshots() // Real Time Updated Data Show
        .map((taskList) => taskList.docs // Copy Document Data and store in taskList Variable
        .map((taskJson) => TaskModel.fromJson(taskJson.data())).toList()); // Convert Json Data to TaskModel
  }
  ///Get InCompleted Task
  Stream<List<TaskModel>> getInCompletedTask(){
    return FirebaseFirestore.instance
        .collection(taskCollection)
        .where("isCompleted", isEqualTo: false)
        .snapshots()
        .map((taskList) => taskList.docs
        .map((taskJson) => TaskModel.fromJson(taskJson.data())).toList());
  }
  ///Get Task by Priority ID
  Stream<List<TaskModel>> getTaskByPriorityID(String priorityID)
  {
    return  FirebaseFirestore.instance
        .collection(taskCollection)
        .where("priorityID", isEqualTo: priorityID)
        .snapshots()
        .map((taskList) => taskList.docs
        .map((taskJson) => TaskModel.fromJson(taskJson.data())).toList());
  }
}