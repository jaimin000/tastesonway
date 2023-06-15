import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastesonway/screens/orders/history/orderhistorydetail.dart';
import 'package:tastesonway/utils/theme_data.dart';
import 'package:http/http.dart' as http;
import '../../../apiServices/api_service.dart';
import '../../../utils/sharedpreferences.dart';
import '../../../utils/timer.dart';
import 'package:intl/intl.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  int refreshCounter = 0;
  List orderHistoryData = [];
  bool isLoading = true;
  String filter = "all";

  int calculateRemainingMinutes(String futureTime) {
    print(futureTime);
    final currentTime = DateTime.now();
    final apiTime = DateTime.parse(futureTime);

    final remainingTime = apiTime.difference(currentTime);
    final remainingSeconds = remainingTime.inSeconds;

    print(remainingSeconds);
    return remainingSeconds < 0 ? 0 : remainingSeconds;
  }


  String getFormatedDate(String date) {
    var tempDate = DateFormat("MMM dd, yyyy hh:mm:ss a").parse(date);

    return DateFormat('dd-MM-yyyy').format(tempDate);
  }

  Future<void> fetchOrderHistory(filter) async {
    String token = await Sharedprefrences.getToken();
    final response = await http.post(
      Uri.parse("$baseUrl/order-history"),
      headers: {'Authorization': 'Bearer $token'},
      body: {"date_filter": filter},
    );
    if (response.statusCode == 200) {
      isLoading = false;
      final jsonData = json.decode(response.body);
      setState(() {
        orderHistoryData = jsonData['data']['data'] as List;
      });
      print("orderData $orderHistoryData");
    } else if(response.statusCode == 401) {
      print("refresh token called");if (refreshCounter == 0) {
        refreshCounter++;
        bool tokenRefreshed = await getNewToken(context);
        tokenRefreshed ?fetchOrderHistory(filter):null;}
    }else {
      isLoading = false;
      setState(() {});
      print('Request failed with status: ${response.statusCode}.');
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something Went Wrong Please try again !')));
    }
  }

  Widget buildNoData() => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Center(
          child: Image.asset(
            'assets/images/emptyOrder.png',
            width: 251,
            height: 221,
          ),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
          'key_You_don_t_have_any_upcoming_orders'.tr,
          style: const TextStyle(fontSize: 16, color: Colors.white))
    ],
  );

  Future<String?> showFilterDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: cardColor(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text('key_filter_order'.tr,style: cardTextStyle16(),),
          children: [
            SimpleDialogOption(
              onPressed: () {
                filter = 'week';
                fetchOrderHistory(filter);
                Navigator.pop(context);
                setState(() {
                });
              },
              child: Text('key_This_Week'.tr,style: mTextStyle14(),),
            ),
            SimpleDialogOption(
              onPressed: () {
                filter = 'last_week';
                fetchOrderHistory(filter);
                Navigator.pop(context);
                setState(() {
                });
              },
              child: Text('key_last_week'.tr,style: mTextStyle14(),),
            ),
            SimpleDialogOption(
              onPressed: () {
                filter = 'month';
                fetchOrderHistory(filter);
                Navigator.pop(context);
                setState(() {
                });
              },
              child: Text('key_this_month'.tr,style: mTextStyle14(),),
            ),
            SimpleDialogOption(
              onPressed: () {
                filter = 'last_month';
                fetchOrderHistory(filter);
                Navigator.pop(context);
                setState(() {
                });
              },
              child: Text('key_last_month'.tr,style: mTextStyle14(),),
            ),
            SimpleDialogOption(
              onPressed: () {
                filter = 'last_three_month';
                fetchOrderHistory(filter);
                Navigator.pop(context);
                setState(() {
                });
              },
              child: Text('key_last_three_month'.tr,style: mTextStyle14(),),
            ),
            SimpleDialogOption(
              onPressed: () {
                filter = 'all';
                fetchOrderHistory(filter);
                Navigator.pop(context);
                setState(() {
                });
              },
              child: Text('key_all'.tr,style: mTextStyle14(),),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    fetchOrderHistory(filter);
    super.initState();
  }

  @override
  void dispose() {
    // _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),
        title: Text(
          'key_Recived_Orders'.tr,
          style: cardTitleStyle20(),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context,"true");
          },
          icon:const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showFilterDialog(context);
            },
            icon: const Icon(Icons.filter_alt_outlined),
          ),
        ],
      ),
      body: isLoading
          ? Center(
          child: CircularProgressIndicator(
            color: orangeColor(),
          ))
          : orderHistoryData.isNotEmpty ? Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: orderHistoryData.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      height: 180,
                      child: InkWell(
                        onTap: () {

                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  OrderHistoryDetails(id:orderHistoryData[index]['id']))
                          ).then((value) {
                            if(value=="true"){
                              setState(() {
                                fetchOrderHistory(filter);
                              });
                            }
                          });
                        },
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
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
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
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'key_ORDER_AMOUNT'.tr,
                                          style: mTextStyle16(),
                                        ),
                                        Text(
                                          '₹ ${orderHistoryData[index]
                                          ['order_detail']
                                          [0]['item_price']}',
                                          style: cTextStyle16(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding:
                                EdgeInsets.symmetric(horizontal: 8.0),
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
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'key_ORDER_STATUS'.tr,
                                          style: mTextStyle16(),
                                        ),
                                        Text(
                                          orderHistoryData[index]
                                          ['order_status'],
                                          style: cTextStyle16(),
                                        ),
                                      ],
                                    ),
                                    orderHistoryData[index][
                                    'order_preparing_time'] !=
                                        null
                                        ? orderHistoryData[index]['order_status']
                                        .toString() ==
                                        "Preparing"
                                        ? SizedBox(
                                        height: 35,
                                        width:
                                        MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.45,
                                        child: Card(
                                            shadowColor:
                                            Colors.black,
                                            color: orangeColor(),
                                            shape:
                                            RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  5.0),
                                            ),
                                            child: Align(
                                              alignment: Alignment
                                                  .center,
                                              child: TimerWidget(
                                                //minutes: minutesFromApiResponse,
                                                minutes: calculateRemainingMinutes(
                                                    orderHistoryData[
                                                    index]
                                                    [
                                                    'order_preparing_time']),
                                              ),
                                              // Text(
                                              //   '${'key_Order_Ready'.tr} (${calculateRemainingTime(orderData[index]['order_preparing_time'].toString())})',
                                              //   style: mTextStyle14(),
                                              // ),
                                            )))
                                        : const SizedBox()
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
                          color: const Color.fromRGBO(53, 56, 66, 1),
                          child: Center(
                              child: Text(
                                getFormatedDate(
                                    orderHistoryData[index]['created_at']),
                                style: cTextStyle12(),
                                textAlign: TextAlign.center,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            );
          },
        ),
      ) : buildNoData(),
    );
  }
}
