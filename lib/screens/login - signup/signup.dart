import 'package:flutter/material.dart';
import 'package:tastesonway/theme_data.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),
        title: Text(
          'Sign Up',
          style: cardTitleStyle20(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 230,
              width: MediaQuery.of(context).size.width,
              child: Image.asset('assets/images/mobile.png'),
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
                        IntlPhoneField(
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
                          onChanged: (phone) {
                            print(phone.completeNumber);
                          },
                          onCountryChanged: (country) {
                            print('Country changed to: ' + country.name);
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {

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
                                      'Verify',
                                      style: mTextStyle16(),
                                    ),
                                  ))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
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
                        ),
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
    );
  }
}
