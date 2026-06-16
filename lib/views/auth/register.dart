import 'package:flutter/material.dart';
import 'package:haris_backend/models/user.dart';
import 'package:haris_backend/services/auth.dart';
import 'package:haris_backend/services/user.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Register"),
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
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              hint: Text("Email"),
            ),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              hint: Text("Password"),
            ),
          ),
          TextField(
            controller: phoneController,
            decoration: InputDecoration(
              hint: Text("Phone"),
            ),
          ),
          TextField(
            controller: addressController,
            decoration: InputDecoration(
              hint: Text("Address"),
            ),
          ),
          isLoading ? Center(child: CircularProgressIndicator(),):
          ElevatedButton(onPressed: ()async{
            try{
              isLoading = true;
              setState(() {});
              await AuthServices().registerUser(
                  email: emailController.text,
                  password: passwordController.text)
                  .then((value)async{
                    await UserServices().createUser(
                      UserModel(
                        docId: value.uid.toString(),
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                        address: addressController.text,
                        createdAt: DateTime.now().millisecondsSinceEpoch,
                      )
                    );
              }).then((val){
                isLoading = false;
                setState(() {});
                showDialog(context: context, builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text("Register Successfully"),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }, child: Text("Ok"))
                    ],
                  );
                });
              });
            }catch(e){
              isLoading = false;
              setState(() {});
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(e.toString())));
            }
          }, child: Text("Register"))
        ],
      ),
    );
  }
}
