import 'package:flutter/material.dart';
import 'package:tastesonway/theme_data.dart';

class ViewAddress extends StatelessWidget {
  const ViewAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            // setState(() {
            //   step != 0 ? step-- : null;
            // });
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          'View Address',
          style: cardTitleStyle20(),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit),
          ),
        ],
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          'Basic Details',
                          style: mTextStyle18(),
                        ),
                      ),

                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            fillColor: inputColor(),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            hintText: 'Your Location',
                            hintStyle: inputTextStyle16(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            fillColor: inputColor(),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            hintText: 'Kitchen Owner Name',
                            hintStyle: inputTextStyle16(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          cursorColor: Colors.white,
                          decoration: InputDecoration(

                            contentPadding: EdgeInsets.all(10.0),
                            fillColor: inputColor(),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            hintText: 'Address',
                            hintStyle: inputTextStyle16(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          cursorColor: Colors.white,
                          decoration: InputDecoration(

                            contentPadding: EdgeInsets.all(10.0),
                            fillColor: inputColor(),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            hintText: 'Landmark',
                            hintStyle: inputTextStyle16(),
                          ),
                        ),
                      ),
                      SizedBox(height:10),
                      SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          cursorColor: Colors.white,
                          decoration: InputDecoration(

                            contentPadding: EdgeInsets.all(10.0),
                            fillColor: inputColor(),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            hintText: 'Pin Code',
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

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          'Address Type',
                          style: mTextStyle18(),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(

                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Card(
                            shadowColor: Colors.black,
                            color: orangeColor(),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: SizedBox(
                              width: 80,
                              height: 35,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Home',
                                    style: mTextStyle16(),
                                  )),
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
                              width: 80,
                              height: 35,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Office',
                                    style: mTextStyle16(),
                                  )),
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
                              width: 80,
                              height: 35,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Other',
                                    style: mTextStyle16(),
                                  )),
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
            ),
          ],
        ),
      ),
    );
  }
}
