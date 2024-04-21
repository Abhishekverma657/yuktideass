import 'package:flutter/material.dart';
import 'package:yuktidea/Api/ApiService.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

class TermsAndCondition extends StatefulWidget {
  const TermsAndCondition({super.key});

  @override
  State<TermsAndCondition> createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
  @override
 
   void initState() {
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color(0xff212426),
       appBar: AppBar(backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
           IconButton(onPressed: (){
             Navigator.pop(context);

           }, icon: Icon(Icons.close,color: Colors.white,))
        ],),
      
      body: SingleChildScrollView(
        child: Column( children: [
         FutureBuilder(
          future: ApiService.fetchTermsAndConditions(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
            } else {
           
             return SingleChildScrollView(
               child: Column(
                 children: [
                   Container(
                     child: 
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(children: [
                            Expanded(
                               flex: 1,
                              child: Container(
                                 height: 80,
                                  width: 40,
                                decoration: BoxDecoration(
                              
                              image: DecorationImage(
                                 fit:  BoxFit.cover,
                                
                                image: AssetImage("assets/tmc.png"))),)),
                           Expanded(
                              flex:3,
                               child:Container(
                                margin: EdgeInsets.all(10),
                                height: 80,
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                   children: [
                                     Text(snapshot.data!.data!.title.toString(),style:  TextStyle(
                                       fontSize: 20,
                                       color: Colors.redAccent
                                     )),
                                     Text("Updated at "+ DateFormat('dd/MM/yyyy').format( DateTime.parse(snapshot.data!.data!.updatedAt.toString())),style:  TextStyle(
                                       color: Colors.white38
                                     )),
                                      // Text()
                                   ],
                                 ),
                               ),
                           ),
                        ]),
                      ),
                   ),
                  
                Html(data: snapshot.data!.data!.content,
                style: {
            "h1": Style(color: Colors.redAccent), 
            "p": Style(color: Colors.white),  
            "li": Style(color: Colors.white),
          },
                ),
                   
                 ],
               ),
             );
        // return SingleChildScrollView(
        //   padding: EdgeInsets.all(16.0),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Text(
        //         snapshot.data?.data!.title ?? 'No title available',
        //         style: TextStyle(fontWeight: FontWeight.bold),
        //       ),
        //       SizedBox(height: 8.0),
        //       Text(snapshot.data?.data!.content ?? 'No content available'),
        //     ],
        //   ),
        // );
            }
          },
        ),
            ],),
      ),);
  }
}