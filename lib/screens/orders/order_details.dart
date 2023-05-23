import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../apiServices/api_service.dart';
import '../../utils/sharedpreferences.dart';
import '../../utils/snackbar.dart';
import '../../utils/theme_data.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import '../../utils/timer.dart';

class OrderDetails extends StatefulWidget {
  final int id;

  const OrderDetails({Key? key, required this.id}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails>
    with TickerProviderStateMixin {
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

      // setState(() {
      //   orderData = jsonData['data'];
      // });
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
          startCountdown();
          await updateOrderStatus(2);
        } else if (isFromCancelButton) {
          // deleteconfirmationDialog(
          //   context,
          // );

          isLoading = false;
          showCancelConfirmationDialog(context);
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
        // isEnablePreparingTime = true;
        // getRemainingTimes(
        //     orderData['order_preparing_time'].toString());
        _countdownSeconds = calculateRemainingMinutes(
            orderData['order_preparing_time'].toString());
        setState(() {
          isLoading = false;
        });
        if (isFromPreparingButton) {
          isShowPreparingButton = false;
          // sendOTP(orderID);
          updateOrderStatus(8);
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
      print("refresh token called");
      getNewToken(context);
      fetchOrderDetails();
    }else {
      ScaffoldSnackbar.of(context)
          .show('Something Went Wrong Please Try Again!');
      print('Request failed with status: ${response.statusCode}.');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> updateOrderStatus(int id) async {
    String token = await Sharedprefrences.getToken();
    Map<String, dynamic> bodyData = {};
    String showMessage = '';
    if (id == 6) {
      bodyData = {
        "order_id": widget.id.toString(),
        "order_status": id,
        'order_cancel_message': cancelReason
      };
      showMessage = 'Order Cancelled Successfully';
    } else if (id == 8) {
      bodyData = {
        "order_id": widget.id.toString(),
        "order_status": id,
        'otp_verification_id': verificationId
      };
      showMessage = 'Order Prepared Successfully';
    } else if (id == 2) {
      bodyData = {
        "order_id": widget.id.toString(),
        "order_status": id,
        "order_preparing_time": _selectedMinutes.toInt().toString(),
      };
      showMessage = 'Order Accepted Successfully';
    } else {
      bodyData = {
        'order_id': widget.id.toString(),
        'order_status': id,
      };
      showMessage = 'Order Status Updated Successfully';
    }

    final response = await http.post(
      Uri.parse("$baseUrl/update-order-status"),
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json",
        'accept': 'application/json',
      },
      body: jsonEncode(bodyData),
    );
    print(response.body);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      ScaffoldSnackbar.of(context).show(showMessage);
      fetchOrderDetails(isFromCancelButton: true);
      setState(() {
        isLoading = false;
      });
    }
    else if(response.statusCode == 401) {
      print("refresh token called");
      getNewToken(context);
      updateOrderStatus(id);
    }else {
      print('Request failed with status: ${response.statusCode}.');
      ScaffoldSnackbar.of(context)
          .show('Something Went Wrong Please Try Again!');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> verifyOtp(String otp) async {
    String token = await Sharedprefrences.getToken();
    final response = await http.post(
      Uri.parse("$baseUrl/delivery-person-status-update"),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        "order_id": widget.id.toString(),
        "delivery_person_order_status": "3",
        "owner_otp": otp
      },
    );
    // print(widget.id);
    // print(response.body);
    if (response.statusCode == 200) {
      // final jsonData = json.decode(response.body);
      // print(response.body);
      await fetchOrderDetails(isFromDeliveryButton: true);
      ScaffoldSnackbar.of(context).show('Order has been Picked Successfully');
      setState(() {
        isLoading = false;
      });
    } else if(response.statusCode == 401) {
      print("refresh token called");
      getNewToken(context);
      verifyOtp(otp);
    }else {
      print('Request failed with status: ${response.statusCode}.');
      ScaffoldSnackbar.of(context)
          .show('Something Went Wrong Please Try Again!');
      setState(() {
        isLoading = false;
      });
    }
  }

  showOrderCancelledDialog() {
    var errorDialog = Dialog(
      //this right here
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: backgroundColor(),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'key_order_has_been_cancelled_by_user'.tr,
                style: mTextStyle16(),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: orangeColor(), // Background color
                    ),
                    child: Center(
                        child: Text(
                      'key_OKAY'.tr,
                      style: mTextStyle14(),
                    )),
                  )),
                ])),
          ],
        ),
      ),
    );
    showDialog(
        context: context,
        useRootNavigator: true,
        barrierDismissible: false,
        builder: (BuildContext context) => errorDialog);
  }

  // void showCancelConfirmationDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         backgroundColor: cardColor(),
  //         title: Text(
  //           'key_Cancel_Order'.tr,
  //           style: TextStyle(color: orangeColor()),
  //         ),
  //         content: Text('key_are_you_sure_cancel_order'.tr),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //               setState(() {}); // Close the dialog
  //             },
  //             child: Text(
  //               'key_NO'.tr,
  //               style: TextStyle(color: orangeColor()),
  //             ),
  //           ),
  //           TextButton(
  //             onPressed: () async {
  //               Navigator.of(context).pop();
  //               CancellationReasonDialog(context);
  //               // await updateOrderStatus(6);
  //               // ScaffoldSnackbar.of(context).show('Order Cancelled');
  //               // setState(() {});
  //             },
  //             child: Text(
  //               'key_YES'.tr,
  //               style: TextStyle(color: orangeColor()),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // CancellationReasonDialog(BuildContext context) async {
  //   var errorDialog = Dialog(
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
  //     //this right here
  //     child: SizedBox(
  //       height: 272.0,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           Padding(
  //             padding: EdgeInsets.all(20.0),
  //             child: Text(
  //               'key_enter_cancel_order_reason'.tr,
  //               style: cardTextStyle12(),
  //             ),
  //           ),
  //           Padding(
  //             padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
  //             child: TextField(
  //               cursorColor: orangeColor(),
  //               maxLines: 3,
  //               decoration:   InputDecoration(
  //                 enabledBorder:  const OutlineInputBorder(
  //                     borderSide:  BorderSide(color: Colors.grey)
  //                 ),
  //                 focusedBorder:  OutlineInputBorder(
  //                     borderSide:  BorderSide(color: orangeColor())
  //                 ),
  //               ),
  //               controller: cancelOrderController,
  //             ),
  //           ),
  //           cancelOrderController.text == ''
  //               ? Padding(
  //               padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
  //               child: Text(
  //                 'key_Please_enter_cancel_order_reason'.tr,
  //                 style: mTextStyle14(),
  //               ))
  //               : Container(),
  //           Padding(
  //               padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
  //               child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
  //                 ElevatedButton(
  //                   style: ElevatedButton.styleFrom(
  //                     primary: orangeColor(), // Background color
  //                   ),
  //                   onPressed: () {
  //                     cancelReason = cancelOrderController.text;
  //                     if (cancelOrderController.text != '') {
  //                       Navigator.pop(context);
  //                       updateOrderStatus(6);
  //                        //ScaffoldSnackbar.of(context).show('Order Cancelled');
  //                       //setState(() {});
  //                       // updateOrderStatus(
  //                       //     int.parse(orderList[0]['order_id'].toString()), '6',
  //                       //     cancelReason: cancelOrderController.text);
  //                     }
  //                   },
  //                   child: Center(
  //                       child: Text(
  //                         'key_Submit'.tr,
  //                         style: mTextStyle14()
  //                       )),
  //                 ),
  //               ])),
  //         ],
  //       ),
  //     ),
  //   );
  //    showDialog(
  //       context: context,
  //       useRootNavigator: true,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) => errorDialog);
  // }

  void showCancelConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: cardColor(),
          title: Text(
            'key_Cancel_Order'.tr,
            style: cardTextStyle16(),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
               Text('key_are_you_sure_cancel_order'.tr,style: mTextStyle16(),),
              const SizedBox(height: 10,),
              TextField(
                cursorColor: orangeColor(),
                maxLines: 3,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: orangeColor())),
                ),
                controller: cancelOrderController,
              ),
              const SizedBox(height: 5,),
              cancelOrderController.text == ''
                  ? Text(
                    'key_Please_enter_cancel_order_reason'.tr,
                    textAlign: TextAlign.start,
                    style:const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  )
                  : const SizedBox(height: 5,),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'key_Cancel'.tr,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () async {
                cancelReason = cancelOrderController.text;
                if (cancelOrderController.text != '') {
                  Navigator.pop(context);
                  updateOrderStatus(6);
                }
                // Navigator.of(context).pop();
                // if (cancelReason.isNotEmpty) {
                //   // Perform cancellation logic here
                //   // await updateOrderStatus(6);
                //   // ScaffoldSnackbar.of(context).show('Order Cancelled');
                //   // setState(() {});
                // }
              },
              child: Text(
                'key_Submit'.tr,
                style: TextStyle(color: orangeColor()),
              ),
            ),
          ],
        );
      },
    );
  }

  viewVerifyOTPSheet(BuildContext context) {
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8))),
        builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext context, state) => Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  height: 275,
                  decoration: BoxDecoration(
                      color: cardColor(),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'key_Verify_OTP'.tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.0,
                                  color: orangeColor()),
                            ),
                            InkWell(
                                onTap: () => Navigator.of(context).pop(),
                                child: const Icon(Icons.clear))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 0.5,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey.withOpacity(0.7),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'key_take_otp_from_delivery_boy'.tr,
                              style: cTextStyle16(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 30),
                        child: PinCodeTextField(
                          appContext: context,
                          pastedTextStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          length: 6,
                          blinkWhenObscuring: true,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            selectedColor: orangeColor(),
                            selectedFillColor: Colors.white,
                            inactiveColor: Colors.white,
                            inactiveFillColor: Colors.white,
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                          ),
                          cursorColor: orangeColor(),
                          //animationDuration: Duration(milliseconds: 300),
                          //backgroundColor: Colors.blue.shade50,
                          enableActiveFill: true,
                          //errorAnimationController: errorController,
                          // controller: textEditingController,
                          keyboardType: TextInputType.number,
                          onCompleted: (v) {
                            print('Completed');
                            //print(verificationId);
                            print(v);
                            Navigator.pop(context);
                            verifyOtp(v);
                          },
                          onChanged: (value) {
                            print(value);
                            // setState(() {
                            //   //currentText = value;
                            // });
                          },
                          beforeTextPaste: (text) {
                            print('Allowing to paste $text');
                            return true;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ))));
  }

  // getRemainingTimes(String time) {
  //   if (time != 'null') {
  //     var parseDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(time);
  //     var now = DateTime.now();
  //     print(now.difference(parseDate));
  //     var seconds = now.difference(parseDate).inSeconds;
  //     print(seconds);
  //     if (seconds.toString()[0] == '-') {
  //       secondsLeft =
  //           int.parse(seconds.toString().replaceAll(RegExp('-'), '')); // abc
  //       print('withDash$secondsLeft');
  //       _animationController.forward();
  //       isTimeoutFinished = false;
  //     } else {
  //       final withoutEquals =
  //           seconds.toString().replaceAll(RegExp('-'), ''); // abc
  //       print('withoutDash$withoutEquals');
  //       _animationController.repeat(reverse: true);
  //       isTimeoutFinished = true;
  //     }
  //     if (mounted) {
  //       setState(() {});
  //     }
  //   }
  // }

  void startCountdown() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_countdownSeconds < 1) {
          timer.cancel();
          timeOut = true;
        } else {
          _countdownSeconds -= 1;
        }
      });
    });
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
                                // isShowPreparingButton
                                //     ? FadeTransition(
                                //         opacity: _animationController,
                                //         child: Container(
                                //             height: 90,
                                //             child: Padding(
                                //                 padding: EdgeInsets.only(
                                //                     left: 20,
                                //                     right: 20,
                                //                     bottom: 20,
                                //                     top: 20),
                                //                 child: Container(
                                //                     height: 40,
                                //                     // width: MediaQuery.of(context).size.width / 2,
                                //                     decoration: BoxDecoration(
                                //                         color: isTimeoutFinished
                                //                             ? Colors.red
                                //                             : Colors.green,
                                //                         borderRadius:
                                //                             BorderRadius.all(
                                //                                 Radius.circular(
                                //                                     10)),
                                //                         border: Border.all(
                                //                             color: isTimeoutFinished
                                //                                 ? Colors.red
                                //                                 : Colors.green)),
                                //                     child: ElevatedButton(
                                //                         onPressed: () async {
                                //                           if (isTimeoutFinished) {
                                //                             var orderList =
                                //                                 orderData[
                                //                                         'order_detail']
                                //                                     as List;
                                //                             setState(() {
                                //                               isShowPreparingButton =
                                //                                   false;
                                //                             });
                                //                             await fetchOrderDetails(
                                //                                 isFromPreparingButton:
                                //                                     true);
                                //                           }
                                //                         },
                                //                         child: Row(
                                //                           mainAxisAlignment:
                                //                               MainAxisAlignment
                                //                                   .center,
                                //                           children: [
                                //                             Text(
                                //                               'key_Order_Ready'.tr,
                                //                               style: const TextStyle(
                                //                                   color:
                                //                                       Colors.white,
                                //                                   fontSize: 20,
                                //                                   fontFamily:
                                //                                       'Roboto',
                                //                                   fontWeight:
                                //                                       FontWeight
                                //                                           .w700),
                                //                             ),
                                //                           ],
                                //                         ))))))
                                isShowDeliveredOrderButton
                                    ? SizedBox(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: InkWell(
                                            onTap: () async {
                                              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OrderDetails(id: widget.id)));
                                              // await preparedOrder();
                                              viewVerifyOTPSheet(context);
                                              setState(() {});
                                            },
                                            child: Card(
                                                shadowColor: Colors.black,
                                                color: Colors.green,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    'key_order_has_picked'.tr,
                                                    style: mTextStyle16(),
                                                  ),
                                                ))))
                                    : const SizedBox(),
                                isShowPreparingButton
                                    ? SizedBox(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: InkWell(
                                            onTap: () async {
                                              if (_countdownSeconds == 0) {
                                                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OrderDetails(id: widget.id)));
                                                // await preparedOrder();
                                                fetchOrderDetails(
                                                    isFromPreparingButton:
                                                        true);
                                                setState(() {});
                                              }
                                            },
                                            child: Card(
                                                shadowColor: Colors.black,
                                                color: orangeColor(),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: isShowPreparingButton
                                                      ? Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'key_Order_Ready'
                                                                  .tr,
                                                              style:
                                                                  mTextStyle16(),
                                                            ),
                                                            const SizedBox(
                                                              width: 15,
                                                            ),
                                                            TimerWidget(
                                                              //minutes: minutesFromApiResponse,
                                                              minutes:
                                                                  calculateRemainingMinutes(
                                                                      orderData[
                                                                          'order_preparing_time']),
                                                            ),
                                                          ],
                                                        )
                                                      // ? BlinkText(
                                                      //     'key_Order_Ready'.tr +
                                                      //         "   " +
                                                      //         formatDuration(
                                                      //             _countdownSeconds),
                                                      //     style: mTextStyle16(),
                                                      //     endColor: orangeColor(),
                                                      //   )
                                                      : Text(
                                                          "${'key_Order_Ready'.tr}   ${formatDuration(
                                                                  _countdownSeconds)}",
                                                          style: mTextStyle16(),
                                                        ),
                                                ))))
                                    : const SizedBox(),
                                const SizedBox(height: 15),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      isShowAcceptButton
                          ? Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: cardColor(),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: Column(children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          'key_Set_food_prepration_time'.tr,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15.0,
                                              color: orangeColor()),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${_selectedMinutes.toInt()} minutes',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 18.0),
                                    ),
                                    Slider(
                                      activeColor: orangeColor(),
                                      value: _selectedMinutes,
                                      min: 5.0,
                                      max: 60.0,
                                      divisions: 59,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedMinutes = value;
                                        });
                                      },
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                            height: 45,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.42,
                                            child: InkWell(
                                              onTap: () async {
                                                fetchOrderDetails(
                                                    isFromCancelButton: true);
                                              },
                                              child: Card(
                                                  shadowColor: Colors.black,
                                                  color: Colors.redAccent,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      'key_CANCEL'.tr,
                                                      style: mTextStyle14(),
                                                    ),
                                                  )),
                                            )),
                                        SizedBox(
                                            height: 45,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.42,
                                            child: InkWell(
                                              onTap: () async {
                                                fetchOrderDetails(
                                                    isFromAcceptButton: true);
                                                setState(() {});
                                                //setState(() {});
                                                // print(
                                                //     "selected minutes ${_selectedMinutes.toInt()}");
                                              },
                                              child: Card(
                                                  shadowColor: Colors.black,
                                                  color: Colors.green,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      'key_ACCEPT'.tr,
                                                      style: mTextStyle14(),
                                                    ),
                                                  )),
                                            )),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ])),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
        ));

    // body:

    // StreamBuilder<String>(
    //   stream: orderDetailsStream,
    //   builder: (BuildContext context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Center(
    //           child: CircularProgressIndicator(
    //         color: orangeColor(),
    //       )); // Display a loading indicator while waiting for data
    //     } else if (snapshot.hasError) {
    //       return Text('Error: ${snapshot.error}'); // Handle error state
    //     } else {
    //       if (snapshot.hasData) {
    //         final orderData = json.decode(snapshot.data!);
    //         return Container(
    //           padding: const EdgeInsets.symmetric(horizontal: 10),
    //           child: Column(
    //             children: [
    //               Expanded(
    //                 child: ListView(
    //                   children: [
    //                     Column(
    //                       children: [
    //                         SizedBox(
    //                             child: Card(
    //                                 shadowColor: Colors.black,
    //                                 color:
    //                                     const Color.fromRGBO(64, 68, 81, 1),
    //                                 shape: RoundedRectangleBorder(
    //                                   borderRadius:
    //                                       BorderRadius.circular(15.0),
    //                                 ),
    //                                 child: Padding(
    //                                     padding: const EdgeInsets.all(10.0),
    //                                     child: Column(
    //                                         mainAxisAlignment:
    //                                             MainAxisAlignment.start,
    //                                         children: [
    //                                           const SizedBox(
    //                                             height: 5,
    //                                           ),
    //                                           Padding(
    //                                             padding: const EdgeInsets
    //                                                     .symmetric(
    //                                                 horizontal: 8.0),
    //                                             child: Row(
    //                                               mainAxisAlignment:
    //                                                   MainAxisAlignment
    //                                                       .spaceBetween,
    //                                               children: [
    //                                                 Text(
    //                                                   'Your Order',
    //                                                   style: mTextStyle16(),
    //                                                 ),
    //                                                 Text(
    //                                                   orderData[
    //                                                           'order_status']
    //                                                       .toString(),
    //                                                   style:
    //                                                       cardTextStyle16(),
    //                                                 ),
    //                                               ],
    //                                             ),
    //                                           ),
    //                                           const SizedBox(
    //                                             height: 5,
    //                                           ),
    //                                           const Divider(
    //                                             height: 20,
    //                                             color: Colors.white,
    //                                             indent: 10,
    //                                             endIndent: 10,
    //                                           ),
    //                                           Align(
    //                                               alignment:
    //                                                   Alignment.centerLeft,
    //                                               child: Padding(
    //                                                 padding:
    //                                                     const EdgeInsets
    //                                                             .symmetric(
    //                                                         horizontal:
    //                                                             7.0),
    //                                                 child: Text(
    //                                                   orderData['order_detail']
    //                                                               [0]
    //                                                           ['menu_items']
    //                                                       [0]['name'],
    //                                                   style: cTextStyle16(),
    //                                                 ),
    //                                               )),
    //                                           const SizedBox(
    //                                             height: 5,
    //                                           ),
    //                                           Padding(
    //                                             padding: const EdgeInsets
    //                                                     .symmetric(
    //                                                 horizontal: 8.0),
    //                                             child: Row(
    //                                               mainAxisAlignment:
    //                                                   MainAxisAlignment
    //                                                       .spaceBetween,
    //                                               crossAxisAlignment:
    //                                                   CrossAxisAlignment
    //                                                       .center,
    //                                               children: [
    //                                                 Text(
    //                                                   '${orderData['order_detail'][0]['quantity']} X ₹ ' +
    //                                                       orderData['order_detail']
    //                                                                   [0][
    //                                                               'item_price']
    //                                                           .toString(),
    //                                                   style: cTextStyle16(),
    //                                                 ),
    //                                                 Text(
    //                                                   '₹ ' +
    //                                                       orderData['order_detail']
    //                                                                   [0][
    //                                                               'item_price']
    //                                                           .toString(),
    //                                                   style: cTextStyle16(),
    //                                                 ),
    //                                               ],
    //                                             ),
    //                                           ),
    //                                           const SizedBox(
    //                                             height: 5,
    //                                           ),
    //                                           const Divider(
    //                                             height: 20,
    //                                             color: Colors.white,
    //                                             indent: 10,
    //                                             endIndent: 10,
    //                                           ),
    //                                           Padding(
    //                                             padding: const EdgeInsets
    //                                                     .symmetric(
    //                                                 horizontal: 8.0),
    //                                             child: Row(
    //                                               mainAxisAlignment:
    //                                                   MainAxisAlignment
    //                                                       .spaceBetween,
    //                                               crossAxisAlignment:
    //                                                   CrossAxisAlignment
    //                                                       .center,
    //                                               children: [
    //                                                 Text(
    //                                                   'Item Total',
    //                                                   style: cTextStyle16(),
    //                                                 ),
    //                                                 Text(
    //                                                   '₹ ' +
    //                                                       orderData['order_detail']
    //                                                                   [0][
    //                                                               'item_price']
    //                                                           .toString(),
    //                                                   style: cTextStyle16(),
    //                                                 ),
    //                                               ],
    //                                             ),
    //                                           ),
    //                                           const SizedBox(
    //                                             height: 5,
    //                                           ),
    //                                           Padding(
    //                                             padding: const EdgeInsets
    //                                                     .symmetric(
    //                                                 horizontal: 8.0),
    //                                             child: Row(
    //                                               mainAxisAlignment:
    //                                                   MainAxisAlignment
    //                                                       .spaceBetween,
    //                                               crossAxisAlignment:
    //                                                   CrossAxisAlignment
    //                                                       .center,
    //                                               children: [
    //                                                 Text(
    //                                                   'Discount',
    //                                                   style: cTextStyle16(),
    //                                                 ),
    //                                                 Text(
    //                                                   orderData['coupon']
    //                                                               .toString() ==
    //                                                           'null'
    //                                                       ? '₹ 0'
    //                                                       : '₹ ' +
    //                                                           orderData[
    //                                                                   'coupon_amount']
    //                                                               .toString(),
    //                                                   style: cTextStyle16(),
    //                                                 ),
    //                                               ],
    //                                             ),
    //                                           ),
    //                                           const SizedBox(
    //                                             height: 5,
    //                                           ),
    //                                           const SizedBox(
    //                                             height: 5,
    //                                           ),
    //                                           const Divider(
    //                                             height: 20,
    //                                             color: Colors.white,
    //                                             indent: 10,
    //                                             endIndent: 10,
    //                                           ),
    //                                           Padding(
    //                                             padding: const EdgeInsets
    //                                                     .symmetric(
    //                                                 horizontal: 8.0),
    //                                             child: Row(
    //                                               mainAxisAlignment:
    //                                                   MainAxisAlignment
    //                                                       .spaceBetween,
    //                                               crossAxisAlignment:
    //                                                   CrossAxisAlignment
    //                                                       .center,
    //                                               children: [
    //                                                 Text(
    //                                                   'You will get',
    //                                                   style: cTextStyle16(),
    //                                                 ),
    //                                                 Text(
    //                                                   orderData['order_earning_summary']
    //                                                               .toString() ==
    //                                                           "null"
    //                                                       ? ""
    //                                                       : "₹ " +
    //                                                           orderData['order_earning_summary']
    //                                                                   [
    //                                                                   'owner_earning_amount']
    //                                                               .toString(),
    //                                                   style: cTextStyle16(),
    //                                                 ),
    //                                               ],
    //                                             ),
    //                                           ),
    //                                           const SizedBox(
    //                                             height: 5,
    //                                           ),
    //                                           const Divider(
    //                                             height: 20,
    //                                             color: Colors.white,
    //                                             indent: 10,
    //                                             endIndent: 10,
    //                                           ),
    //                                           const SizedBox(
    //                                             height: 5,
    //                                           ),
    //                                           Align(
    //                                               alignment:
    //                                                   Alignment.centerLeft,
    //                                               child: Padding(
    //                                                 padding:
    //                                                     const EdgeInsets
    //                                                             .symmetric(
    //                                                         horizontal:
    //                                                             8.0),
    //                                                 child: Text(
    //                                                   "Order Details",
    //                                                   style: mTextStyle16(),
    //                                                 ),
    //                                               )),
    //                                           const SizedBox(
    //                                             height: 5,
    //                                           ),
    //                                           Divider(
    //                                             thickness: 1,
    //                                             height: 20,
    //                                             color: orangeColor(),
    //                                             indent: 10,
    //                                             endIndent: 10,
    //                                           ),
    //                                           Padding(
    //                                             padding: const EdgeInsets
    //                                                     .symmetric(
    //                                                 horizontal: 8.0),
    //                                             child: Row(
    //                                               mainAxisAlignment:
    //                                                   MainAxisAlignment
    //                                                       .spaceBetween,
    //                                               crossAxisAlignment:
    //                                                   CrossAxisAlignment
    //                                                       .center,
    //                                               children: [
    //                                                 Text(
    //                                                   'Order Number',
    //                                                   style: cTextStyle16(),
    //                                                 ),
    //                                                 Text(
    //                                                   orderData['order_no'],
    //                                                   style: cTextStyle16(),
    //                                                 ),
    //                                               ],
    //                                             ),
    //                                           ),
    //                                           const SizedBox(
    //                                             height: 5,
    //                                           ),
    //                                           Padding(
    //                                             padding: const EdgeInsets
    //                                                     .symmetric(
    //                                                 horizontal: 8.0),
    //                                             child: Row(
    //                                               mainAxisAlignment:
    //                                                   MainAxisAlignment
    //                                                       .spaceBetween,
    //                                               crossAxisAlignment:
    //                                                   CrossAxisAlignment
    //                                                       .center,
    //                                               children: [
    //                                                 Text(
    //                                                   'Payment Type',
    //                                                   style: cTextStyle16(),
    //                                                 ),
    //                                                 Text(
    //                                                   'Bank',
    //                                                   style: cTextStyle16(),
    //                                                 ),
    //                                               ],
    //                                             ),
    //                                           ),
    //                                           const SizedBox(
    //                                             height: 5,
    //                                           ),
    //                                           Padding(
    //                                             padding: const EdgeInsets
    //                                                     .symmetric(
    //                                                 horizontal: 8.0),
    //                                             child: Row(
    //                                               mainAxisAlignment:
    //                                                   MainAxisAlignment
    //                                                       .spaceBetween,
    //                                               crossAxisAlignment:
    //                                                   CrossAxisAlignment
    //                                                       .center,
    //                                               children: [
    //                                                 Text(
    //                                                   'Date',
    //                                                   style: cTextStyle16(),
    //                                                 ),
    //                                                 Text(
    //                                                   getFormatedDate(
    //                                                       orderData[
    //                                                           'created_at']),
    //                                                   style: cTextStyle16(),
    //                                                 ),
    //                                               ],
    //                                             ),
    //                                           ),
    //                                           const SizedBox(
    //                                             height: 5,
    //                                           ),
    //                                           Padding(
    //                                             padding: const EdgeInsets
    //                                                     .symmetric(
    //                                                 horizontal: 8.0),
    //                                             child: Row(
    //                                               mainAxisAlignment:
    //                                                   MainAxisAlignment
    //                                                       .spaceBetween,
    //                                               crossAxisAlignment:
    //                                                   CrossAxisAlignment
    //                                                       .center,
    //                                               children: [
    //                                                 Text(
    //                                                   'Phone No.',
    //                                                   style: cTextStyle16(),
    //                                                 ),
    //                                                 Text(
    //                                                   orderData['user']
    //                                                       ['mobile_number'],
    //                                                   style: cTextStyle16(),
    //                                                 ),
    //                                               ],
    //                                             ),
    //                                           ),
    //                                           const SizedBox(
    //                                             height: 5,
    //                                           ),
    //                                           Padding(
    //                                             padding: const EdgeInsets
    //                                                     .symmetric(
    //                                                 horizontal: 8.0),
    //                                             child: Row(
    //                                               mainAxisAlignment:
    //                                                   MainAxisAlignment
    //                                                       .spaceBetween,
    //                                               crossAxisAlignment:
    //                                                   CrossAxisAlignment
    //                                                       .center,
    //                                               children: [
    //                                                 Text(
    //                                                   'Deliver To',
    //                                                   style: cTextStyle16(),
    //                                                 ),
    //                                                 SizedBox(
    //                                                   width: 200,
    //                                                   child: Text(
    //                                                     '${orderData['user_address']['address'] + ' ' + orderData['user_address']['area'] + ' ' + orderData['user_address']['city']['name'] + ' ' + orderData['user_address']['pin_code']}',
    //                                                     textAlign:
    //                                                         TextAlign.right,
    //                                                     maxLines: 5,
    //                                                     overflow:
    //                                                         TextOverflow
    //                                                             .ellipsis,
    //                                                     style:
    //                                                         cTextStyle16(),
    //                                                   ),
    //                                                 ),
    //                                               ],
    //                                             ),
    //                                           ),
    //                                           const SizedBox(
    //                                             height: 5,
    //                                           ),
    //                                         ])))),
    //                         const SizedBox(height: 25),
    //                         SizedBox(
    //                             height: 50,
    //                             width: MediaQuery.of(context).size.width,
    //                             child: InkWell(
    //                               onTap: () async {
    //                                 final phoneNumber =
    //                                     orderData['user']['mobile_number'];
    //                                 final Uri launchUri = Uri(
    //                                   scheme: 'tel',
    //                                   path: phoneNumber,
    //                                 );
    //                                 await launchUrl(launchUri);
    //                               },
    //                               child: Card(
    //                                   shadowColor: Colors.black,
    //                                   color: orangeColor(),
    //                                   shape: RoundedRectangleBorder(
    //                                     borderRadius:
    //                                         BorderRadius.circular(10.0),
    //                                   ),
    //                                   child: Align(
    //                                     alignment: Alignment.center,
    //                                     child: Text(
    //                                       'Call to ${orderData['user']['name']} (' +
    //                                           orderData['user']
    //                                               ['mobile_number'] +
    //                                           ')',
    //                                       style: mTextStyle14(),
    //                                     ),
    //                                   )),
    //                             )),
    //                         const SizedBox(
    //                           height: 10,
    //                         ),
    //                         // isShowPreparingButton
    //                         //     ? FadeTransition(
    //                         //         opacity: _animationController,
    //                         //         child: Container(
    //                         //             height: 90,
    //                         //             child: Padding(
    //                         //                 padding: EdgeInsets.only(
    //                         //                     left: 20,
    //                         //                     right: 20,
    //                         //                     bottom: 20,
    //                         //                     top: 20),
    //                         //                 child: Container(
    //                         //                     height: 40,
    //                         //                     // width: MediaQuery.of(context).size.width / 2,
    //                         //                     decoration: BoxDecoration(
    //                         //                         color: isTimeoutFinished
    //                         //                             ? Colors.red
    //                         //                             : Colors.green,
    //                         //                         borderRadius:
    //                         //                             BorderRadius.all(
    //                         //                                 Radius.circular(
    //                         //                                     10)),
    //                         //                         border: Border.all(
    //                         //                             color: isTimeoutFinished
    //                         //                                 ? Colors.red
    //                         //                                 : Colors.green)),
    //                         //                     child: ElevatedButton(
    //                         //                         onPressed: () async {
    //                         //                           if (isTimeoutFinished) {
    //                         //                             var orderList =
    //                         //                                 orderData[
    //                         //                                         'order_detail']
    //                         //                                     as List;
    //                         //                             setState(() {
    //                         //                               isShowPreparingButton =
    //                         //                                   false;
    //                         //                             });
    //                         //                             await fetchOrderDetails(
    //                         //                                 isFromPreparingButton:
    //                         //                                     true);
    //                         //                           }
    //                         //                         },
    //                         //                         child: Row(
    //                         //                           mainAxisAlignment:
    //                         //                               MainAxisAlignment
    //                         //                                   .center,
    //                         //                           children: [
    //                         //                             Text(
    //                         //                               'key_Order_Ready'.tr,
    //                         //                               style: const TextStyle(
    //                         //                                   color:
    //                         //                                       Colors.white,
    //                         //                                   fontSize: 20,
    //                         //                                   fontFamily:
    //                         //                                       'Roboto',
    //                         //                                   fontWeight:
    //                         //                                       FontWeight
    //                         //                                           .w700),
    //                         //                             ),
    //                         //                           ],
    //                         //                         ))))))
    //                         isShowDeliveredOrderButton
    //                             ? SizedBox(
    //                                 height: 50,
    //                                 width:
    //                                     MediaQuery.of(context).size.width,
    //                                 child: InkWell(
    //                                     onTap: () async {
    //                                       // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OrderDetails(id: widget.id)));
    //                                       // await preparedOrder();
    //                                       viewVerifyOTPSheet(context);
    //                                       setState(() {});
    //                                     },
    //                                     child: Card(
    //                                         shadowColor: Colors.black,
    //                                         color: Colors.green,
    //                                         shape: RoundedRectangleBorder(
    //                                           borderRadius:
    //                                               BorderRadius.circular(
    //                                                   10.0),
    //                                         ),
    //                                         child: Align(
    //                                           alignment: Alignment.center,
    //                                           child: Text(
    //                                             'key_order_has_picked'.tr,
    //                                             style: mTextStyle16(),
    //                                           ),
    //                                         ))))
    //                             : SizedBox(),
    //                         isShowPreparingButton
    //                             ? SizedBox(
    //                                 height: 50,
    //                                 width:
    //                                     MediaQuery.of(context).size.width,
    //                                 child: InkWell(
    //                                     onTap: () async {
    //                                       // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OrderDetails(id: widget.id)));
    //                                       // await preparedOrder();
    //                                       fetchOrderDetails(
    //                                           isFromPreparingButton: true);
    //                                       setState(() {});
    //                                     },
    //                                     child: Card(
    //                                         shadowColor: Colors.black,
    //                                         color: orangeColor(),
    //                                         shape: RoundedRectangleBorder(
    //                                           borderRadius:
    //                                               BorderRadius.circular(
    //                                                   10.0),
    //                                         ),
    //                                         child: Align(
    //                                           alignment: Alignment.center,
    //                                           child: isShowPreparingButton
    //                                               ? Row(
    //                                                   mainAxisAlignment:
    //                                                       MainAxisAlignment
    //                                                           .center,
    //                                                   crossAxisAlignment:
    //                                                       CrossAxisAlignment
    //                                                           .center,
    //                                                   children: [
    //                                                     Text(
    //                                                       'key_Order_Ready'
    //                                                           .tr,
    //                                                       style:
    //                                                           mTextStyle16(),
    //                                                     ),
    //                                                     SizedBox(
    //                                                       width: 15,
    //                                                     ),
    //                                                     TimerWidget(
    //                                                       //minutes: minutesFromApiResponse,
    //                                                       minutes:
    //                                                           calculateRemainingMinutes(
    //                                                               orderData[
    //                                                                   'order_preparing_time']),
    //                                                     ),
    //                                                   ],
    //                                                 )
    //                                               // ? BlinkText(
    //                                               //     'key_Order_Ready'.tr +
    //                                               //         "   " +
    //                                               //         formatDuration(
    //                                               //             _countdownSeconds),
    //                                               //     style: mTextStyle16(),
    //                                               //     endColor: orangeColor(),
    //                                               //   )
    //                                               : Text(
    //                                                   'key_Order_Ready'.tr +
    //                                                       "   " +
    //                                                       formatDuration(
    //                                                           _countdownSeconds),
    //                                                   style: mTextStyle16(),
    //                                                 ),
    //                                         ))))
    //                             : SizedBox(),
    //                         const SizedBox(height: 15),
    //                       ],
    //                     ),
    //                     const SizedBox(
    //                       height: 10,
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               isShowAcceptButton
    //                   ? Align(
    //                       alignment: Alignment.bottomCenter,
    //                       child: Container(
    //                           width: double.infinity,
    //                           padding: EdgeInsets.all(10.0),
    //                           decoration: BoxDecoration(
    //                             color: cardColor(),
    //                             borderRadius: const BorderRadius.only(
    //                               topLeft: Radius.circular(20),
    //                               topRight: Radius.circular(20),
    //                             ),
    //                           ),
    //                           child: Column(children: [
    //                             Align(
    //                               alignment: Alignment.centerLeft,
    //                               child: Padding(
    //                                 padding: const EdgeInsets.symmetric(
    //                                     horizontal: 8.0),
    //                                 child: Text(
    //                                   'key_Set_food_prepration_time'.tr,
    //                                   style: TextStyle(
    //                                       fontWeight: FontWeight.w700,
    //                                       fontSize: 15.0,
    //                                       color: orangeColor()),
    //                                 ),
    //                               ),
    //                             ),
    //                             const SizedBox(
    //                               height: 5,
    //                             ),
    //                             Text(
    //                               '${_selectedMinutes.toInt()} minutes',
    //                               textAlign: TextAlign.center,
    //                               style: TextStyle(fontSize: 18.0),
    //                             ),
    //                             Slider(
    //                               activeColor: orangeColor(),
    //                               value: _selectedMinutes,
    //                               min: 1.0,
    //                               max: 60.0,
    //                               divisions: 59,
    //                               onChanged: (value) {
    //                                 setState(() {
    //                                   _selectedMinutes = value;
    //                                 });
    //                               },
    //                             ),
    //                             Row(
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.spaceAround,
    //                               children: [
    //                                 SizedBox(
    //                                     height: 45,
    //                                     width: MediaQuery.of(context)
    //                                             .size
    //                                             .width *
    //                                         0.42,
    //                                     child: InkWell(
    //                                       onTap: () async {
    //                                         fetchOrderDetails(
    //                                             isFromCancelButton: true);
    //                                       },
    //                                       child: Card(
    //                                           shadowColor: Colors.black,
    //                                           color: Colors.redAccent,
    //                                           shape: RoundedRectangleBorder(
    //                                             borderRadius:
    //                                                 BorderRadius.circular(
    //                                                     10.0),
    //                                           ),
    //                                           child: Align(
    //                                             alignment: Alignment.center,
    //                                             child: Text(
    //                                               'key_CANCEL'.tr,
    //                                               style: mTextStyle14(),
    //                                             ),
    //                                           )),
    //                                     )),
    //                                 SizedBox(
    //                                     height: 45,
    //                                     width: MediaQuery.of(context)
    //                                             .size
    //                                             .width *
    //                                         0.42,
    //                                     child: InkWell(
    //                                       onTap: () async {
    //                                         fetchOrderDetails(
    //                                             isFromAcceptButton: true);
    //                                         setState(() {});
    //                                         //setState(() {});
    //                                         // print(
    //                                         //     "selected minutes ${_selectedMinutes.toInt()}");
    //                                       },
    //                                       child: Card(
    //                                           shadowColor: Colors.black,
    //                                           color: Colors.green,
    //                                           shape: RoundedRectangleBorder(
    //                                             borderRadius:
    //                                                 BorderRadius.circular(
    //                                                     10.0),
    //                                           ),
    //                                           child: Align(
    //                                             alignment: Alignment.center,
    //                                             child: Text(
    //                                               'key_ACCEPT'.tr,
    //                                               style: mTextStyle14(),
    //                                             ),
    //                                           )),
    //                                     )),
    //                               ],
    //                             ),
    //                             const SizedBox(
    //                               height: 5,
    //                             ),
    //                           ])),
    //                     )
    //                   : const SizedBox(),
    //             ],
    //           ),
    //         );
    //       } else {
    //         return Text(
    //             'No data available'); // Display a message when no data is available
    //       }
    //     }
    //   },
    // ));
  }
}
