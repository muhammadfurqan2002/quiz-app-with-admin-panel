import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_1/firebase_services/data_base.dart';
import 'package:random_string/random_string.dart';


class AddQuiz extends StatefulWidget {
  const AddQuiz({super.key});

  @override
  State<AddQuiz> createState() => _AddQuizState();
}

class _AddQuizState extends State<AddQuiz> {

  uploadItem()async{
      if(image!=null &&
          _option1.text!=""
          && _option1.text!=""
          && _option2.text!=""
          && _option3.text!=""
          && _option4.text!=""
      ){
          String id=randomAlphaNumeric(10);
          Reference firebaseStorageRef=FirebaseStorage.instance.ref().child("blogImage").child(id);
          final UploadTask task=firebaseStorageRef.putFile(image!);
          var downloadUrl=await (await task).ref.getDownloadURL();
          Map<String,dynamic> addQuiz={
            "Image":downloadUrl,
            "option1":_option1.text,
            "option2":_option2.text,
            "option3":_option3.text,
            "option4":_option4.text,
            "correct":_CorrectAnswer.text,
          };
            
          await DataBaseMethod().addQuizCategory(addQuiz, value!).then((value){
                          print('Quiz has been added successfully');
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Colors.orange,
                    content: Text("Quiz has been added successfully",style: TextStyle(fontSize: 18.0),)));
          });

      }
      print(_option1.text);
      print(_option2.text);
  }
  
  String? value;
   final List<String> quizItem=["Animal","Sports","Random","Fruits"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Add Quiz",style: TextStyle(color:Colors.black,fontSize: 30 ,fontWeight: FontWeight.bold),),
      centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin:const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const Text("Upload the Quiz Picture",style: TextStyle(
              color: Colors.black54,fontWeight: FontWeight.bold,
              fontSize: 20
            ),),
            const SizedBox(height: 20,),
            Center(child: Material(
              elevation: 4.0,
              borderRadius: BorderRadius.circular(20),
              child: GestureDetector(
                onTap: (){
                  PickedImage();
                },
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black38,
                      width: 1.5
                    ),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child:image==null?const Icon(Icons.camera_alt_outlined,
                  color: Colors.black,):Image.file(File(image!.path).absolute,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  )
                ),
              ),
            ),),
            const SizedBox(height: 20.0,),
              reusableText(title:'Option 1'),
              Options(myController: _option1, title: "Enter Option 1"),
              const SizedBox(height: 20.0,),
              reusableText(title:'Option 2'),
              Options(myController: _option2, title: "Enter Option 2"),
              const SizedBox(height: 20.0,),
              reusableText(title:'Option 3'),
              Options(myController: _option3, title: "Enter Option 3"),
              const SizedBox(height: 20.0,),
              reusableText(title: 'Option 4'),
              Options(myController: _option4, title: "Enter Option 4"),
              const SizedBox(height: 20.0,),
              reusableText(title: 'Correct Answer'),
              Options(myController: _CorrectAnswer,title: "Enter Correct Answer"),
             const SizedBox(height: 20,),
              Container(
                width: MediaQuery.of(context).size.width ,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Color(0xffececf8),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    dropdownColor: Colors.white,
                    hint:const Text("Select Category"),
                    iconSize: 36,
                    value: value,
                    icon:const Icon(Icons.arrow_drop_down,color: Colors.black,),
                    items:quizItem.map((item) => DropdownMenuItem(

                        value:item,
                        child:Text(item,
                        style: const TextStyle(fontSize:18,color: Colors.black ),) ) ).toList(),
                    onChanged: (value) {
                      setState(() {
                        this.value=value;
                      });
                    },
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  uploadItem();
                },
                child: Center(
                  child: Material(
                    elevation: 2.0,
                     borderRadius: BorderRadius.circular(10),
                     child: Container(
                       padding: EdgeInsets.symmetric(vertical: 5.0),
                       width: 150,
                       decoration: BoxDecoration(
                         color: Colors.black,
                         borderRadius: BorderRadius.circular(10),
                       ),
                       child:const Center(
                         child: Text("Add",
                         style: TextStyle(color: Colors.white,
                           fontSize: 20.0,
                           fontWeight: FontWeight.bold
                         ),
                         ),
                       ),
                     ),
                  ),
                ),
              )

            ],),
        ),
      ),
    );

  }
  static TextEditingController _CorrectAnswer=TextEditingController();
  static TextEditingController _option1=TextEditingController();
  static TextEditingController _option2=TextEditingController();
  static TextEditingController _option3=TextEditingController();
  static TextEditingController _option4=TextEditingController();

  File? image;
  final ImagePicker _picker = ImagePicker();

  Future<void>PickedImage()async{
    final pickedFile=await _picker.pickImage(source:ImageSource.gallery,imageQuality: 80);
    if(pickedFile!=null){
      image=File(pickedFile.path);
      setState(() {

      });
    }else{
      print("No Image Picked");
    }
  }

  static reusableText({required String title}){
    return Text(title,style: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.w500,
        fontSize: 20.0
    ),);
  }


  Options({required TextEditingController myController,required String title}){
    return SizedBox(
         child:    Container(
      padding:const EdgeInsets.symmetric(horizontal: 20.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Color(0xffececf8),
          borderRadius: BorderRadius.circular(20)
      ),
      child: TextField(
        controller: myController,
        decoration: InputDecoration(
          hintText: title,
          hintStyle: const TextStyle(
              color: Colors.black26,fontSize: 18.0,
              fontWeight: FontWeight.w600
          ),
          border: InputBorder.none,
        ),
      ),
    ),
    );
  }
}
