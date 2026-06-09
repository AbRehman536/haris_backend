import 'package:flutter/material.dart';
import 'package:haris_backend/services/task.dart';

import '../../models/task.dart';

class UpdateTask extends StatefulWidget {
  final TaskModel model;
  const UpdateTask({super.key, required this.model});

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;
  @override
  void initState(){
    super.initState();
    titleController = TextEditingController(
      text: widget.model.title.toString()
    );
    descriptionController = TextEditingController(
      text: widget.model.description.toString()
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Task"),
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
              await TaskService().updateTask(
                  TaskModel(
                    docId: widget.model.docId.toString(),
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
                    content: Text("Update Successfully"),
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
          }, child: Text("Update Task"))
        ],
      ),
    );
  }
}
