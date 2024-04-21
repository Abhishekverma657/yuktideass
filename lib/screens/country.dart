import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yuktidea/Api/ApiService.dart';
import 'package:yuktidea/screens/GetPhoneNo.dart';

class Country extends StatefulWidget {
  const Country({super.key});

  @override
  State<Country> createState() => _CountryState();
}

class _CountryState extends State<Country> {
  @override
   String _searchText = '';
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
        backgroundColor: Color(0xff212426),
       appBar: AppBar(
         backgroundColor: Colors.transparent,
         leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white,),onPressed: () {
           Navigator.pop(context);
           
         },)),
         body:  SingleChildScrollView(
           child: Column( 
             children: [
              const   Text("Select Your Country",style: TextStyle(
                  
                color:Colors.white,fontSize: 22,fontWeight: FontWeight.w500),),
                Container(
                  margin: EdgeInsets.all(20),
                  height: 75,
                   padding: const  EdgeInsets.only(left: 30,right: 30),
                   decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey),
                   ),
                   child: Row(
            children:[
              const    Icon(Icons.search,size: 50,color: Colors.redAccent,),
             const   SizedBox(width: 8.0),
              Expanded(child: TextFormField(
                onChanged: (value) {
                          setState(() {
                            _searchText = value;
                          });
                        },
                 decoration: const  
                 InputDecoration(
                   hintText: "Serach",hintStyle: TextStyle(fontSize: 24.0,color: Colors.grey),
                  border: UnderlineInputBorder(borderSide: BorderSide.none)
           
                  ),
                  style: TextStyle(color: Colors.white),
           
           
              ))
            ],
                   ),
                 ),
                  
           
                FutureBuilder(future: ApiService.fetchCountryList(),
                 builder: (context,snapshot){
                   if(snapshot.hasData){
       
       
                    List countries = snapshot.data!.data!;
                    if (_searchText.isNotEmpty) {
                      countries = countries.where((country) =>
                          country.name.toLowerCase().contains(_searchText.toLowerCase())).toList();
                    
                    }

                      return ListView.builder(
                      shrinkWrap: true,
                       physics: NeverScrollableScrollPhysics(),
                      itemCount: countries.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) =>
                                  PhoneNumberScreen(flafUrl: countries[index].flag.toString(), telCode: countries[index].telCode.toString(),)));
                            },
                            child: ListTile(
                               
                              leading: Container(
                                height: 24.0,
                                width: 24.0,
                                child: SvgPicture.network(
                                  '${countries[index].flag}',
                                  placeholderBuilder: (BuildContext context) => Icon(Icons.image_sharp),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              trailing: Text(countries[index].telCode.toString(), style: TextStyle(fontSize: 22, color: Colors.white)),
                              title: Text(countries[index].name.toString(), style: TextStyle(fontSize: 22, color: Colors.white)),
                            ),
                          ),
                        );
                      },
                    );
        





          //  return ListView.builder(
          //   shrinkWrap: true,
          //       itemCount: snapshot.data!.data!.length,
          //       itemBuilder: (context, index) {
          //         return Container(
                 
                    
          //           margin: EdgeInsets.all(10),
          //            decoration: BoxDecoration(
          //              shape: BoxShape.rectangle,
                        
          //     ),
          //           child: InkWell(
          //              onTap: (){
          //               Navigator.push(context,   MaterialPageRoute(builder: (_)=>PhoneNumberScreen(flafUrl:snapshot.data!.data![index].flag.toString(),telCode: snapshot.data!.data![index].telCode.toString() ,)));
          //              },
          //             child: ListTile(
          //              leading: Container(
          //                 height: 24.0,
          //                    width: 24.0,
          //                child: SvgPicture.network(
          //                    '${snapshot.data!.data![index].flag}',
          //                    placeholderBuilder: (BuildContext context) => Icon(Icons.image_sharp),
          //                   //  height: 24.0,
          //                   //  width: 24.0,
          //                     fit: BoxFit.cover,
          //                  ),
          //              ),
                      
          //               trailing: Text(snapshot.data!.data![index].telCode.toString(),style: TextStyle(fontSize: 22,color: Colors.white),),
          //               title: Text(snapshot.data!.data![index].name.toString(),style: TextStyle(fontSize: 22,color: Colors.white),),
          //             ),
          //           ),
          //         );
          //       },
          //     );
                   }
           else if(snapshot.hasError){
             print(snapshot.error);
            return Text(snapshot.error.toString());
           }
                   else {
              return Center(
                child: CircularProgressIndicator(),
              );
                 }
                 }
                )
             
             
                   
             ],
           ),
         ),
      ),
    );
  }
}