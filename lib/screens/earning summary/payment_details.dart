import 'package:flutter/material.dart';
import 'package:tastesonway/screens/earning%20summary/payment_received.dart';
import '../../theme_data.dart';

class PaymentDetails extends StatefulWidget {
  const PaymentDetails({Key? key}) : super(key: key);

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  int step = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetList = [
      //pending payment
      SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Card(
                    shadowColor: Colors.black,
                    color: Color.fromRGBO(64, 68, 81, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      height: 70,
                      margin: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Order Received',style: mTextStyle16(),),
                              Text('1 Order',style: cTextStyle16(),),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text('Order Amount',style: mTextStyle16(),),
                              Text('₹ 50',style: cTextStyle16(),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -10,
                    right: 110,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PaymentReceived()),
                        );
                      },
                      child: SizedBox(
                        height: 30,
                        width: 120,
                        child: Card(
                          color: Color.fromRGBO(53, 56, 66, 1),
                          child: Center(
                              child: Text(
                            '5th Dec 2022',
                            style: TextStyle(
                              fontSize: 12,
                                fontFamily: 'Poppins', color: orangeColor()),
                            textAlign: TextAlign.center,
                          )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shadowColor: Colors.black,
                      color: Color.fromRGBO(64, 68, 81, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        height: 70,
                        margin: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text('Order Received',style: mTextStyle16(),),
                                Text('1 Order',style: cTextStyle16(),),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text('Order Amount',style: mTextStyle16(),),
                                Text('₹ 50',style: cTextStyle16(),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -10,
                    right: 110,
                    child: SizedBox(
                      height: 30,
                      width: 120,
                      child: Card(
                        color: Color.fromRGBO(53, 56, 66, 1),
                        child: Center(
                            child: Text(
                              '5th Dec 2022',
                              style: TextStyle(fontSize: 12,
                                  fontFamily: 'Poppins', color: orangeColor()),
                              textAlign: TextAlign.center,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shadowColor: Colors.black,
                      color: Color.fromRGBO(64, 68, 81, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        height: 70,
                        margin: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text('Order Received',style: mTextStyle16(),),
                                Text('1 Order',style: cTextStyle16(),),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text('Order Amount',style: mTextStyle16(),),
                                Text('₹ 50',style: cTextStyle16(),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -10,
                    right: 110,
                    child: SizedBox(
                      height: 30,
                      width: 120,
                      child: Card(
                        color: Color.fromRGBO(53, 56, 66, 1),
                        child: Center(
                            child: Text(
                              '5th Dec 2022',
                              style: TextStyle(fontSize: 12,
                                  fontFamily: 'Poppins', color: orangeColor()),
                              textAlign: TextAlign.center,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      //payment received
      SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shadowColor: Colors.black,
                      color: Color.fromRGBO(64, 68, 81, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        height: 70,
                        margin: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text('Order Received',style: mTextStyle16(),),
                                Text('1 Order',style: cTextStyle16(),),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text('Order Amount',style: mTextStyle16(),),
                                Text('₹ 50',style: cTextStyle16(),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -10,
                    right: 110,
                    child: SizedBox(
                      height: 30,
                      width: 120,
                      child: Card(
                        color: Color.fromRGBO(53, 56, 66, 1),
                        child: Center(
                            child: Text(
                              '5th Dec 2022',
                              style: TextStyle(fontSize: 12,
                                  fontFamily: 'Poppins', color: orangeColor()),
                              textAlign: TextAlign.center,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Stack(
                clipBehavior: Clip.none, children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shadowColor: Colors.black,
                      color: Color.fromRGBO(64, 68, 81, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        height: 70,
                        margin: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text('Order Received',style: mTextStyle16(),),
                                Text('1 Order',style: cTextStyle16(),),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text('Order Amount',style: mTextStyle16(),),
                                Text('₹ 50',style: cTextStyle16(),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -10,
                    right: 110,
                    child: SizedBox(
                      height: 30,
                      width: 120,
                      child: Card(
                        color: Color.fromRGBO(53, 56, 66, 1),
                        child: Center(
                            child: Text(
                              '5th Dec 2022',
                              style: TextStyle(fontSize: 12,
                                  fontFamily: 'Poppins', color: orangeColor()),
                              textAlign: TextAlign.center,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Stack(
                clipBehavior: Clip.none, children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shadowColor: Colors.black,
                      color: Color.fromRGBO(64, 68, 81, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        height: 70,
                        margin: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text('Order Received',style: mTextStyle16(),),
                                Text('1 Order',style: cTextStyle16(),),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text('Order Amount',style: mTextStyle16(),),
                                Text('₹ 50',style: cTextStyle16(),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -10,
                    right: 110,
                    child: SizedBox(
                      height: 30,
                      width: 120,
                      child: Card(
                        color: Color.fromRGBO(53, 56, 66, 1),
                        child: Center(
                            child: Text(
                              '5th Dec 2022',
                              style: TextStyle(fontSize: 12,
                                  fontFamily: 'Poppins', color: orangeColor()),
                              textAlign: TextAlign.center,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),

        title: Text(
          'Order From This Week',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      step = 0;
                    });
                  },
                  child: Card(
                    shadowColor: Colors.black,
                    color: step == 0
                        ? orangeColor()
                        : Color.fromRGBO(53, 56, 66, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2.3,
                      height: 45,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Pending Payment',
                            style: mTextStyle16(),
                          )),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      step = 1;
                    });
                  },
                  child: Card(
                    shadowColor: Colors.black,
                    color: step == 1
                        ? orangeColor()
                        : Color.fromRGBO(53, 56, 66, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2.3,
                      height: 45,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Payment Received',
                            style: mTextStyle16(),
                          )),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            _widgetList[step],
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
