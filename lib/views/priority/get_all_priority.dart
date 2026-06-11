import 'package:flutter/material.dart';
import 'package:haris_backend/models/priority.dart';
import 'package:haris_backend/services/priority.dart';
import 'package:haris_backend/views/priority/create_update_priority.dart';
import 'package:haris_backend/views/priority/get_priorities.dart';
import 'package:provider/provider.dart';

class GetAllPriority extends StatelessWidget {
  const GetAllPriority({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Priority"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateUpdatePriority(model: PriorityModel(), isUpdatedMode: false)));
      },child: Icon(Icons.add),),
      body: StreamProvider.value(
          value: PriorityServices().getAllPriority(),
          initialData: [PriorityModel()],
          builder: (context, child){
            List<PriorityModel> priorityList = context.watch<List<PriorityModel>>();
            return ListView.builder(
              itemCount: priorityList.length,
              itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.priority_high),
                title: Text(priorityList[index].name.toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: ()async{
                      try{
                        await PriorityServices().deletePriority(
                          priorityList[index].docId.toString()
                        );
                      }catch(e){
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    }, icon: Icon(Icons.delete,color: Colors.red,)),
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateUpdatePriority(model: PriorityModel(), isUpdatedMode: true)));
                    }, icon: Icon(Icons.edit,color: Colors.blue,)),
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> GetPriorities(model: priorityList[index])));
                    }, icon: Icon(Icons.arrow_forward_ios,color: Colors.green,))
                  ],
                ),
              );
            },);
          },
      ),
    );
  }
}
