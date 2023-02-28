import 'package:flutter/material.dart';
import 'package:tastesonway/main.dart';
import 'package:tastesonway/screens/login%20-%20signup/signup.dart';
import 'package:tastesonway/theme_data.dart';

class Login extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),
        title: Text(
          'Login',
          style: cardTitleStyle20(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 230,
                width:MediaQuery.of(context).size.width,
                child: Image.asset('assets/images/logo.png'),
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
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email address';
                            } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          style: TextStyle(color: Colors.white), //<-- SEE HERE
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            fillColor: inputColor(),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            hintText: 'Username',
                            hintStyle: inputTextStyle16(),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            } else if (value.length < 8) {
                              return 'Password must be at least 8 characters long';
                            }
                            return null;
                          },
                          style: TextStyle(color: Colors.white), //<-- SEE HERE
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            fillColor: inputColor(),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            hintText: 'Password',
                            hintStyle: inputTextStyle16(),
                          ),
                        ),


                        SizedBox(height: 15,),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              // The form is valid, perform the login operation here
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Home()),
                              );
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
                                      'Login',
                                      style: mTextStyle14(),
                                    ),
                                  ))),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(child: Text('- Does not have account ? -')),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                              // The form is valid, perform the login operation here
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Signup()),
                              );

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
                                      'Register',
                                      style: mTextStyle14(),
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
                              Image.asset('./assets/images/google.png',height: 28,width: 28,),
                              Image.asset('./assets/images/facebook.png',height: 30,width: 30,),
                              Image.asset('./assets/images/apple.png',height: 30,width: 30,color: Colors.white,),
                              Image.asset('./assets/images/email.png',height: 30,width: 30,),

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
