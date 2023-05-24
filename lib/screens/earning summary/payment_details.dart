import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastesonway/screens/earning%20summary/payment_received.dart';
import '../../apiServices/api_service.dart';
import '../../utils/sharedpreferences.dart';
import '../../utils/theme_data.dart';
import 'package:http/http.dart' as http;

class PaymentDetails extends StatefulWidget {
  final int step;
  PaymentDetails({required this.step});

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  int button = 0;
  bool isLoading = true;
  int refreshCounter = 0;
  List earningData = [];
  String date = '';
  Map<String, dynamic> data = {};

  String url = '';
  String name = '';
  String paymentStatus = '';
  String address = '';
  String deliveryTime = '';
  String orderAmount = '';
  String tax = '';
  String payment = '';

  Future fetchData(int step) async {
    print("step is ${widget.step}");
    String token = await Sharedprefrences.getToken();
    final response = await http
        .post(Uri.parse("$baseUrl/kitchen-Owner-earning-summary"), headers: {
      'Authorization': 'Bearer $token'
    }, body: {
      "day": widget.step == 2
          ? "total"
          : widget.step == 1
              ? "month"
              : "week"
    });

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      earningData = widget.step == 2
          ? jsonData['data']['kitchenOwnerEarningAmountsListsTotal'] as List
          : jsonData['data']['kitchenOwnerEarningAmountsList']['data'] as List;
      print(earningData);

      if (widget.step == 2) {
        data = Map.from(earningData[0]);
      }

      print(earningData);
      setState(() {
        isLoading = false;
      });
    } else if (response.statusCode == 401) {
      print("refresh token called");
      if (refreshCounter == 0) {
        refreshCounter++;
        bool tokenRefreshed = await getNewToken(context);
        tokenRefreshed ? fetchData(widget.step) : null;
      }
    } else {
      setState(() {
        isLoading = false;
      });
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  String _formatMonth(String month) {
    final parts = month.split(',');
    final monthName = parts[0];
    final year = parts[1];
    return '$monthName $year';
  }
  static String formatDateString(String date) {
    DateTime parsedDate = DateTime.parse(date);
    String formattedDate = DateFormat("d MMM").format(parsedDate);
    return formattedDate;
  }

  @override
  void initState() {
    fetchData(widget.step);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),
        title: widget.step == 0
            ? Text(
                'key_Orders_Captured_this_week'.tr,
                style: cardTitleStyle20(),
              )
            : widget.step == 1
                ? Text(
                    'key_Orders_Captured_this_month'.tr,
                    style: cardTitleStyle20(),
                  )
                : Text(
                    'key_Orders_Captured_total'.tr,
                    style: cardTitleStyle20(),
                  ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: orangeColor(),
              ),
            )
          : widget.step == 2
              ? Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final month = data.keys.toList()[index];
                        final value = data.values.toList()[index];
                        return Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Card(
                              shadowColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              color: cardColor(),
                              child: SizedBox(
                                height: 60,
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _formatMonth(month),
                                        style: mTextStyle16(),
                                      ),
                                      Text(
                                        '₹ $value',
                                        style: mTextStyle16(),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }))
              : Container(
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
                                button = 0;
                              });
                            },
                            child: Card(
                              shadowColor: Colors.black,
                              color: button == 0
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
                                button = 1;
                              });
                            },
                            child: Card(
                              shadowColor: Colors.black,
                              color: button == 1
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
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: earningData.length,
                          itemBuilder: (BuildContext context, int index) {
                            DateTime dateTime = DateFormat('yyyy-MM-dd').parse(
                                earningData[index]['date_for_incoming_order']);
                            String date =
                                DateFormat('dd-MM-yyyy').format(dateTime);

                            return Column(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Card(
                                              shadowColor: Colors.black,
                                              color: const Color.fromRGBO(
                                                  64, 68, 81, 1),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              child: Container(
                                                height: 100,
                                                margin:
                                                    const EdgeInsets.all(10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'key_Orders_Received'
                                                              .tr,
                                                          style: mTextStyle16(),
                                                        ),
                                                        Text(
                                                          '${earningData[index]['order_detail'].length} ${'key_order'.tr}',
                                                          style: cTextStyle16(),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'key_ORDER_AMOUNT'.tr,
                                                          style: mTextStyle16(),
                                                        ),
                                                        Text(
                                                          '₹ ${earningData[index]['order_total']}',
                                                          style: cTextStyle16(),
                                                        ),
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
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            PaymentReceived(
                                                              date: date,
                                                              deliveryDate: (formatDateString(earningData[0]['date_for_incoming_order']) +', '+ earningData[0]['time_for_incoming_order']).toString(),
                                                              quantity:(earningData[index]['order_detail'].length).toString(),
                                                              name: earningData[index]['user']['name'],
                                                              paymentStatus: earningData[index]['order_earning_summary']['payment_status'],
                                                              address: "${earningData[index]['user_address']['address']} ${earningData[index]['user_address']['area']}, ${earningData[index]['user_address']['land_mark']} ${earningData[index]['user_address']['city']['name']}, ${earningData[index]['user_address']['pin_code']}",
                                                              orderTotal: earningData[index]['order_total'].toString(),
                                                              orderDetail: earningData[index]['order_detail'],
                                                              discount: earningData[index]['coupon_amount'] == null ? "0" : earningData[index]['coupon_amount'].toString(),
                                                              yourEarning: earningData[index]['order_earning_summary']['owner_earning_amount'].toString(),
                                                            )),
                                                  );
                                                },
                                                child: SizedBox(
                                                  height: 30,
                                                  width: 120,
                                                  child: Card(
                                                    color: const Color.fromRGBO(
                                                        53, 56, 66, 1),
                                                    child: Center(
                                                        child: Text(
                                                      date,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily: 'Poppins',
                                                          color: orangeColor()),
                                                      textAlign:
                                                          TextAlign.center,
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
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            );
                          }),
                    ],
                  ),
                ),
    );
  }
}
