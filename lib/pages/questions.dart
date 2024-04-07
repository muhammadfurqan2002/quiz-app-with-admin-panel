import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_1/firebase_services/data_base.dart';

class Questions extends StatefulWidget {
  final String category;
  const Questions({super.key,required this.category});

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {


    bool isTrue=false;
  Stream? QuizStream;

  @override
  void initState() {
    // TODO: implement initState
    print(widget.category);
    getOnLoad();
    super.initState();
  }

  getOnLoad()async{
      QuizStream =await DataBaseMethod().getQuizCategory(widget.category);
      setState(() {

      });
  }

  PageController controller=PageController();
  Widget AllQuiz(){
    return StreamBuilder(
        stream: QuizStream,
        builder: (context,AsyncSnapshot snapshot){
          return snapshot.hasData?PageView.builder(
              controller: controller,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context,index){
              DocumentSnapshot ds=snapshot.data.docs[index];
              return  Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(32))
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Column(
                    children: [
                      Padding(
                        padding:const EdgeInsets.only(top: 30),

                        child:  ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset("images/quaid.jpg",
                            width: MediaQuery.of(context).size.width/1,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      options(ds["option1"],ds["correct"]),
                      const SizedBox(height: 15,),
                      options(ds["option2"],ds["correct"]),
                      const SizedBox(height: 15,),
                      options(ds["option3"],ds["correct"]),
                      const SizedBox(height: 15,),
                      options(ds["option4"],ds["correct"]),
                      const SizedBox(height: 20,),
                      InkWell(
                        onTap: (){
                          controller.nextPage(duration: Duration(milliseconds: 100), curve:Curves.easeInOut);
                          isTrue=false;
                          setState(() {

                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Material(
                              borderRadius: BorderRadius.circular(20),
                              elevation: 2,
                              child: Container(
                                width: 90,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                      color:Colors.black,
                                      width: 2
                                    )
                                  ),
                                  child: Icon(Icons.arrow_forward_ios,size: 29,color: Colors.black,)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
              }):Center(child: CircularProgressIndicator(color: Colors.blue,strokeWidth: 3,));
        });

  }

  options(String name,String answer){
    return  GestureDetector(
      onTap: (){
        isTrue=true;
        setState(() {

        });
      },
      child:isTrue?Container(
        padding:const EdgeInsets.all(15),
        width: MediaQuery. of(context).size.width,
        decoration: BoxDecoration(
            border:Border.all(

                color:name!=answer?Colors.red: Color(0xFF818181),width: 1.2),
            borderRadius: BorderRadius.circular(20)
        ),
        child:  Text(name.toString(),
          style: const TextStyle(color: Colors.black,
              fontSize: 18,fontWeight: FontWeight.w400),
        ),
      ):Container(
        padding:const EdgeInsets.all(15),
        width: MediaQuery. of(context).size.width,
        decoration: BoxDecoration(
            border:Border.all(

                color: Color(0xFF818181),width: 1.2),
            borderRadius: BorderRadius.circular(20)
        ),
        child:  Text(name.toString(),
          style: const TextStyle(color: Colors.black,
              fontSize: 18,fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFF004840) ,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              const SizedBox(height: 10,),
              Row(children: [
                const SizedBox(width: 10,),
                Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Color(0xFFf35b32),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child:const Icon(Icons.arrow_back_ios,color: Colors.white,)),
                  ),
                SizedBox(width: MediaQuery.of(context).size.width*0.3,),
                Text(widget.category,style: TextStyle(color: Colors.white,fontSize: 24.0,fontWeight: FontWeight.bold),)
              ],),
            const SizedBox(height: 20,),
              Expanded(child: AllQuiz()),
            ],

          ),
        ),
      ),
    );
  }
}
