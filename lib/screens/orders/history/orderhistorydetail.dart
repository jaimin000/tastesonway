import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../apiServices/api_service.dart';
import '../../../utils/sharedpreferences.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import '../../../utils/snackbar.dart';
import '../../../utils/theme_data.dart';

class OrderHistoryDetails extends StatefulWidget {
  final int id;

  const OrderHistoryDetails({Key? key, required this.id}) : super(key: key);

  @override
  State<OrderHistoryDetails> createState() => _OrderHistoryDetailsState();
}

class _OrderHistoryDetailsState extends State<OrderHistoryDetails>
    with TickerProviderStateMixin {
  int refreshCounter = 0;

  Map<String, dynamic> orderData = {};
  bool isLoading = true;
  bool isShowAcceptButton = false;
  bool isShowPreparingButton = false;
  bool isShowDeliveredOrderButton = false;
  String verificationId = "";
  double _selectedMinutes = 5;
  bool timeOut = false;
  int _countdownSeconds = 00;
  Timer? _fetchTimer;
  Timer? _timer;
  int secondsLeft = 300;
  bool isTimeoutFinished = false;
  String cancelReason = '';
  late AnimationController _animationController;
  TextEditingController cancelOrderController = TextEditingController();

  final StreamController<String> _orderDetailsStreamController =
      StreamController<String>();

  Stream<String> get orderDetailsStream => _orderDetailsStreamController.stream;

  String getFormatedDate(String date) {
    var tempDate = DateFormat("MMM dd, yyyy hh:mm:ss a").parse(date);

    return DateFormat('dd-MM-yyyy').format(tempDate);
  }

  void startFetchingOrderDetails() {
    // Cancel the previous timer if it's active
    _fetchTimer?.cancel();

    // Start a new timer to fetch data every 5 seconds
    _fetchTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      fetchOrderDetails();
    });
  }

  void stopFetchingOrderDetails() {
    // Cancel the timer when it's no longer needed
    _fetchTimer?.cancel();
  }

  Future<void> fetchOrderDetails({
    bool isFromAcceptButton = false,
    bool isFromCancelButton = false,
    bool isFromPreparingButton = false,
    String? preparationTime,
    bool isFromDeliveryButton = false,
  }) async {
    String token = await Sharedprefrences.getToken();
    final response = await http.post(
      Uri.parse("$baseUrl/order-details"),
      headers: {'Authorization': 'Bearer $token'},
      body: {"order_id": widget.id.toString()},
    );
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      final jsonData = json.decode(response.body);
      orderData = jsonData['data'];
      _orderDetailsStreamController.add(json.encode(orderData));

      if (orderData['order_status'].toString() == 'Pending') {
        isShowAcceptButton = true;
        isShowPreparingButton = false;
        isShowDeliveredOrderButton = false;
        isLoading = false;
        if (isFromAcceptButton) {
          // await updateOrderStatus(orderID, '2',
          //     preparationTime: preparationTime);
          // acceptOrder();
          _selectedMinutes != 0
              ? _countdownSeconds = 60 * _selectedMinutes.toInt()
              : _countdownSeconds = calculateRemainingMinutes(
                  orderData['order_preparing_time'].toString());
        } else if (isFromCancelButton) {
          // deleteconfirmationDialog(
          //   context,
          // );
          isLoading = false;
        }
        setState(() {});
      } else if (orderData['order_status'].toString() == 'Cancelled') {
        isShowAcceptButton = false;
        isShowPreparingButton = false;
        isShowDeliveredOrderButton = false;
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
        if (isFromAcceptButton || isFromCancelButton) {
          // showOrderCancelledDialog();
          setState(() {
            isLoading = false;
          });
        }
      } else if (orderData['order_status'].toString() == 'Accepted') {
        isShowAcceptButton = false;
        isShowPreparingButton = false;
        isShowDeliveredOrderButton = false;
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      } else if (orderData['order_status'].toString() == 'Preparing') {
        isShowAcceptButton = false;
        isShowPreparingButton = true;
        _countdownSeconds = calculateRemainingMinutes(
            orderData['order_preparing_time'].toString());
        setState(() {
          isLoading = false;
        });
        if (isFromPreparingButton) {
          isShowPreparingButton = false;
          // sendOTP(orderID);
          setState(() {
            isLoading = true;
          });
          // await updateOrderStatus(orderID, '8',
          //     otp_verification_id: verificationId);
        }
      } else if (orderData['order_status'].toString() == 'Prepared') {
        isShowAcceptButton = false;
        isShowPreparingButton = false;
        if (orderData['delivery_person_order_status'] == 3) {
          isShowDeliveredOrderButton = false;
        } else {
          isShowDeliveredOrderButton = true;
        }

        verificationId = orderData['otp_verification_id'].toString();
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
        if (isFromDeliveryButton) {
          isShowDeliveredOrderButton = false;
          //updateOrderStatus(5);
        }
      } else {
        isShowAcceptButton = false;
        isShowPreparingButton = false;
        isShowDeliveredOrderButton = false;
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
      // print("orderData $orderData");
    } else if(response.statusCode == 401) {
      print("refresh token called");if (refreshCounter == 0) {
        refreshCounter++;
      bool tokenRefreshed = await getNewToken(context);
      tokenRefreshed ?fetchOrderDetails():null;}
    }else {
      ScaffoldSnackbar.of(context)
          .show('Something Went Wrong Please Try Again!');
      print('Request failed with status: ${response.statusCode}.');
      setState(() {
        isLoading = false;
      });
    }
  }


  String formatDuration(int duration) {
    var minutes = (duration ~/ 60).toString().padLeft(2, '0');
    var seconds = (duration % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  int calculateRemainingMinutes(String futureTime) {
    final currentTime = DateTime.now();
    final apiTime = DateTime.parse(futureTime);

    final remainingTime = apiTime.difference(currentTime);
    final remainingMinutes = remainingTime.inSeconds;

    return remainingMinutes < 0 ? 0 : remainingMinutes;
  }

  @override
  void initState() {
    fetchOrderDetails();
    startFetchingOrderDetails();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    stopFetchingOrderDetails();
    _orderDetailsStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor(),
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () async {
                return Navigator.pop(context, "true");
              }),
          backgroundColor: backgroundColor(),
          title: Text(
            'key_Order_Details'.tr,
            style: cardTitleStyle20(),
          ),
        ),
        body: WillPopScope(
          onWillPop: () async {
            Navigator.pop(context, "true");
            return true;
          },
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                  color: orangeColor(),
                ))
              : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                    child: Card(
                                        shadowColor: Colors.black,
                                        color:
                                            const Color.fromRGBO(64, 68, 81, 1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'key_Your_Order'.tr,
                                                          style: mTextStyle16(),
                                                        ),
                                                        Text(
                                                          orderData[
                                                                  'order_status']
                                                              .toString(),
                                                          style:
                                                              cardTextStyle16(),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  const Divider(
                                                    height: 20,
                                                    color: Colors.white,
                                                    indent: 10,
                                                    endIndent: 10,
                                                  ),
                                                  Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    7.0),
                                                        child: Text(
                                                          orderData['order_detail']
                                                                      [0]
                                                                  ['menu_items']
                                                              [0]['name'],
                                                          style: cTextStyle16(),
                                                        ),
                                                      )),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          '${orderData['order_detail'][0]['quantity']} X ₹ ${orderData['order_detail']
                                                                          [0][
                                                                      'item_price']}',
                                                          style: cTextStyle16(),
                                                        ),
                                                        Text(
                                                          '₹ ${orderData['order_detail']
                                                                          [0][
                                                                      'item_price']}',
                                                          style: cTextStyle16(),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  const Divider(
                                                    height: 20,
                                                    color: Colors.white,
                                                    indent: 10,
                                                    endIndent: 10,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'key_Item_Total'.tr,
                                                          style: cTextStyle16(),
                                                        ),
                                                        Text(
                                                          '₹ ${orderData['order_detail']
                                                                          [0][
                                                                      'item_price']}',
                                                          style: cTextStyle16(),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'key_discount'.tr,
                                                          style: cTextStyle16(),
                                                        ),
                                                        Text(
                                                          orderData['coupon']
                                                                      .toString() ==
                                                                  'null'
                                                              ? '₹ 0'
                                                              : '₹ ${orderData[
                                                                          'coupon_amount']}',
                                                          style: cTextStyle16(),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  const Divider(
                                                    height: 20,
                                                    color: Colors.white,
                                                    indent: 10,
                                                    endIndent: 10,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'key_You_will_get'.tr,
                                                          style: cTextStyle16(),
                                                        ),
                                                        Text(
                                                          orderData['order_earning_summary']
                                                                      .toString() ==
                                                                  "null"
                                                              ? ""
                                                              : "₹ ${orderData['order_earning_summary']
                                                                          [
                                                                          'owner_earning_amount']}",
                                                          style: cTextStyle16(),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  const Divider(
                                                    height: 20,
                                                    color: Colors.white,
                                                    indent: 10,
                                                    endIndent: 10,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: Text(
                                                          "key_Order_Details"
                                                              .tr,
                                                          style: mTextStyle16(),
                                                        ),
                                                      )),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Divider(
                                                    thickness: 1,
                                                    height: 20,
                                                    color: orangeColor(),
                                                    indent: 10,
                                                    endIndent: 10,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'key_Order_Number'.tr,
                                                          style: cTextStyle16(),
                                                        ),
                                                        Text(
                                                          orderData['order_no'],
                                                          style: cTextStyle16(),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'key_Payment_Type'.tr,
                                                          style: cTextStyle16(),
                                                        ),
                                                        Text(
                                                          'Bank',
                                                          style: cTextStyle16(),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'key_Date'.tr,
                                                          style: cTextStyle16(),
                                                        ),
                                                        Text(
                                                          getFormatedDate(
                                                              orderData[
                                                                  'created_at']),
                                                          style: cTextStyle16(),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'key_Phone_Number'.tr,
                                                          style: cTextStyle16(),
                                                        ),
                                                        Text(
                                                          orderData['user']
                                                              ['mobile_number'],
                                                          style: cTextStyle16(),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'key_Deliver_to'.tr,
                                                          style: cTextStyle16(),
                                                        ),
                                                        SizedBox(
                                                          width: 200,
                                                          child: Text(
                                                            '${orderData['user_address']['address'] + ' ' + orderData['user_address']['area'] + ' ' + orderData['user_address']['city']['name'] + ' ' + orderData['user_address']['pin_code']}',
                                                            textAlign:
                                                                TextAlign.right,
                                                            maxLines: 5,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                cTextStyle16(),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                ])))),
                                const SizedBox(height: 25),
                                SizedBox(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    child: InkWell(
                                      onTap: () async {
                                        final phoneNumber =
                                            orderData['user']['mobile_number'];
                                        final Uri launchUri = Uri(
                                          scheme: 'tel',
                                          path: phoneNumber,
                                        );
                                        await launchUrl(launchUri);
                                      },
                                      child: Card(
                                          shadowColor: Colors.black,
                                          color: orangeColor(),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              '${'${'key_Call_to'.tr} ${orderData['user']['name']} (' +
                                                  orderData['user']
                                                      ['mobile_number']})',
                                              style: mTextStyle14(),
                                            ),
                                          )),
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                const SizedBox(height: 15),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ));

  }
}
