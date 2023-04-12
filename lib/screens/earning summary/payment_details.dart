import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastesonway/screens/earning%20summary/payment_received.dart';
import '../../utils/theme_data.dart';

class PaymentDetails extends StatefulWidget {
  const PaymentDetails({Key? key}) : super(key: key);

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  int step = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [
      //pending payment
      SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Card(
                    shadowColor: Colors.black,
                    color: const Color.fromRGBO(64, 68, 81, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      height: 70,
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('key_Orders_Received'.tr,style: mTextStyle16(),),
                              Text('1 ${'key_order'.tr}',style: cTextStyle16(),),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text('key_ORDER_AMOUNT'.tr,style: mTextStyle16(),),
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
                    child: InkWell(
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
                          color: const Color.fromRGBO(53, 56, 66, 1),
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
              const SizedBox(height: 25),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Card(
                    shadowColor: Colors.black,
                    color: const Color.fromRGBO(64, 68, 81, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      height: 70,
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('key_Orders_Received'.tr,style: mTextStyle16(),),
                              Text('1 ${'key_order'.tr}',style: cTextStyle16(),),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text('key_ORDER_AMOUNT'.tr,style: mTextStyle16(),),
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
                    child: InkWell(
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
                          color: const Color.fromRGBO(53, 56, 66, 1),
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
              const SizedBox(height: 25),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Card(
                    shadowColor: Colors.black,
                    color: const Color.fromRGBO(64, 68, 81, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      height: 70,
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('key_Orders_Received'.tr,style: mTextStyle16(),),
                              Text('1 ${'key_order'.tr}',style: cTextStyle16(),),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text('key_ORDER_AMOUNT'.tr,style: mTextStyle16(),),
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
                    child: InkWell(
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
                          color: const Color.fromRGBO(53, 56, 66, 1),
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
            ],
          ),
        ),
      ),
      //payment received
      SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Card(
                    shadowColor: Colors.black,
                    color: const Color.fromRGBO(64, 68, 81, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      height: 70,
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('key_Orders_Received'.tr,style: mTextStyle16(),),
                              Text('1 ${'key_order'.tr}',style: cTextStyle16(),),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text('key_ORDER_AMOUNT'.tr,style: mTextStyle16(),),
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
                    child: InkWell(
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
                          color: const Color.fromRGBO(53, 56, 66, 1),
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
              const SizedBox(height: 25),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Card(
                    shadowColor: Colors.black,
                    color: const Color.fromRGBO(64, 68, 81, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      height: 70,
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('key_Orders_Received'.tr,style: mTextStyle16(),),
                              Text('1 ${'key_order'.tr}',style: cTextStyle16(),),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text('key_ORDER_AMOUNT'.tr,style: mTextStyle16(),),
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
                    child: InkWell(
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
                          color: const Color.fromRGBO(53, 56, 66, 1),
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
              const SizedBox(height: 25),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Card(
                    shadowColor: Colors.black,
                    color: const Color.fromRGBO(64, 68, 81, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      height: 70,
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('key_Orders_Received'.tr,style: mTextStyle16(),),
                              Text('1 ${'key_order'.tr}',style: cTextStyle16(),),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text('key_ORDER_AMOUNT'.tr,style: mTextStyle16(),),
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
                    child: InkWell(
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
                          color: const Color.fromRGBO(53, 56, 66, 1),
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
          'key_Orders_Captured_this_week'.tr,
          style: cardTitleStyle20(),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      step = 0;
                    });
                  },
                  child: Card(
                    shadowColor: Colors.black,
                    color: step == 0
                        ? orangeColor()
                        : const Color.fromRGBO(53, 56, 66, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2.3,
                      height: 45,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'key_Pending_Payment'.tr,
                            style: mTextStyle16(),
                          )),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      step = 1;
                    });
                  },
                  child: Card(
                    shadowColor: Colors.black,
                    color: step == 1
                        ? orangeColor()
                        : const Color.fromRGBO(53, 56, 66, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2.3,
                      height: 45,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'key_Payment_Received'.tr,
                            style: mTextStyle16(),
                          )),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            widgetList[step],
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
