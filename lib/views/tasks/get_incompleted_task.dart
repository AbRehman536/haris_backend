import 'package:flutter/material.dart';
import 'package:haris_backend/models/task.dart';
import 'package:haris_backend/services/task.dart';
import 'package:haris_backend/views/tasks/create_task.dart';
import 'package:haris_backend/views/tasks/update_task.dart';
import 'package:provider/provider.dart';

class GetInCompletedTask extends StatelessWidget {
  const GetInCompletedTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get InCompleted Task"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,

      ),
      body: StreamProvider.value(
        value: TaskService().getInCompletedTask(),
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
