import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_1/admin/add_quiz.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding:const EdgeInsets.only(top: 45,left: 20,right: 20),
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/2),
                  decoration: BoxDecoration(
                    gradient:const  LinearGradient(
                        colors: [Color.fromARGB(255, 53, 51, 51),Colors.black,],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.vertical(top: Radius.elliptical(MediaQuery.of(context).size.width,110 ))
                  ),
                ),
          Container(
            margin: EdgeInsets.only(top: 60,left: 30,right: 30),

            child:  Form(
                child:Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                const Text("Let's start with Admin",style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),),
                    const SizedBox(height: 30,),
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: MediaQuery.of(context).size.height/2.2,
                         decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(20)
                         ),
                      child: Column(
                        children: [
                          const SizedBox(height: 50,),
                          Container(
                            padding: EdgeInsets.only(top: 5.0,left: 20,right: 20),
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              border:Border.all(
                                color: Color.fromARGB(255, 160, 160, 147),
                              ),
                              borderRadius: BorderRadius.circular(10)
                            ),
                                  child: Center(child:
                                  TextFormField(
                                    controller: _email,
                                    validator: (value){
                                      if(value==null|| value.isEmpty){
                                        return 'Please Enter Username';
                                      }
                                    },
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "username",
                                      hintStyle: TextStyle(
                                        color: Color.fromARGB(255, 160, 160, 147)
                                      )
                                    ),

                                  ),),
                          ),
                          const SizedBox(height: 40,),
                          Container(
                            padding: EdgeInsets.only(top: 5.0,left: 20,right: 20),
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              border:Border.all(
                                color: Color.fromARGB(255, 160, 160, 147),
                              ),
                              borderRadius: BorderRadius.circular(10)
                            ),
                                  child: Center(child:
                                  TextFormField(
                                    controller: _password,
                                    validator: (value){
                                      if(value==null|| value.isEmpty){
                                        return 'Please Enter Password';
                                      }
                                    },
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "password",
                                      hintStyle: TextStyle(
                                        color: Color.fromARGB(255, 160, 160, 147)
                                      )
                                    ),

                                  ),),
                          ),
                          const SizedBox(height: 40.0,),
                          InkWell(
                            onTap: (){
                                    loginAdmin();
                              },
                            child: Container(
                              padding:const EdgeInsets.symmetric(vertical: 12.0),
                              margin:const EdgeInsets.symmetric(horizontal: 20.0),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child:const Center(child: Text("LogIn",

                                style:TextStyle(color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold) ,),
                              ),
                            ),
                          )

                        ],
                      ),
                       
                       ),
                    )


            ],) ),
          )

        ],),
      ),
    );

  }
  TextEditingController _email=TextEditingController();
  TextEditingController _password=TextEditingController();
  loginAdmin(){
    FirebaseFirestore.instance.collection("admin").get().then((snapshot){
      snapshot.docs.forEach((result) {
        if(result.data()['email']!=_email.text.trim()){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content:Text("Incorrect Email",style: TextStyle(
                fontSize: 18.0
              ),)));
        }else if(result.data()['password']!=_password.text.trim()){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content:Text("Incorrect Password",style: TextStyle(
                  fontSize: 18.0
              ),)));
        }else{
          Navigator.push(context, MaterialPageRoute(builder:(context)=>const AddQuiz()));
        }
      });
    });
  }
}
