import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastesonway/screens/earning%20summary/payment_details.dart';
import '../../utils/theme_data.dart';

class EarningSummary extends StatefulWidget {
  const EarningSummary({Key? key}) : super(key: key);

  @override
  State<EarningSummary> createState() => _EarningSummaryState();
}

class _EarningSummaryState extends State<EarningSummary> {
  int step = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [
      //week
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'key_Total_Earnings_this_week'.tr,
                    style: mTextStyle18(),
                  ),
                ),
                const SizedBox(height: 15),
                Stack(
                  clipBehavior: Clip.none, children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        shadowColor: Colors.black,
                        color: const Color.fromRGBO(37, 40, 48, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          height: 70,
                          margin: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment:MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                child: Text(
                                  'key_Includes_both_Recived_and_Pending_payment'.tr,
                                  style: cTextStyle16(),
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                              Text(
                                '₹ 200',
                                style: cardTextStyle18(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom:-10,
                      right:110,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PaymentDetails()),
                          );
                        },
                        child: SizedBox(
                          height:30,
                          width:100,
                          child: Card(
                            color: Color.fromRGBO(105, 111, 130, 1),
                            child: Center(child:
                            Text('key_View_Details'.tr,
                              style: TextStyle(fontSize: 12,fontFamily: 'Poppins'),
                              )),
                          ),
                        ),
                      ),
                    ),

                  ],

                ),
                const SizedBox(height: 25),
                Stack(
                  clipBehavior: Clip.none, children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shadowColor: Colors.black,
                      color: const Color.fromRGBO(37, 40, 48, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        height: 70,
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment:MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                              child: Text(
                                'key_Includes_both_Recived_and_Pending_payment'.tr,
                                style: cTextStyle16(),
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            Text(
                              '₹ 200',
                              style: cardTextStyle18(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom:-10,
                    right:110,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PaymentDetails()),
                        );
                      },
                      child: SizedBox(
                        height:30,
                        width:100,
                        child: Card(
                          color: Color.fromRGBO(105, 111, 130, 1),
                          child: Center(child:
                          Text('key_View_Details'.tr,
                            style: TextStyle(fontSize: 12,fontFamily: 'Poppins'),
                          )),
                        ),
                      ),
                    ),
                  ),

                ],

                ),
                const SizedBox(height: 25),
                Stack(
                  clipBehavior: Clip.none, children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shadowColor: Colors.black,
                      color: const Color.fromRGBO(37, 40, 48, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        height: 70,
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment:MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                              child: Text(
                                'key_Includes_both_Recived_and_Pending_payment'.tr,
                                style: cTextStyle16(),
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            Text(
                              '₹ 200',
                              style: cardTextStyle18(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom:-10,
                    right:110,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PaymentDetails()),
                        );
                      },
                      child: SizedBox(
                        height:30,
                        width:100,
                        child: Card(
                          color: Color.fromRGBO(105, 111, 130, 1),
                          child: Center(child:
                          Text('key_View_Details'.tr,
                            style: TextStyle(fontSize: 12,fontFamily: 'Poppins'),
                          )),
                        ),
                      ),
                    ),
                  ),

                ],

                ),
                const SizedBox(height: 25),
                Stack(
                  clipBehavior: Clip.none, children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shadowColor: Colors.black,
                      color: const Color.fromRGBO(37, 40, 48, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        height: 70,
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment:MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                              child: Text(
                                'key_Includes_both_Recived_and_Pending_payment'.tr,
                                style: cTextStyle16(),
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            Text(
                              '₹ 200',
                              style: cardTextStyle18(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom:-10,
                    right:110,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PaymentDetails()),
                        );
                      },
                      child: SizedBox(
                        height:30,
                        width:100,
                        child: Card(
                          color: Color.fromRGBO(105, 111, 130, 1),
                          child: Center(child:
                          Text('key_View_Details'.tr,
                            style: TextStyle(fontSize: 12,fontFamily: 'Poppins'),
                          )),
                        ),
                      ),
                    ),
                  ),

                ],

                ),
                const SizedBox(height: 25),

              ],
            ),
          ),
        ),
      ),
      //month
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'key_Total_Earnings_this_month'.tr,
                    style: mTextStyle18(),
                  ),
                ),
                const SizedBox(height: 15),
                Stack(
                  clipBehavior: Clip.none, children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shadowColor: Colors.black,
                      color: const Color.fromRGBO(37, 40, 48, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        height: 70,
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment:MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                              child: Text(
                                'key_Includes_both_Recived_and_Pending_payment'.tr,
                                style: cTextStyle16(),
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            Text(
                              '₹ 200',
                              style: cardTextStyle18(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom:-10,
                    right:110,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PaymentDetails()),
                        );
                      },
                      child: SizedBox(
                        height:30,
                        width:100,
                        child: Card(
                          color: Color.fromRGBO(105, 111, 130, 1),
                          child: Center(child:
                          Text('key_View_Details'.tr,
                            style: TextStyle(fontSize: 12,fontFamily: 'Poppins'),
                          )),
                        ),
                      ),
                    ),
                  ),

                ],

                ),
                const SizedBox(height: 25),
                Stack(
                  clipBehavior: Clip.none, children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shadowColor: Colors.black,
                      color: const Color.fromRGBO(37, 40, 48, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        height: 70,
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment:MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                              child: Text(
                                'key_Includes_both_Recived_and_Pending_payment'.tr,
                                style: cTextStyle16(),
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            Text(
                              '₹ 200',
                              style: cardTextStyle18(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom:-10,
                    right:110,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PaymentDetails()),
                        );
                      },
                      child: SizedBox(
                        height:30,
                        width:100,
                        child: Card(
                          color: Color.fromRGBO(105, 111, 130, 1),
                          child: Center(child:
                          Text('key_View_Details'.tr,
                            style: TextStyle(fontSize: 12,fontFamily: 'Poppins'),
                          )),
                        ),
                      ),
                    ),
                  ),

                ],

                ),
                const SizedBox(height: 25),
                Stack(
                  clipBehavior: Clip.none, children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shadowColor: Colors.black,
                      color: const Color.fromRGBO(37, 40, 48, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        height: 70,
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment:MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                              child: Text(
                                'key_Includes_both_Recived_and_Pending_payment'.tr,
                                style: cTextStyle16(),
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            Text(
                              '₹ 200',
                              style: cardTextStyle18(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom:-10,
                    right:110,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PaymentDetails()),
                        );
                      },
                      child: SizedBox(
                        height:30,
                        width:100,
                        child: Card(
                          color: Color.fromRGBO(105, 111, 130, 1),
                          child: Center(child:
                          Text('key_View_Details'.tr,
                            style: TextStyle(fontSize: 12,fontFamily: 'Poppins'),
                          )),
                        ),
                      ),
                    ),
                  ),

                ],

                ),
                const SizedBox(height: 25),
                Stack(
                  clipBehavior: Clip.none, children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shadowColor: Colors.black,
                      color: const Color.fromRGBO(37, 40, 48, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        height: 70,
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment:MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                              child: Text(
                                'key_Includes_both_Recived_and_Pending_payment'.tr,
                                style: cTextStyle16(),
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            Text(
                              '₹ 200',
                              style: cardTextStyle18(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom:-10,
                    right:110,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PaymentDetails()),
                        );
                      },
                      child: SizedBox(
                        height:30,
                        width:100,
                        child: Card(
                          color: Color.fromRGBO(105, 111, 130, 1),
                          child: Center(child:
                          Text('key_View_Details'.tr,
                            style: TextStyle(fontSize: 12,fontFamily: 'Poppins'),
                          )),
                        ),
                      ),
                    ),
                  ),

                ],

                ),
                const SizedBox(height: 25),

              ],
            ),
          ),
        ),
      ),
      //total
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'key_Total_Earnings'.tr,
                    style: mTextStyle18(),
                  ),
                ),
                const SizedBox(height: 15),
                Stack(
                  clipBehavior: Clip.none, children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shadowColor: Colors.black,
                      color: const Color.fromRGBO(37, 40, 48, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        height: 70,
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment:MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                              child: Text(
                                'key_Includes_both_Recived_and_Pending_payment'.tr,
                                style: cTextStyle16(),
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            Text(
                              '₹ 200',
                              style: cardTextStyle18(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom:-10,
                    right:110,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PaymentDetails()),
                        );
                      },
                      child: SizedBox(
                        height:30,
                        width:100,
                        child: Card(
                          color: Color.fromRGBO(105, 111, 130, 1),
                          child: Center(child:
                          Text('key_View_Details'.tr,
                            style: TextStyle(fontSize: 12,fontFamily: 'Poppins'),
                          )),
                        ),
                      ),
                    ),
                  ),

                ],

                ),
                const SizedBox(height: 25),
                Stack(
                  clipBehavior: Clip.none, children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shadowColor: Colors.black,
                      color: const Color.fromRGBO(37, 40, 48, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        height: 70,
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment:MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                              child: Text(
                                'key_Includes_both_Recived_and_Pending_payment'.tr,
                                style: cTextStyle16(),
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            Text(
                              '₹ 200',
                              style: cardTextStyle18(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom:-10,
                    right:110,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PaymentDetails()),
                        );
                      },
                      child: SizedBox(
                        height:30,
                        width:100,
                        child: Card(
                          color: Color.fromRGBO(105, 111, 130, 1),
                          child: Center(child:
                          Text('key_View_Details'.tr,
                            style: TextStyle(fontSize: 12,fontFamily: 'Poppins'),
                          )),
                        ),
                      ),
                    ),
                  ),

                ],

                ),
                const SizedBox(height: 25),
                Stack(
                  clipBehavior: Clip.none, children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shadowColor: Colors.black,
                      color: const Color.fromRGBO(37, 40, 48, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        height: 70,
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment:MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                              child: Text(
                                'key_Includes_both_Recived_and_Pending_payment'.tr,
                                style: cTextStyle16(),
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            Text(
                              '₹ 200',
                              style: cardTextStyle18(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom:-10,
                    right:110,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PaymentDetails()),
                        );
                      },
                      child: SizedBox(
                        height:30,
                        width:100,
                        child: Card(
                          color: Color.fromRGBO(105, 111, 130, 1),
                          child: Center(child:
                          Text('key_View_Details'.tr,
                            style: TextStyle(fontSize: 12,fontFamily: 'Poppins'),
                          )),
                        ),
                      ),
                    ),
                  ),

                ],

                ),
                const SizedBox(height: 25),
                Stack(
                  clipBehavior: Clip.none, children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shadowColor: Colors.black,
                      color: const Color.fromRGBO(37, 40, 48, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        height: 70,
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment:MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                              child: Text(
                                'key_Includes_both_Recived_and_Pending_payment'.tr,
                                style: cTextStyle16(),
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            Text(
                              '₹ 200',
                              style: cardTextStyle18(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom:-10,
                    right:110,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PaymentDetails()),
                        );
                      },
                      child: SizedBox(
                        height:30,
                        width:100,
                        child: Card(
                          color: Color.fromRGBO(105, 111, 130, 1),
                          child: Center(child:
                          Text('key_View_Details'.tr,
                            style: TextStyle(fontSize: 12,fontFamily: 'Poppins'),
                          )),
                        ),
                      ),
                    ),
                  ),

                ],

                ),
                const SizedBox(height: 25),

              ],
            ),
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
          'key_Earning_Summary'.tr,
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
              mainAxisAlignment: MainAxisAlignment.start,
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
                        : const Color.fromRGBO(53, 56, 66, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.28,
                      height: 45,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'key_This_Week'.tr,
                            style: mTextStyle16(),
                          )),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
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
                        : const Color.fromRGBO(53, 56, 66, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.28,
                      height: 45,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'key_This_Month'.tr,
                            style: mTextStyle16(),
                          )),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      step = 2;
                    });
                  },
                  child: Card(
                    shadowColor: Colors.black,
                    color: step == 2
                        ? orangeColor()
                        : const Color.fromRGBO(53, 56, 66, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.28,
                      height: 45,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'key_Total'.tr,
                            style: mTextStyle16(),
                          )),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
            const SizedBox(
              height: 25,
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
