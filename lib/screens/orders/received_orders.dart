import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastesonway/screens/orders/order_details.dart';
import '../../utils/theme_data.dart';

class ReceivedOrders extends StatefulWidget {
  const ReceivedOrders({Key? key}) : super(key: key);

  @override
  State<ReceivedOrders> createState() => _ReceivedOrdersState();
}

class _ReceivedOrdersState extends State<ReceivedOrders> {
  int step = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [
      //today
      Column(
        children: [
          Stack(
            clipBehavior: Clip.none, children: [
              SizedBox(
                height: 180,
                child: Card(
                  shadowColor: Colors.black,
                  color: const Color.fromRGBO(64, 68, 81, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'key_Orders_Received'.tr,
                                  style: mTextStyle16(),
                                ),
                                Text(
                                  '1 ${'key_order'.tr}',
                                  style: cTextStyle16(),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'key_ORDER_AMOUNT'.tr,
                                  style: mTextStyle16(),
                                ),
                                Text(
                                  '₹ 50',
                                  style: cTextStyle16(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Divider(
                          height: 20,
                          color: Colors.white,
                          endIndent: 5,
                          indent: 5,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'key_ORDER_STATUS'.tr,
                                  style: mTextStyle16(),
                                ),
                                Text(
                                  'Pending',
                                  style: cTextStyle16(),
                                ),
                              ],
                            ),
                            SizedBox(
                                height: 35,
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Card(
                                    shadowColor: Colors.black,
                                    color: orangeColor(),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '${'key_Order_Ready'.tr} (2:25)',
                                        style: mTextStyle14(),
                                      ),
                                    ))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: -10,
                right: 120,
                child: InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const OrderDetails()),
                    // );
                  },
                  child: SizedBox(
                    height: 35,
                    width: 120,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: const Color.fromRGBO(53, 56, 66, 1),
                      child: Center(
                          child: Text(
                        '25th Nov 2022',
                        style: cTextStyle12(),
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
            clipBehavior: Clip.none, children: [
            SizedBox(
              height: 180,
              child: Card(
                shadowColor: Colors.black,
                color: const Color.fromRGBO(64, 68, 81, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'key_Orders_Received'.tr,
                                style: mTextStyle16(),
                              ),
                              Text(
                                '1 ${'key_order'.tr}',
                                style: cTextStyle16(),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'key_ORDER_AMOUNT'.tr,
                                style: mTextStyle16(),
                              ),
                              Text(
                                '₹ 50',
                                style: cTextStyle16(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Divider(
                        height: 20,
                        color: Colors.white,
                        endIndent: 5,
                        indent: 5,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'key_ORDER_STATUS'.tr,
                                style: mTextStyle16(),
                              ),
                              Text(
                                'Pending',
                                style: cTextStyle16(),
                              ),
                            ],
                          ),
                          SizedBox(
                              height: 35,
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Card(
                                  shadowColor: Colors.black,
                                  color: orangeColor(),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${'key_Order_Ready'.tr} (2:25)',
                                      style: mTextStyle14(),
                                    ),
                                  ))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: -10,
              right: 120,
              child: InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const OrderDetails()),
                  // );
                },
                child: SizedBox(
                  height: 35,
                  width: 120,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: const Color.fromRGBO(53, 56, 66, 1),
                    child: Center(
                        child: Text(
                          '25th Nov 2022',
                          style: cTextStyle12(),
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
      //tomorrow
      Column(
        children: [
          Stack(
            clipBehavior: Clip.none, children: [
            SizedBox(
              height: 180,
              child: Card(
                shadowColor: Colors.black,
                color: const Color.fromRGBO(64, 68, 81, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'key_Orders_Received'.tr,
                                style: mTextStyle16(),
                              ),
                              Text(
                                '1 ${'key_order'.tr}',
                                style: cTextStyle16(),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'key_ORDER_AMOUNT'.tr,
                                style: mTextStyle16(),
                              ),
                              Text(
                                '₹ 50',
                                style: cTextStyle16(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Divider(
                        height: 20,
                        color: Colors.white,
                        endIndent: 5,
                        indent: 5,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'key_ORDER_STATUS'.tr,
                                style: mTextStyle16(),
                              ),
                              Text(
                                'Pending',
                                style: cTextStyle16(),
                              ),
                            ],
                          ),
                          SizedBox(
                              height: 35,
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Card(
                                  shadowColor: Colors.black,
                                  color: orangeColor(),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${'key_Order_Ready'.tr} (2:25)',
                                      style: mTextStyle14(),
                                    ),
                                  ))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: -10,
              right: 120,
              child: InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const OrderDetails()),
                  // );
                },
                child: SizedBox(
                  height: 35,
                  width: 120,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: const Color.fromRGBO(53, 56, 66, 1),
                    child: Center(
                        child: Text(
                          '25th Nov 2022',
                          style: cTextStyle12(),
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
            clipBehavior: Clip.none, children: [
            SizedBox(
              height: 180,
              child: Card(
                shadowColor: Colors.black,
                color: const Color.fromRGBO(64, 68, 81, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'key_Orders_Received'.tr,
                                style: mTextStyle16(),
                              ),
                              Text(
                                '1 ${'key_order'.tr}',
                                style: cTextStyle16(),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'key_ORDER_AMOUNT'.tr,
                                style: mTextStyle16(),
                              ),
                              Text(
                                '₹ 50',
                                style: cTextStyle16(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Divider(
                        height: 20,
                        color: Colors.white,
                        endIndent: 5,
                        indent: 5,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'key_ORDER_STATUS'.tr,
                                style: mTextStyle16(),
                              ),
                              Text(
                                'Pending',
                                style: cTextStyle16(),
                              ),
                            ],
                          ),
                          SizedBox(
                              height: 35,
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Card(
                                  shadowColor: Colors.black,
                                  color: orangeColor(),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${'key_Order_Ready'.tr} (2:25)',
                                      style: mTextStyle14(),
                                    ),
                                  ))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: -10,
              right: 120,
              child: InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const OrderDetails()),
                  // );
                },
                child: SizedBox(
                  height: 35,
                  width: 120,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: const Color.fromRGBO(53, 56, 66, 1),
                    child: Center(
                        child: Text(
                          '25th Nov 2022',
                          style: cTextStyle12(),
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
      //other
      Column(
        children: [
          Stack(
            clipBehavior: Clip.none, children: [
            SizedBox(
              height: 180,
              child: Card(
                shadowColor: Colors.black,
                color: const Color.fromRGBO(64, 68, 81, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'key_Orders_Received'.tr,
                                style: mTextStyle16(),
                              ),
                              Text(
                                '1 ${'key_order'.tr}',
                                style: cTextStyle16(),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'key_ORDER_AMOUNT'.tr,
                                style: mTextStyle16(),
                              ),
                              Text(
                                '₹ 50',
                                style: cTextStyle16(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Divider(
                        height: 20,
                        color: Colors.white,
                        endIndent: 5,
                        indent: 5,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'key_ORDER_STATUS'.tr,
                                style: mTextStyle16(),
                              ),
                              Text(
                                'Pending',
                                style: cTextStyle16(),
                              ),
                            ],
                          ),
                          SizedBox(
                              height: 35,
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Card(
                                  shadowColor: Colors.black,
                                  color: orangeColor(),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${'key_Order_Ready'.tr} (2:25)',
                                      style: mTextStyle14(),
                                    ),
                                  ))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: -10,
              right: 120,
              child: InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const OrderDetails()),
                  // );
                },
                child: SizedBox(
                  height: 35,
                  width: 120,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: const Color.fromRGBO(53, 56, 66, 1),
                    child: Center(
                        child: Text(
                          '25th Nov 2022',
                          style: cTextStyle12(),
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
            clipBehavior: Clip.none, children: [
            SizedBox(
              height: 180,
              child: Card(
                shadowColor: Colors.black,
                color: const Color.fromRGBO(64, 68, 81, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'key_Orders_Received'.tr,
                                style: mTextStyle16(),
                              ),
                              Text(
                                '1 ${'key_order'.tr}',
                                style: cTextStyle16(),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'key_ORDER_AMOUNT'.tr,
                                style: mTextStyle16(),
                              ),
                              Text(
                                '₹ 50',
                                style: cTextStyle16(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Divider(
                        height: 20,
                        color: Colors.white,
                        endIndent: 5,
                        indent: 5,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'key_ORDER_STATUS'.tr,
                                style: mTextStyle16(),
                              ),
                              Text(
                                'Pending',
                                style: cTextStyle16(),
                              ),
                            ],
                          ),
                          SizedBox(
                              height: 35,
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Card(
                                  shadowColor: Colors.black,
                                  color: orangeColor(),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${'key_Order_Ready'.tr} (2:25)',
                                      style: mTextStyle14(),
                                    ),
                                  ))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: -10,
              right: 120,
              child: InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const OrderDetails()),
                  // );
                },
                child: SizedBox(
                  height: 35,
                  width: 120,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: const Color.fromRGBO(53, 56, 66, 1),
                    child: Center(
                        child: Text(
                          '25th Nov 2022',
                          style: cTextStyle12(),
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
    ];
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),

        title: Text(
          'key_Orders_Received'.tr,
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
                      width: MediaQuery.of(context).size.width * 0.28,
                      height: 45,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'key_Today'.tr,
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
                            'key_Tomorrow'.tr,
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
                            'key_other'.tr,
                            style: mTextStyle16(),
                          )),
                    ),
                  ),
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
