import 'package:flutter/material.dart';
import 'package:haris_backend/services/auth.dart';
import 'package:haris_backend/services/user.dart';
import 'package:haris_backend/views/auth/forget_password.dart';
import 'package:haris_backend/views/auth/register.dart';
import 'package:haris_backend/views/tasks/get_all_task.dart';
import 'package:provider/provider.dart';

import '../../provider/user_provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hint: Text("Email"),
            ),
          ),
          TextField(
            decoration: InputDecoration(
              hint: Text("Password"),
            ),
          ),
          isLoading ? Center(child: CircularProgressIndicator(),):
          ElevatedButton(onPressed: ()async{
            try{
              await AuthServices().loginUser(
                  email: emailController.text,
                  password: passwordController.text)
                  .then((value)async{
                    if(value.emailVerified == true){
                      await UserServices().getUserByID(value.uid)
                      .then((userModel){
                        Provider.of<UserProvider>(context, listen: false).setUser(userModel);
                        isLoading = false;
                        setState(() {});
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> GetAllTask()));
                    }else{
                      isLoading = false;
                      setState(() {});
                      showDialog(context: context, builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text("Please Verify Your Email"),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                            }, child: Text("Ok"))
                          ],
                        );
                      },);
                    }
              });
            }catch(e){
              isLoading = false;
              setState(() {});
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(e.toString())));
            }
          }, child: Text("Login")),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Register()));
          }, child: Text("Register")),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgetPassword()));
          }, child: Text("Forget Password")),
        ],
      ),
    );
  }
}
