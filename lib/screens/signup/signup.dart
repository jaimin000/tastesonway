import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tastesonway/main.dart';
import 'package:tastesonway/theme_data.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  User? user;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool otpVisibility = false;
  String verificationID = "";
  late String otpCode;
  late String phoneCode = "91";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),
        title: Text(
          otpVisibility? 'Enter OTP' : 'Sign Up',
          style: cardTitleStyle20(),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: 230,
                    width: MediaQuery.of(context).size.width,
                    child: otpVisibility ? Image.asset('assets/images/otp.png') :Image.asset('assets/images/mobile.png'),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: Card(
                      shadowColor: Colors.black,
                      color: cardColor(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(8),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              otpVisibility?
                              PinCodeTextField(
                                appContext: context,
                                length: 6,
                                obscureText: false,
                                controller: otpController,
                                animationType: AnimationType.fade,
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(5),
                                  fieldHeight: 60,
                                  fieldWidth: 40,
                                  activeFillColor: Colors.white,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    otpCode = value;
                                  });
                                },
                              ):IntlPhoneField(
                                initialCountryCode: 'IN',
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  fillColor: inputColor(),
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none),
                                  hintText: 'Phone Number',
                                  hintStyle: inputTextStyle16(),
                                ),
                                controller: phoneController,
                                onCountryChanged: (country) {
                                  phoneCode = country.dialCode;
                                },
                              ),

                              GestureDetector(
                                onTap: () {
                                  if (_formKey.currentState!.validate()){
                                    if (otpVisibility) {
                                      verifyOTP();
                                    }else {
                                      login();
                                    }
                                  }
                                },
                                child: SizedBox(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    child: Card(
                                        shadowColor: Colors.black,
                                        color: orangeColor(),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            otpVisibility ? "Verify" : "Login",
                                            style: mTextStyle16(),
                                          ),
                                        ))),
                              ),

                              SizedBox(
                                height: 20,
                              ),
                              !otpVisibility ? SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      './assets/images/google.png',
                                      height: 28,
                                      width: 28,
                                    ),
                                    Image.asset(
                                      './assets/images/facebook.png',
                                      height: 30,
                                      width: 30,
                                    ),
                                    Image.asset(
                                      './assets/images/apple.png',
                                      height: 30,
                                      width: 30,
                                      color: Colors.white,
                                    ),
                                    Image.asset(
                                      './assets/images/email.png',
                                      height: 30,
                                      width: 30,
                                    ),
                                  ],
                                ),
                              ) : SizedBox(),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            isLoading ? Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.transparent,
                  child: Center(child: CircularProgressIndicator(
                    color: orangeColor(),
                  )),
                ),
              ),
            ) : Container(),
          ],

        ),
      ),
    );
  }
  void login() async {
    setState(() {
      isLoading = true;
    });
    auth.verifyPhoneNumber(
      phoneNumber: "+"+ phoneCode + phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          print("You are logged in successfully");
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
        setState(() {
          isLoading = false;
        });
      },
      codeSent: (String verificationId, int? resendToken) {
        otpVisibility = true;
        verificationID = verificationId;
        setState(() {
          isLoading = false;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
  void verifyOTP() async {
    setState(() {
      isLoading = true;
    });
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpController.text);

    await auth.signInWithCredential(credential).then(
          (value) {
        setState(() {
          user = FirebaseAuth.instance.currentUser;
          isLoading = false;

        });
      },
    ).whenComplete(
          () {
        if (user != null) {
          Fluttertoast.showToast(
            msg: "You are logged in successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: orangeColor(),
            fontSize: 16.0,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ),
          );
        } else {
          Fluttertoast.showToast(
            msg: "your login is failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          setState(() {
            isLoading = false;
          });
        }
      },

    );
  }
}
