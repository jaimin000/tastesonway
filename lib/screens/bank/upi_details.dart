import 'package:flutter/material.dart';
import 'package:tastesonway/theme_data.dart';

class UPIDetails extends StatelessWidget {
  const UPIDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),

        title: Text(
          'UPI Details',
          style: cardTitleStyle20(),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            SizedBox(
              height: 25,
            ),

            Card(
              shadowColor: Colors.black,
              color: cardColor(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: SizedBox(

                width: MediaQuery.of(context).size.width,
                child: Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Basic Details',
                        style: mTextStyle18(),
                      ),

                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          style: TextStyle(color: Colors.white), //<-- SEE HERE
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            fillColor: inputColor(),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            hintText: 'UPI ID',
                            hintStyle: inputTextStyle16(),
                          ),
                        ),
                      ),


                      SizedBox(height: 10,),
                      SizedBox(
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
                                  'Proceed',
                                  style: mTextStyle14(),
                                ),
                              ))),
                      SizedBox(
                        height: 10,
                      ),
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
