import 'package:flutter/material.dart';
import 'package:yuktidea/Api/ApiService.dart';
import 'package:yuktidea/constant.dart';
import 'package:yuktidea/screens/HomeScreen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color(0xff212426),
       body: Column(
         mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:  CrossAxisAlignment.center,
         children: [
           Center(child: Text("Welcome",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: (){
                 ApiService.LogOut().then((value){
                  setState(() {
                    token='';
                  });
                 }).then((value) => Navigator.push(context, MaterialPageRoute(builder: (_)=>HomeScreen())));
              
              },
                            style: ElevatedButton.styleFrom(
                  primary: Color(0xff212426), // Button color
                  onPrimary: Colors.white, 
                   
                    minimumSize: Size(150, 50),
                  elevation: 4,
                  
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Button border radius
                  ),   
                ),
               child: Text("LogOut")),
            ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: ElevatedButton(onPressed: (){
                   ApiService.DeleteUser().then((value){
                  setState(() {
                    token='';
                  });
                 }).then((value) => Navigator.push(context, MaterialPageRoute(builder: (_)=>HomeScreen())));
              
                 
                             },
                            style: ElevatedButton.styleFrom(
                     primary: Color(0xff212426), // Button color
                     onPrimary: Colors.white, 
                      
                       minimumSize: Size(150, 50),
                     elevation: 4,
                     
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(20), // Button border radius
                     ),   
                   ),
                              child: Text("Delete User")),
               )

         ],
       ),
    );
  }
}