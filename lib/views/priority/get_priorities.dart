import 'package:flutter/material.dart';
import 'package:haris_backend/models/priority.dart';
import 'package:haris_backend/models/task.dart';
import 'package:haris_backend/services/task.dart';
import 'package:provider/provider.dart';

class GetPriorities extends StatelessWidget {
  final PriorityModel model;
  const GetPriorities({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${model.name.toString()} Task"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: StreamProvider.value(
          value: TaskService().getTaskByPriorityID(model.docId.toString()),
          initialData: [TaskModel()],
          builder: (context,child){
            List<TaskModel> taskList = context.watch<List<TaskModel>>();
            return ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.task),
                title: Text(taskList[index].title.toString()),
                subtitle: Text(taskList[index].description.toString()),
              );
            },);
          },
      ),
    );
  }
}
