import 'package:flutter/material.dart';
import 'package:haris_backend/models/task.dart';
import 'package:haris_backend/services/task.dart';
import 'package:haris_backend/views/priority/get_all_priority.dart';
import 'package:haris_backend/views/profile/get_profile.dart';
import 'package:haris_backend/views/tasks/create_task.dart';
import 'package:haris_backend/views/tasks/get_all_favorite_task.dart';
import 'package:haris_backend/views/tasks/get_completed_task.dart';
import 'package:haris_backend/views/tasks/get_incompleted_task.dart';
import 'package:haris_backend/views/tasks/update_task.dart';
import 'package:provider/provider.dart';

class GetAllTask extends StatelessWidget {
  const GetAllTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Task"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetAllFavoriteTask()));
          }, icon: Icon(Icons.favorite)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetCompletedTask()));
          }, icon: Icon(Icons.circle)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetInCompletedTask()));
          }, icon: Icon(Icons.incomplete_circle)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetAllPriority()));
          }, icon: Icon(Icons.priority_high)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetProfile()));
          }, icon: Icon(Icons.person)),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateTask()));
      },child: Icon(Icons.add),),
      body: StreamProvider.value(
          value: TaskService().getAllTask(),
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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: ()async{
                        if(taskList[index].favorite!.contains("101")){
                          await TaskService().removeFromFavorite(
                              taskID: taskList[index].docId.toString(),
                              userID: "101");
                        }
                        else{
                          await TaskService().addToFavorite(
                              taskID: taskList[index].docId.toString(),
                              userID: "101");
                        }
                      }, icon: Icon(taskList[index].favorite!.contains("101") ? Icons.favorite : Icons.favorite_border,color: Colors.red,)),
                      Checkbox(
                          value: taskList[index].isCompleted,
                          onChanged: (value){
                            TaskService().markAsCompletedTask(taskList[index].docId.toString(), value!);
                          }),
                      IconButton(onPressed: ()async{
                        try{
                          await TaskService().deleteTask(taskList[index].docId.toString());
                        }catch(e){
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      }, icon: Icon(Icons.delete,color: Colors.red,)),
                      IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateTask(model: taskList[index])));
                      }, icon: Icon(Icons.edit,color: Colors.green,))
                    ],
                  ),
                );
              },);
        },


      ),
    );
  }
}
