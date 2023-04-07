import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tastesonway/screens/register/userPersonalDetail.dart';
import 'package:tastesonway/utils/theme_data.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/sharedpreferences.dart';

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
  String phoneCode = "91";
  String countryCode = "IN";
  bool isLoading = false;
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
            (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),
        title: Text(
          otpVisibility? 'Enter OTP' : 'Quick Login / Register',
          style: cardTitleStyle20(),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 230,
                    width: MediaQuery.of(context).size.width,
                    child: otpVisibility ? Image.asset('assets/images/otp.png') :Image.asset('assets/images/mobile.png'),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shadowColor: Colors.black,
                      color: cardColor(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(8),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              otpVisibility?
                              PinCodeTextField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                                  if(value.length == 6){
                                    verifyOTP();
                                  }
                                },
                              ):IntlPhoneField(
                                initialCountryCode: 'IN',
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10.0),
                                  fillColor: inputColor(),
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none),
                                  hintText: 'Phone Number',
                                  hintStyle: inputTextStyle16(),
                                ),
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                controller: phoneController,
                                // onCountryChanged: (country) {
                                //   phoneCode = country.dialCode;
                                // },
                                onChanged: (phone) {
                                  phoneCode = phone.countryCode;
                                  countryCode = phone.countryISOCode;
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
                                    height: 55,
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
                                            otpVisibility ? "Verify" : "Send OTP",
                                            style: mTextStyle16(),
                                          ),
                                        ))),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              // !otpVisibility ? SizedBox(
                              //   width: MediaQuery.of(context).size.width,
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                              //     crossAxisAlignment: CrossAxisAlignment.center,
                              //     children: [
                              //       Image.asset(
                              //         './assets/images/google.png',
                              //         height: 28,
                              //         width: 28,
                              //       ),
                              //       Image.asset(
                              //         './assets/images/facebook.png',
                              //         height: 30,
                              //         width: 30,
                              //       ),
                              //       Image.asset(
                              //         './assets/images/apple.png',
                              //         height: 30,
                              //         width: 30,
                              //         color: Colors.white,
                              //       ),
                              //       Image.asset(
                              //         './assets/images/email.png',
                              //         height: 30,
                              //         width: 30,
                              //       ),
                              //     ],
                              //   ),
                              // ) : SizedBox(),
                              // SizedBox(
                              //   height: 15,
                              // ),
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
    await Sharedprefrences.setCountryCode(phoneCode);
    await Sharedprefrences.setMobileNumber(phoneController.text);
    await Sharedprefrences.setShortCode(countryCode);
    // print("this is complete data: $countryCode, $phoneController.text, $phoneCode");
    setState(() {
      isLoading = true;
    });
    auth.verifyPhoneNumber(
      phoneNumber: "+$phoneCode${phoneController.text}",
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
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('user', phoneController.text);

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
              builder: (context) => const userPersonalDetail(),
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
  showDialogBox() => showCupertinoDialog<String>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('No Connection'),
      content: const Text('Please check your internet connectivity'),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            Navigator.pop(context, 'Cancel');
            setState(() => isAlertSet = false);
            isDeviceConnected =
            await InternetConnectionChecker().hasConnection;
            if (!isDeviceConnected && isAlertSet == false) {
              showDialogBox();
              setState(() => isAlertSet = true);
            }
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
