import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastesonway/screens/earning%20summary/payment_details.dart';
import '../../utils/theme_data.dart';

class EarningSummary extends StatefulWidget {
  final int week;
  final int month;
  final int total;

  EarningSummary({required this.week,required this.month,required this.total});

  @override
  State<EarningSummary> createState() => _EarningSummaryState();
}

class _EarningSummaryState extends State<EarningSummary> {
  bool isLoading = true;
  int step = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),

        title: Text(
          'key_Earning_Summary'.tr,
          style: cardTitleStyle20(),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context,"true");
          },
          icon:const Icon(Icons.arrow_back_ios),
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
                InkWell(
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
                    child:  step == 0 ? Text(
                      'key_Total_Earnings_this_week'.tr,
                      style: mTextStyle18(),
                      overflow: TextOverflow.clip,
                    ): step == 1 ? Text(
                      'key_Total_Earnings_this_month'.tr,
                      style: mTextStyle18(),
                    ): Text(
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
                              step == 0 ? Text(
                                '₹ ${widget.week}',
                                style: cardTextStyle18(),
                              ) : step == 1 ? Text(
                                '₹ ${widget.month}',
                                style: cardTextStyle18(),
                              ) : Text(
                                '₹ ${widget.total}',
                                style: cardTextStyle18(),
                              )  ,
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom:-10,
                      right:110,
                      child: InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  PaymentDetails(step:step??0)),
                          );
                        },
                        child: SizedBox(
                          height:30,
                          width:100,
                          child: Card(
                            color: const Color.fromRGBO(105, 111, 130, 1),
                            child: Center(child:
                            Text('key_View_Details'.tr,
                              style: const TextStyle(fontSize: 12,fontFamily: 'Poppins'),
                            )),
                          ),
                        ),
                      ),
                    ),
                  ],

                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
