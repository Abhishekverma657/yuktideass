import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yuktidea/screens/otpScreen.dart';

import '../Api/ApiService.dart';

class PhoneNumberScreen extends StatefulWidget {
  PhoneNumberScreen({Key? key, required this.flafUrl, required this.telCode})
      : super(key: key);
  String flafUrl;
  String telCode;

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  TextEditingController phone = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _phoneNumberError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Color(0xff212426),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          'Enter phone Number',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        'Please enter your 10 digit mobile number to receive OTP',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: Row(
                          children: [
                            Container(
                              height: 24.0,
                              width: 24.0,
                              child: SvgPicture.network(
                                '${widget.flafUrl}',
                                placeholderBuilder: (BuildContext context) =>
                                    Icon(
                                  Icons.image_sharp,
                                  size: 24,
                                ),
                                fit: BoxFit.contain,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(),
                              child: Text(
                                "${widget.telCode}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Expanded(
                              child: TextFormField(
                                controller: phone,
                                decoration: InputDecoration(
                                  errorStyle: TextStyle(fontSize: 0),
                                  hintText: '9999999999',
                                  hintStyle: TextStyle(color: Colors.white),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide.none),
                                ),
                                style: TextStyle(color: Colors.white),
                                keyboardType: TextInputType.phone,
                                cursorColor: Colors.white,
                                validator: (value) {
                                  if (value == null || value.isEmpty||value!.length != 10) {
                                    return  '' ;
                                   
                                     
                                     
                                  }
                                   
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Divider(),
                      ),
                      if (_phoneNumberError != null)
                        Text(
                          _phoneNumberError!,
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _phoneNumberError = null;
                      });
                      ApiService.sendPhoneNumber(
                              phone.text, widget.telCode)
                          .then((value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => OtpScreen(
                                      phoneNumber: phone.text,
                                      telCode: widget.telCode))));
                    } else {
                      setState(() {
                        _phoneNumberError =
                            'Please enter a valid phone number';
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff212426), // Button color
                    onPrimary: Colors.white,
                    minimumSize: Size(150, 50),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20), // Button border radius
                    ),
                  ),
                  child: Text(
                    'Get OTP',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
