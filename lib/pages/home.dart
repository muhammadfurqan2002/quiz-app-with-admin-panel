import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_1/pages/questions.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Categories({String? category,String? imgUrl}){
    return  GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Questions(category: category!,)));
      },
      child: Material(
        borderRadius:BorderRadius.circular(20),
        elevation: 5.0,
        child: Container(
          width:160,
          padding:const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child:  Column(
            children: [
              Image.asset(imgUrl!,height: 100,),
              const SizedBox(height: 20,),
              Text(category!,style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 22
              ),)
            ],
          )
          ,
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor:const Color(0xffedf3f6),
          body:SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Stack(
                      children: [
                        Container(
                          height: 200,
                          padding: const EdgeInsets.only(left: 20,top: 40),
                          decoration:const BoxDecoration(
                            color: Color(0xff3b3d3b),
                            borderRadius: BorderRadius.only(bottomLeft:Radius.circular(25),bottomRight:Radius.circular(25))
                          ),
                          child:Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius:BorderRadius.circular(60)
                                ,child: Image.asset("images/user.jpg",
                                height: 50,width: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 30,),
                              const Padding(
                                padding:  EdgeInsets.only(top: 10),
                                child: Text("Muhammad Furqan",
                        
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold
                                ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(top: 110,left: 20,right: 20),
                          decoration: BoxDecoration(
                            color:const Color(0xff323233),
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child:Padding(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              children: [Image.asset("images/Q.png",
                                height: 180,
                                width: 190,
                              ),
                             const SizedBox(width: 20,),
                             const Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text("Play &\nWin",style: TextStyle(
                                     fontSize: 34,color: Colors.white,
                                     fontWeight: FontWeight.bold
                                 ),),
                                 Text("Play Quiz by\nguessing the image ",style: TextStyle(
                                     fontSize: 16,color: Colors.white,
                                   fontWeight: FontWeight.w400
                                 ),)
                               ],
                             )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  const SizedBox(height: 15,),
                  const Padding(
                    padding:  EdgeInsets.only(left: 20),
                    child: Text("Top Quiz Categories",style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                    ),),
                  ),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                              Categories(category: "Random",imgUrl: "images/animal.jpg"),
                              Categories(category: "Sports",imgUrl: "images/Q.png"),
                            ],
                        ),
                        const SizedBox(height: 20,),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //   children: [
                        //       Categories(),
                        //       Categories(),
                        //     ],
                        // ), const SizedBox(height: 20,),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //   children: [
                        //       Categories(),
                        //       Categories(),
                        //     ],
                        // ), const SizedBox(height: 20,),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //   children: [
                        //       Categories(),
                        //       Categories(),
                        //     ],
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
    );
  }
}
