import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tastesonway/screens/register/userPersonalDetail.dart';
import 'package:tastesonway/utils/theme_data.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  final _key = UniqueKey();
  late WebViewController webViewControllers;
  bool agree = false;
  bool showAgreeMessage = false;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      webViewControllers.loadUrl('https://www.tastesonway.com/Terms-of-Service');
    });
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

  showPrivacyPolicyDialog(BuildContext context) {
    showDialog(
        context: context,
        useRootNavigator: true,
        barrierDismissible: false,
        builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext context, state) => AlertDialog(
              backgroundColor: cardColor(),
              content: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                          height: 400,
                          child: WebView(
                            key: _key,
                            initialUrl: 'https://www.tastesonway.com/Terms-of-Service',
                            javascriptMode: JavascriptMode.unrestricted,
                            onWebViewCreated:
                                (WebViewController webViewController) {
                              webViewControllers = webViewController;
                            },
                            onProgress: (int progress) {
                              print(
                                  'WebView is loading (progress : $progress%)');
                            },
                            navigationDelegate: (NavigationRequest request) {
                              print('allowing navigation to $request');
                              return NavigationDecision.navigate;
                            },
                            onPageStarted: (String url) {
                              print('Page started loading: $url');
                            },
                            onPageFinished: (String url) {
                              print('Page finished loading: $url');
                            },
                            // gestureNavigationEnabled: true,
                          )),
                      Row(
                        children: [
                          Checkbox(
                            value: agree,
                            checkColor: Colors.black,
                            activeColor: orangeColor(),
                            onChanged: (value) {
                              state(() {
                                agree = value!;
                                if (value) {
                                  showAgreeMessage = false;
                                }
                              });
                            },
                          ),
                          Expanded(
                              child: Text(
                                'key_I_have_read'.tr,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )),
                        ],
                      ),
                      showAgreeMessage
                          ? Text(
                        'key_Select_checkbox_for_agree'.tr,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.red),
                      )
                          : Container(),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: orangeColor(),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Center(
                                    child: Text(
                                      'key_Cancel'.tr
                                          .toUpperCase(),
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    )),
                              ),
                              const SizedBox(height: 10,width: 10,),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: orangeColor(),
                                ),
                                onPressed: () {
                                  state(() {
                                    showAgreeMessage = true;
                                  });
                                  if (agree) {
                                    Navigator.pop(context);
                                    state(() {
                                      showAgreeMessage = false;
                                      agree = false;
                                    });
                                  }
                                },
                                child: Center(
                                    child: Text(
                                      'key_Agree'.tr.toUpperCase(),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: agree
                                              ? Colors.white
                                              : Colors.grey),
                                    )),
                              ),
                            ],
                          ))
                    ],
                  )),
              // );
            )));
  }

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

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
          otpVisibility? 'key_Enter_otp'.tr : 'key_register'.tr,
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
                  SizedBox(
                    height: 230,
                    width: MediaQuery.of(context).size.width,
                    child: otpVisibility ? Image.asset('assets/images/otp.png') :Image.asset('assets/images/mobile.png'),
                  ),
                  SizedBox(height: 20,),
                  otpVisibility?Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'key_Enter_your_security_code'.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          'key_OTP_has_been_sent_to_your_mobile'.tr,
                          style: const TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ):Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'key_Enter_your_mobile_number'.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20.0),
                      ),
                      Text(
                        'key_to_create_account'.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          'key_We_will_text_you'.tr,
                          style: const TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
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
                              InkWell(
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
                                            otpVisibility ? "key_Click_Verify_Button".tr : "key_Verify_OTP".tr,
                                            style: mTextStyle16(),
                                          ),
                                        ))),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  otpVisibility ?const SizedBox(): Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, bottom: 20),
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                  'key_By_completing_registration'.tr,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white),
                                ),
                                TextSpan(
                                  text: 'key_Privacy_policy'.tr,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                       showPrivacyPolicyDialog(context);
                                       _onItemTapped(0);
                                    },
                                  style: const TextStyle(
                                      decoration:
                                      TextDecoration.underline,
                                      fontSize: 14,
                                      color: Colors.white),
                                ),
                                const TextSpan(text: ' & '),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      showPrivacyPolicyDialog(context);
                                      _onItemTapped(1);
                                    },
                                  text: 'key_Terms_Of_service'.tr,
                                  style: const TextStyle(
                                      decoration:
                                      TextDecoration.underline,
                                      fontSize: 14,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ))),
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
            msg: "key_login_success".tr,
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
      title:  Text('key_Check_your_connection'.tr),
      content:  Text('key_No_Internet_connection_found'.tr),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            Navigator.pop(context, 'key_CANCEL'.tr);
            setState(() => isAlertSet = false);
            isDeviceConnected =
            await InternetConnectionChecker().hasConnection;
            if (!isDeviceConnected && isAlertSet == false) {
              showDialogBox();
              setState(() => isAlertSet = true);
            }
          },
          child: Text('key_OKAY'.tr),
        ),
      ],
    ),
  );
}
