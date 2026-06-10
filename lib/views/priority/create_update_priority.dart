import 'package:flutter/material.dart';
import 'package:haris_backend/services/priority.dart';

import '../../models/priority.dart';

class CreateUpdatePriority extends StatefulWidget {
  final PriorityModel model;
  final bool isUpdatedMode ;
  const CreateUpdatePriority({super.key, required this.model, required this.isUpdatedMode});

  @override
  State<CreateUpdatePriority> createState() => _CreateUpdatePriorityState();
}

class _CreateUpdatePriorityState extends State<CreateUpdatePriority> {
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  @override
  void initState(){
    super.initState();
    if(widget.isUpdatedMode == true) {
      nameController = TextEditingController(
          text: widget.model.name.toString()
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isUpdatedMode ? "Update Priority" : "Create Priority"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hint: Text("Name"),
            ),
          ),
          isLoading ? Center(child: CircularProgressIndicator(),)
              :ElevatedButton(onPressed: ()async{
                try{
                  if(widget.isUpdatedMode == true){
                    await PriorityServices().updatePriority(
                      PriorityModel(
                        docId: widget.model.docId.toString(),
                        name: nameController.text.toString(),
                        createdAt: DateTime.now().millisecondsSinceEpoch,
                      )
                    ).then((value){
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
                      },);
                    });
                  }
                  else{
                    {
                      await PriorityServices().createPriority(
                          PriorityModel(
                            name: nameController.text.toString(),
                            createdAt: DateTime.now().millisecondsSinceEpoch,
                          )
                      ).then((value){
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
                        },);
                      });
                    }
                  }

                }catch(e){
                  isLoading = false;
                  setState(() {});
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
          }, child: Text(
            widget.isUpdatedMode ? "Update Priority" : "Create Priority"
          ))
        ],
      ),
    );
  }
}
