import 'package:flutter/material.dart';
import 'package:haris_backend/services/task.dart';

import '../../models/task.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Task"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              hint: Text("Title"),
            ),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              hint: Text("Description"),
            ),
          ),
          isLoading ? Center(child: CircularProgressIndicator(),)
          : ElevatedButton(onPressed: ()async{
            try{
              isLoading = true;
              setState(() {});
              await TaskService().createTask(
                TaskModel(
                  title: titleController.text,
                  description: descriptionController.text,
                  isCompleted: false,
                  createdAt: DateTime.now().millisecondsSinceEpoch,
                )
              ).then((value){
                isLoading = false;
                setState(() {});
                showDialog(context: context, builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text("Create Successfully"),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }, child: Text("Ok"))
                    ],
                  );
                }, );
              });
            }catch(e){
              isLoading = false;
              setState(() {});
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(e.toString())));
            }
          }, child: Text("Create Task"))
        ],
      ),
    );
  }
}
