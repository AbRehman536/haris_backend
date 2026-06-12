import 'package:flutter/material.dart';
import 'package:haris_backend/models/task.dart';
import 'package:haris_backend/services/task.dart';
import 'package:provider/provider.dart';

class GetAllFavoriteTask extends StatelessWidget {
  const GetAllFavoriteTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Task"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: StreamProvider.value(
          value: TaskService().getAllFavoriteTask("101"),
          initialData: [TaskModel()],
          builder: (context,child){
            List<TaskModel> taskList = context.watch<List<TaskModel>>();
            return ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.favorite,color: Colors.red,),
                title: Text(taskList[index].title.toString()),
                subtitle: Text(taskList[index].description.toString()),
              );
            },);
          },
      ),
    );
  }
}
