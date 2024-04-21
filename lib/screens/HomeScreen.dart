import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yuktidea/screens/TermsAndConditions.dart';
import 'package:yuktidea/screens/country.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      // appBar: AppBar(
      //    backgroundColor: Colors.transparent,
      //    leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white,),onPressed: () {
           
      //    },),
      // ),
       body: Container(
         height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
         decoration: const  BoxDecoration(image: DecorationImage(
            fit: BoxFit.cover,
          image: AssetImage("assets/Startup.png"))),
       

         child: Align(alignment: Alignment.bottomCenter,
          child: Container(height: MediaQuery.of(context).size.height/2.2,
           width: double.infinity,
            decoration: const  BoxDecoration(color: Colors.black,
             borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
            ),
             child:  Padding(
               padding: const EdgeInsets.all(8.0),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
               const    FittedBox(child: Text("Welcome to Study Lancer",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.w700),)), 
                        const    FittedBox(child: Text("Please  select  your  role to get  registered",style: TextStyle(color: Colors.white,fontSize: 20),)),
               
                          Row(
                             mainAxisAlignment: MainAxisAlignment.spaceAround,
                             children: [
                               Column(
                                 children: [
                                   InkWell(
                                     onTap: () {
                                                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>Country()));
                                       
                                     },
                                     child: Container(
                                      width: MediaQuery.of(context).size.width/2.2,
                                      height: MediaQuery.of(context).size.height/4.5,
                                       decoration:  const BoxDecoration(
                                        image: DecorationImage(
                                           fit : BoxFit.cover,
                                          image: AssetImage("assets/student.png"))
                                        ),),
                                   ),
                                      Text("Student",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 20),)
                                 ],
                               ),
                               Column(
                                 children: [
                                   InkWell(
                                     onTap: () {
                                                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>Country()));
                                       
                                     },
                                     child: Container(width: MediaQuery.of(context).size.width/2.2,
                                      height: MediaQuery.of(context).size.height/4.5,
                                       decoration: BoxDecoration(  image: DecorationImage(
                                           fit : BoxFit.cover,
                                          image: AssetImage("assets/agent.png"))
                                        ),),
                                   ),
                                       Text("Agent",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 20),)
                                 ],
                               )
                             ],
                          ),
                           SizedBox(height: 10,),
                            FittedBox(
                              child: Row(
                                 children: [
                                    Text( "By continuing you agree to our ",style: TextStyle(color: Colors.white),),
                                        InkWell(
                                           onTap: () {
                                             Navigator.push(context, MaterialPageRoute(builder: (context)=>TermsAndCondition()));
                                           },
                                          child: Text( "Terms and conditions",style: TextStyle(color: Colors.redAccent)))
                                   
                                 ],
                              ),
                            ),
                          // FittedBox(
                          //    child: RichText(text:  const TextSpan(children: [
                          //     TextSpan(text: "By continuing you agree to our "),

                          //     TextSpan(text: "Terms and conditions",style: TextStyle(color: Colors.redAccent))
                          //    ])),
                          // ),
                           SizedBox(height: 10,),
                 ],
               ),
             ),
          )
           ,),
       ),
    );
  }
}