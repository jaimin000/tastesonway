import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../theme_data.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class CreateTextMenu3 extends StatefulWidget {
  CreateTextMenu3({Key? key}) : super(key: key);
  @override
  State<CreateTextMenu3> createState() => _CreateTextMenu3State();
}

class _CreateTextMenu3State extends State<CreateTextMenu3> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),
        title: Text(
          'Create New Text Menu',
          style: cardTitleStyle20(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Create Text Menu",
                  style: mTextStyle20(),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    shadowColor: Colors.black,
                    color: Color.fromRGBO(53, 56, 66, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.28,
                      height: 45,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Step 1',
                            style: mTextStyle16(),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Card(
                    shadowColor: Colors.black,
                    color:  Color.fromRGBO(53, 56, 66, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.28,
                      height: 45,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Step 2',
                            style: mTextStyle16(),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Card(
                    shadowColor: Colors.black,
                    color: orangeColor(),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.28,
                      height: 45,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Step 3',
                            style: mTextStyle16(),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shadowColor: Colors.black,
                      color: cardColor(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                './assets/images/tea.jpg',
                                height: 90,
                                width: 95,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Masala Tea',
                                    style: mTextStyle20(),
                                  ),
                                  Text(
                                    '₹ 200',
                                    style: cTextStyle18(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shadowColor: Colors.black,
                      color: cardColor(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                './assets/images/tea.jpg',
                                height: 90,
                                width: 95,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Masala Tea',
                                    style: mTextStyle20(),
                                  ),
                                  Text(
                                    '₹ 200',
                                    style: cTextStyle18(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shadowColor: Colors.black,
                      color: cardColor(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                './assets/images/tea.jpg',
                                height: 90,
                                width: 95,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Masala Tea',
                                    style: mTextStyle20(),
                                  ),
                                  Text(
                                    '₹ 200',
                                    style: cTextStyle18(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await Share.share("This is my Menu");
                    },
                    child: SizedBox(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        shadowColor: Colors.black,
                        color: orangeColor(),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                './assets/images/whatsapp.png',
                                width: 24,
                                height: 24,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                child: Text(
                                  'Whatsapp',
                                  style: mTextStyle14(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
