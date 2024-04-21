import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:yuktidea/Api/ApiService.dart';
import 'package:yuktidea/constant.dart';
import 'package:yuktidea/screens/selectCountry.dart';

class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
   String phoneNumber;
    String telCode;
  
   OtpScreen({required this.phoneNumber, required this.telCode});
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController _otpController = TextEditingController();
  bool _isResendButtonDisabled = true;
  int _resendTimer = 30;
  Timer? _timer;
   bool valid=false;

  @override
  void initState() {
    // _handleResendButtonPressed();
    
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_resendTimer > 0) {
        setState(() {
          _resendTimer--;
        });
      } else {
        _timer?.cancel();
        setState(() {
          _isResendButtonDisabled = false;
        });
      }
    }
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _handleResendButtonPressed() {
    setState(() {
      _isResendButtonDisabled = true;
      _resendTimer = 30;
    });

   
    ApiService.resendOtp("${widget.telCode}${widget.phoneNumber}");
    Future.delayed(Duration(microseconds: 10), () {
      setState(() {
        _timer?.cancel();
        _timer = Timer.periodic(Duration(seconds: 1), (timer) {
          if (_resendTimer > 0) {
            setState(() {
              _resendTimer--;
            });
          } else {
            _timer?.cancel();
            setState(() {
              _isResendButtonDisabled = false;
            });
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff212426),
     appBar: AppBar(
         backgroundColor: Colors.transparent,
         leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white,),onPressed: () {
            Navigator.pop(context);
           
         },),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
             Text("Verify Number", textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 28,fontWeight: FontWeight.w800),),
             
            Text(
              'Please enter the OTP receive to verify your  number',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0,
               color: Colors.redAccent),
            ),
            SizedBox(height: 20.0),
            PinCodeTextField(
              appContext: context,
              length: 4,
              onChanged: (value) {
                // Handle OTP value change

              },
              controller: _otpController,
              autoFocus: true,
              keyboardType: TextInputType.number,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.underline,
                borderRadius: BorderRadius.zero,
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Colors.transparent,
                inactiveFillColor: Colors.transparent,
                activeColor: Colors.white,
                inactiveColor: Colors.grey,
                selectedFillColor: Colors.transparent,
                selectedColor: Colors.white,
         
              ),
              cursorColor: Colors.white,
                      textStyle: TextStyle(color: Colors.white), // Set cursor color to white
            ),
             Visibility(
               visible: valid,
              child: Text("OTP does not match please try again",textAlign: TextAlign.center
              ,style: TextStyle(color: Colors.redAccent),)),
            SizedBox(height: 20.0),
             Text("Don`t receive OTP",style: TextStyle(color: Colors.white54)),
            TextButton(
                  onPressed: _isResendButtonDisabled ? null : _handleResendButtonPressed,
                  child:
                   RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: 'Resend OTP',
          style: TextStyle(
            color: _isResendButtonDisabled ? Colors.grey : Colors.redAccent,
          ),
        ),
        if (_isResendButtonDisabled)
          TextSpan(
            text: ' in $_resendTimer seconds',
            style: TextStyle(color: Colors.redAccent),
          ),
      ],
    ),
                   )
                  
                ),
            ElevatedButton(
              onPressed: () {
                // Validate OTP
                //  ApiService.GetCountryList();
                // setState(() {
                
                //    ApiService.VerifyOTP("${widget.telCode}${widget.phoneNumber}", _otpController.text.toString()).then((value) => Navigator.push(context,MaterialPageRoute(builder: (_)=>SelectCountry())));
                //   print("Token is ...");
                //   print(token);
                  
                // });



                setState(() {
      ApiService.VerifyOTP("${widget.telCode}${widget.phoneNumber}", _otpController.text.toString()).then((value) {
        if (OtpStatus) {
          // OTP is valid, navigate to the next screen
           
         
              valid=false;
          
          Navigator.push(context, MaterialPageRoute(builder: (_) => SelectCountry())).then((value) {
            OtpStatus=false;
          });
        } else {
          // OTP is invalid, show error message
          _otpController.text = '';
          //  valid=true;
            setState(() {
               valid=true;
              
            });
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //   content: Text("Invalid OTP. Please try again."),
          //   duration: Duration(seconds: 2),
          // ));
        }
      });
    });
                 
                // var response=ApiService.VerifyOTP(widget.phoneNumber, _otpController.text);
          
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
      child: Text('Verify OTP',style: TextStyle(fontSize: 17),),
            ),
          ],
        ),
      ),
    );
  }
 
}
