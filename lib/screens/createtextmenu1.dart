import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../themedata.dart';

class CreateTextMenu1 extends StatelessWidget {
  const CreateTextMenu1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _switchValue = true;
    return Scaffold(
      backgroundColor: Color.fromRGBO(105, 111, 130, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(105, 111, 130, 1),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          'Create New Text Menu',
          style: TextStyle(
            color: Color.fromRGBO(53, 56, 66, 1),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(7),
        padding: EdgeInsets.all(7),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Create Text Menu",
                style: mTextStyle20(),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  shadowColor: Colors.black,
                  color: Color.fromRGBO(255, 114, 105, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: SizedBox(
                    width: 100,
                    height: 45,
                    child: Align(
                        alignment: Alignment.center, child: Text('Step 1',style: mTextStyle16(),)),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Card(
                  shadowColor: Colors.black,
                  color: Color.fromRGBO(53, 56, 66, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: SizedBox(
                    width: 100,
                    height: 45,
                    child: Align(
                        alignment: Alignment.center, child: Text('Step 2',style: mTextStyle16(),)),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Card(
                  shadowColor: Colors.black,
                  color: Color.fromRGBO(53, 56, 66, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: SizedBox(
                    width: 100,
                    height: 45,
                    child: Align(
                        alignment: Alignment.center, child: Text('Step 3',style: mTextStyle16(),)),
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
            Card(
              shadowColor: Colors.black,
              color: Color.fromRGBO(64, 68, 81, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: SizedBox(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Basic Details',
                        style: mTextStyle16(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // SizedBox(
                      //   height: 50,
                      //   width: MediaQuery.of(context).size.width * 0.9,
                      //   child: TextField(
                      //     cursorColor: Colors.white,
                      //     decoration: InputDecoration(
                      //       fillColor: Color.fromRGBO(37, 40, 48, 1),
                      //       filled: true,
                      //       border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(15),
                      //           borderSide: BorderSide.none),
                      //       hintText: 'Name Your Menu',
                      //       hintStyle: TextStyle(
                      //           color: Color.fromRGBO(100, 107, 125, 1),
                      //           fontSize: 14),
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0,right:4.0),
                        child: SizedBox(
                          height: 45,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: TextField(
                            cursorColor: Colors.white,
                                decoration: InputDecoration(
                                  fillColor: Color.fromRGBO(37, 40, 48, 1),
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none),
                                  hintText: 'Name Your Menu',
                                  hintStyle: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color.fromRGBO(100, 107, 125, 1),
                                      fontSize: 16),
                                ),
                          ),
                        ),
                      ),

                      SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Card(
                              shadowColor: Colors.black,
                              color: Color.fromRGBO(37, 40, 48, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'This is Permanent Menu',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Color.fromRGBO(100, 107, 125, 1),
                                          fontSize: 14),
                                    ),
                                  ),
                                  Transform.scale(
                                    scale: 0.8,
                                    child: CupertinoSwitch(
                                        thumbColor: Colors.black,
                                        activeColor:
                                            Color.fromRGBO(255, 114, 105, 1),
                                        value: _switchValue,
                                        onChanged: null),
                                  ),
                                ],
                              ),
                          ),
                      ),
                      SizedBox(height: 20,),
                      SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Card(
                              shadowColor: Colors.black,
                              color:  Color.fromRGBO(255, 114, 105, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Proceed',
                                  style: mTextStyle14(),
                                ),
                              ))),
                    ],
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
