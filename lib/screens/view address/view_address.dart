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

        title: Text(
          'View Address',
          style: cardTitleStyle20(),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            const SizedBox(
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
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          'Basic Details',
                          style: mTextStyle18(),
                        ),
                      ),

                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          style: const TextStyle(color: Colors.white), //<-- SEE HERE
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10.0),
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
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          style: const TextStyle(color: Colors.white), //<-- SEE HERE

                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10.0),
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
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          style: const TextStyle(color: Colors.white), //<-- SEE HERE

                          cursorColor: Colors.white,
                          decoration: InputDecoration(

                            contentPadding: const EdgeInsets.all(10.0),
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
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          style: const TextStyle(color: Colors.white), //<-- SEE HERE

                          cursorColor: Colors.white,
                          decoration: InputDecoration(

                            contentPadding: const EdgeInsets.all(10.0),
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
                      const SizedBox(height:10),
                      SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          style: const TextStyle(color: Colors.white), //<-- SEE HERE

                          cursorColor: Colors.white,
                          decoration: InputDecoration(

                            contentPadding: const EdgeInsets.all(10.0),
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
                      const SizedBox(height: 10,),
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
                      const SizedBox(
                        height: 10,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          'Address Type',
                          style: mTextStyle18(),
                        ),
                      ),
                      const SizedBox(
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
                          const SizedBox(
                            width: 5,
                          ),
                          Card(
                            shadowColor: Colors.black,
                            color: const Color.fromRGBO(53, 56, 66, 1),
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
                          const SizedBox(
                            width: 5,
                          ),
                          Card(
                            shadowColor: Colors.black,
                            color: const Color.fromRGBO(53, 56, 66, 1),
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
                      const SizedBox(
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
