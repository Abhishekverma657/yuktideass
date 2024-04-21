import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yuktidea/Api/ApiService.dart';
import 'package:yuktidea/constant.dart';
import 'package:yuktidea/screens/WelcomeScreen.dart';

class SelectCountry extends StatefulWidget {
  const SelectCountry({super.key});

  @override
  State<SelectCountry> createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry> {
  @override
   int  countryId=0;
  Widget build(BuildContext context) {
    return   Scaffold(
        backgroundColor: Color(0xff212426),
      appBar: AppBar(
         backgroundColor: Colors.transparent,
         leading: IconButton(icon: const Icon(Icons.arrow_back_ios,color: Colors.white,),onPressed: () {
            Navigator.pop(context);
           
         },),
      ),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Select your country',
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold,color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Choose your country from the list below',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: ApiService.GetCountryList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: snapshot.data!.data!.countries!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                           print(index);
                            setState(() {
                              countryId=index+1;
                            });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                             Container(height: 100,width: 100,

                              
                              decoration: BoxDecoration
                              (
                                 border: Border.all(color: Colors.red),
                                image: DecorationImage(
                                 fit: BoxFit.cover,
                                image: NetworkImage("${snapshot.data!.data!.countries![index].image.toString()}"))),
                             ),
                            SizedBox(height: 8.0),
                            Text(
                              snapshot.data!.data!.countries![index].name.toString(),
                              style: TextStyle(fontSize: 16.0,color: Colors.white),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Proceed button logic
                 ApiService.SelectedCountry(countryId).then((value) => 

                 Navigator.push(context,  MaterialPageRoute(builder: (context) => WelcomeScreen(),)));
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
              child: Text('Proceed'),
            ),
          ),
           Text("Can`t see  the country of your intrest?",style: TextStyle(color: Colors.white),),
           TextButton(onPressed: (){

           }, child: Text("Contact Us",style: TextStyle(color: Colors.redAccent,fontSize: 25),))
        ],
      ),
    );
  }
}