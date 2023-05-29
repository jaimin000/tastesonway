import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastesonway/utils/theme_data.dart';

class PaymentReceived extends StatefulWidget {
  final String quantity;
  final String date;
  final String deliveryDate;
   final String name;
   final String paymentStatus;
   final String address;
    final String yourEarning;
    final String orderTotal;
     final List orderDetail;
    final String discount;

  PaymentReceived(
      {Key? key,
        required this.quantity,
        required this.date,
        required this.deliveryDate,
       required this.name,
       required this.paymentStatus,
       required this.address,
        required this.yourEarning,
        required this.orderTotal,
         required this.orderDetail,
        required this.discount,
      }) : super(key: key);

  @override
  State<PaymentReceived> createState() => _PaymentReceivedState();
}

class _PaymentReceivedState extends State<PaymentReceived> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: backgroundColor(),
          title: Text(
            'key_Payment_Received'.tr,
            style: cardTitleStyle20(),
          ),
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              physics: BouncingScrollPhysics(),
                children: [
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    'key_Basic_Details'.tr,
                                    style: mTextStyle18(),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Card(
                                    shadowColor: Colors.black,
                                    color: const Color.fromRGBO(37, 40, 48, 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Container(
                                      height: 30,
                                      margin: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              widget.date,
                                              style: cTextStyle16(),
                                              overflow: TextOverflow.clip,
                                            ),
                                          ),
                                          Text(
                                            '${widget.quantity} ${'key_order'.tr}',
                                            style: cTextStyle16(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const Divider(
                                  height: 30,
                                  indent: 10,
                                  endIndent: 10,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Card(
                                    shadowColor: Colors.black,
                                    color: const Color.fromRGBO(37, 40, 48, 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Container(
                                      height: 50,
                                      margin: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                           CircleAvatar(
                                             backgroundColor: orangeColor(),
                                             radius: 40,
                                             child: Text(
                                               widget.name[0],
                                               style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                             ),
                                          ),
                                          Text(
                                            widget.name,
                                            style: cardTextStyle18(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Card(
                                    shadowColor: Colors.black,
                                    // ignore: prefer_const_constructors
                                    color: Color.fromRGBO(37, 40, 48, 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Container(
                                      height: 30,
                                      margin: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'key_PAYMENT_STATUS'.tr,
                                            style: cTextStyle16(),
                                          ),
                                          Flexible(
                                            child: Text(
                                              widget.paymentStatus,
                                              style: cardTextStyle16(),
                                              overflow: TextOverflow.clip,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Card(
                                    shadowColor: Colors.black,
                                    color: const Color.fromRGBO(37, 40, 48, 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Container(
                                       height: 110,
                                      margin: const EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'key_DELIVERY_ADDRESS'.tr,
                                            style: cTextStyle16(),
                                          ),
                                          Flexible(
                                            child: Text(
                                              widget.address,
                                              style: cTextStyle14(),
                                              overflow: TextOverflow.clip,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Card(
                                    shadowColor: Colors.black,
                                    color: const Color.fromRGBO(37, 40, 48, 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Container(
                                      height: 30,
                                      margin: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'key_DELIVERY_TIME'.tr,
                                            style: cTextStyle16(),
                                          ),
                                          Flexible(
                                            child: Text(
                                              // '5th Dec 2022, 14:42',
                                              widget.deliveryDate,
                                              style: cTextStyle16(),
                                              overflow: TextOverflow.clip,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Card(
                                    shadowColor: Colors.black,
                                    color: const Color.fromRGBO(37, 40, 48, 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 8,),
                                    Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            'Item Name',
                                            style: cardTextStyle16(),
                                            overflow: TextOverflow.clip,
                                          ),
                                        ),
                                        Text(
                                          'Item Price',
                                          style: cardTextStyle16(),
                                        ),
                                      ],
                                    ),
                                  ),
                                        SizedBox(
                                          height: 150,
                                          child: ListView.builder(
                                              physics: BouncingScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: widget.orderDetail.length,
                                              itemBuilder: (BuildContext context, int index) {
                                            return Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      '${widget.orderDetail[index]['menu_items'][0]['name']}  X  ${widget.orderDetail[index]['quantity']} ',
                                                      style: cTextStyle16(),
                                                      overflow: TextOverflow.clip,
                                                    ),
                                                  ),
                                                  Text(
                                                    '₹ ${widget.orderDetail[index]['item_price']}',
                                                    style: cTextStyle16(),
                                                  ),
                                                ],
                                              ),
                                            );
    }
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Card(
                                    shadowColor: Colors.black,
                                    color: const Color.fromRGBO(37, 40, 48, 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Container(
                                      height: 30,
                                      margin: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              'key_Total'.tr,
                                              style: cTextStyle16(),
                                              overflow: TextOverflow.clip,
                                            ),
                                          ),
                                          Text(
                                            '₹ ${widget.orderTotal}',
                                            style: cTextStyle16(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                widget.discount != '0' ? const SizedBox(height: 5) : SizedBox(),
                                widget.discount != '0' ? SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Card(
                                    shadowColor: Colors.black,
                                    color: const Color.fromRGBO(37, 40, 48, 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Container(
                                      height: 30,
                                      margin: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              'key_discounted_amount'.tr,
                                              style: cTextStyle16(),
                                              overflow: TextOverflow.clip,
                                            ),
                                          ),
                                          Text(
                                            '₹ ${widget.discount}',
                                            style: cTextStyle16(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ) : SizedBox(),
                                const SizedBox(height: 5),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Card(
                                    shadowColor: Colors.black,
                                    color: const Color.fromRGBO(37, 40, 48, 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Container(
                                      height: 30,
                                      margin: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              'key_Your_Earnings'.tr,
                                              style: cTextStyle16(),
                                              overflow: TextOverflow.clip,
                                            ),
                                          ),
                                          Text(
                                            '₹ ${widget.yourEarning}',
                                            style: cTextStyle16(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ]))))
            ])));
  }
}
