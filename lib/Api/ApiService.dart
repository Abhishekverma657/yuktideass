 
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:yuktidea/constant.dart';
import 'package:yuktidea/models/countryListModel.dart';
import 'package:yuktidea/models/countryModel.dart';
import 'dart:convert';

import 'package:yuktidea/models/termsConditionmodel.dart';

 
class ApiService {
  static Future<countrymodel> fetchCountryList() async {
    final response =
        await http.get(Uri.parse('https://studylancer.yuktidea.com/api/countries'));

    if (response.statusCode == 200) {
      final json= jsonDecode(response.body);
       return  countrymodel.fromJson(json);
    } else {
      throw Exception('Failed to load countries');
    }

    

  }
  static Future<TermaAndConditonModel> fetchTermsAndConditions() async {
  final response = await http.get(Uri.parse('https://studylancer.yuktidea.com/api/terms-conditions'));

  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
     return  TermaAndConditonModel.fromJson(json);
  } else {
    throw Exception('Failed to load terms and conditions');
  }
}

  static Future<void> sendPhoneNumber(String phoneNumber, String telCode) async {
    final String apiUrl = 'https://studylancer.yuktidea.com/api/student/login';  
    final response = await http.post(Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'phone': phoneNumber,
          'tel_code': telCode,
        }));

    if (response.statusCode == 200) {
      // Handle successful response
      print('Phone number and telcode sent successfully!');
    } else {
      // Handle error response
      print('Failed to send phone number and telcode. Status code: ${response.statusCode}');
    }
  }



  static Future<void> resendOtp(String phoneNumber) async {
    final String apiUrl = 'https://studylancer.yuktidea.com/api/resend-otp';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'phone': phoneNumber,
      }),
    );

    if (response.statusCode == 200) {
      print('OTP resend request successful');
    } else {
      print('Failed to resend OTP. Status code: ${response.statusCode}');
    }
  }


  static Future<void> VerifyOTP(String phoneNumber,String otp) async {
    final String apiUrl = 'https://studylancer.yuktidea.com/api/verify-otp';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'phone': phoneNumber,
        "code":otp
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
       
      
      token = data['data']['access_token'];
      OtpStatus=data['status'];

      print('OTp verification successs');
    } else {
      print('Failed to verify. Status code: ${response.statusCode}');
    }
  }

   static Future<CountryListModel> GetCountryList() async {
    var headers = {
       'Content-Type': 'application/json',
  // 'Authorization': 'Bearer 89|Cx3MxVMg86RN1roSGD2y25vjqawDUUPvM6VLZlDRd29eb1f6'
  'Authorization': 'Bearer $token'
};
    final response =
        await http.get(Uri.parse('https://studylancer.yuktidea.com/api/select/country')
        ,headers: headers
        );
     

    if (response.statusCode == 200) {
       print("seccccc");
      final json= jsonDecode(response.body);
       return  CountryListModel.fromJson(json);
        
    } else {
       print(token);
      throw Exception('Failed to load countries');
    }

 
   }

 
    



   

   static Future<void> SelectedCountry(int  countryid,) async {
      var headers = {
         'Content-Type': 'application/json; charset=UTF-8',
  'Authorization': 'Bearer ${token}'
};
    final String apiUrl = 'https://studylancer.yuktidea.com/api/select/country';

    final response = await http.post(
      Uri.parse(apiUrl) ,headers: headers,
     
      body: jsonEncode(<String, String>{
        'country_id':'$countryid',
      }),
    );

    if (response.statusCode == 200) {
      print('Country select  successfull');
    } else {
      print('Failed to select country. Status code: ${response.statusCode}');
    }
  }

  static Future<void> DeleteUser() async {
      var headers = {
         'Content-Type': 'application/json; charset=UTF-8',
  'Authorization': 'Bearer ${token}'
};
    final String apiUrl = 'https://studylancer.yuktidea.com/api/delete';

    final response = await http.post(
      Uri.parse(apiUrl) ,headers: headers,
     
      // body: jsonEncode(<String, String>{
        
      // }),
    );

    if (response.statusCode == 200) {
      print('delete user  successfull');
    } else {
      print('Failed to delete user. Status code: ${response.statusCode}');
    }
  }


  
  static Future<void> LogOut() async {
      var headers = {
         'Content-Type': 'application/json; charset=UTF-8',
  'Authorization': 'Bearer ${token}'
};
    final String apiUrl = 'https://studylancer.yuktidea.com/api/logout';

    final response = await http.post(
      Uri.parse(apiUrl) ,headers: headers,
     
      // body: jsonEncode(<String, String>{
        
      // }),
    );

    if (response.statusCode == 200) {
      print('LogOut  successfull');
    } else {
      print('Failed to LogOut. Status code: ${response.statusCode}');
    }
  }

}