import 'package:flutter/material.dart';
import 'package:tastesonway/theme_data.dart';

class YourOrders extends StatelessWidget {
  const YourOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),
        title: Text(
          'Your Orders',
          style: cardTitleStyle20(),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.filter_alt_outlined),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            SizedBox(
              height: 25,
            ),
            Stack(
              overflow: Overflow.visible,
              children: [
                SizedBox(
                  height: 180,
                  child: Card(
                    shadowColor: Colors.black,
                    color: Color.fromRGBO(64, 68, 81, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Order Received',
                                    style: mTextStyle16(),
                                  ),
                                  Text(
                                    '1 Order',
                                    style: cTextStyle16(),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Order Amount',
                                    style: mTextStyle16(),
                                  ),
                                  Text(
                                    '??? 50',
                                    style: cTextStyle16(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Divider(
                            height: 20,
                            color: Colors.white,
                            endIndent: 5,
                            indent: 5,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Order Status',
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
                                          'Order Ready (2:25)',
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
                  child: SizedBox(
                    height: 35,
                    width: 120,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Color.fromRGBO(53, 56, 66, 1),
                      child: Center(
                          child: Text(
                            '25th Nov 2022',
                            style: cTextStyle12(),
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            Stack(
              overflow: Overflow.visible,
              children: [
                SizedBox(
                  height: 180,
                  child: Card(
                    shadowColor: Colors.black,
                    color: Color.fromRGBO(64, 68, 81, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Order Received',
                                    style: mTextStyle16(),
                                  ),
                                  Text(
                                    '1 Order',
                                    style: cTextStyle16(),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Order Amount',
                                    style: mTextStyle16(),
                                  ),
                                  Text(
                                    '??? 50',
                                    style: cTextStyle16(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Divider(
                            height: 20,
                            color: Colors.white,
                            endIndent: 5,
                            indent: 5,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Order Status',
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
                                          'Order Ready (2:25)',
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
                  child: SizedBox(
                    height: 35,
                    width: 120,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Color.fromRGBO(53, 56, 66, 1),
                      child: Center(
                          child: Text(
                            '25th Nov 2022',
                            style: cTextStyle12(),
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
    );
  }
}
