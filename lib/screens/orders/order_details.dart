import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../apiServices/api_service.dart';
import '../../utils/theme_data.dart';
import 'package:intl/intl.dart';

class OrderDetails extends StatefulWidget {
  final int id;
  OrderDetails({required this.id});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  Map<String, dynamic> orderData ={};
  bool isLoading= true;

  String getFormatedDate(String date) {
    var tempDate = DateFormat("MMM dd, yyyy hh:mm:ss a").parse(date);

    return DateFormat('dd-MM-yyyy').format(tempDate);
  }

  Future<void> fetchOrderDetails() async {
    String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZGV2LWFwaS50YXN0ZXNvbndheS5jb21cL2FwaVwvdjJcL2tpdGNoZW4tb3duZXItbG9naW4tcmVnaXN0cmF0aW9uIiwiaWF0IjoxNjgyNjU5NTAwLCJleHAiOjE2ODQ1Nzk1MDAsIm5iZiI6MTY4MjY1OTUwMCwianRpIjoiazVvbWNFN3FBSVNjSHA4SyIsInN1YiI6MTM3LCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.oCSoJBQvPhVeqGstefU-W085MADkmYZ7NNFBKYwpOhk";
    final response = await http.post(
      Uri.parse("$baseUrl/order-details"),
      headers: {'Authorization': 'Bearer $token'},
      body: {"order_id": widget.id.toString()},
    );
    if (response.statusCode == 200) {
      isLoading=false;
      final jsonData = json.decode(response.body);
      setState(() {
        orderData = jsonData['data'];
      });
      print(orderData);
    } else {
      isLoading=false;
      print('Request failed with status: ${response.statusCode}.');
      setState(() {
      });
    }
  }

  @override
  void initState() {
    fetchOrderDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),
        title: Text(
          'Order Details',
          style: cardTitleStyle20(),
        ),
      ),
      body: isLoading?Center(child: SpinKitFadingCircle(color: orangeColor(),)):Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            const SizedBox(
              height: 25,
            ),
            Column(
              children: [
                SizedBox(
                  child: Card(
                    shadowColor: Colors.black,
                    color: const Color.fromRGBO(64, 68, 81, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Your Order',
                                  style: mTextStyle16(),
                                ),
                                Text(
                                  orderData['order_status'].toString(),
                                  style: cardTextStyle16(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5,),
                          const Divider(
                            height: 20,
                            color:Colors.white,
                            indent: 10,
                            endIndent: 10,
                          ),
                          Align(alignment: Alignment.centerLeft, child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7.0),
                            child: Text("Test Menu Items",style:cTextStyle16(),),
                          )),
                          const SizedBox(height: 5,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${orderData['order_detail'][0]['quantity']} X ₹ '+ orderData['order_detail'][0]['item_price'].toString(),
                                  style: cTextStyle16(),
                                ),
                                Text(
                                  '₹ '+ orderData['order_detail'][0]['item_price'].toString(),
                                  style: cTextStyle16(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5,),
                          const Divider(
                            height: 20,
                            color:Colors.white,
                            indent: 10,
                            endIndent: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Item Total',
                                  style: cTextStyle16(),
                                ),
                                Text(
                                  '₹ '+ orderData['order_detail'][0]['item_price'].toString(),
                                  style: cTextStyle16(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Discount',
                                  style: cTextStyle16(),
                                ),
                                Text(
                                  orderData['coupon'].toString()=='null' ? '₹ 0':'₹ '+orderData['coupon_amount'].toString(),
                                  style: cTextStyle16(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5,),
                          const SizedBox(height: 5,),
                          const Divider(
                            height: 20,
                            color:Colors.white,
                            indent: 10,
                            endIndent: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'You will get',
                                  style: cTextStyle16(),
                                ),
                                Text(
                                  orderData['order_earning_summary'].toString() =="null" ? "" : "₹ "+orderData['order_earning_summary']['owner_earning_amount'].toString(),
                                  style: cTextStyle16(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5,),
                          const Divider(
                            height: 20,
                            color:Colors.white,
                            indent: 10,
                            endIndent: 10,
                          ),

                          const SizedBox(height: 5,),
                          Align(alignment: Alignment.centerLeft, child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text("Order Details",style:mTextStyle16(),),
                          )),
                          const SizedBox(height: 5,),
                          Divider(
                            thickness: 1,
                            height: 20,
                            color:orangeColor(),
                            indent: 10,
                            endIndent: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Order Number',
                                  style: cTextStyle16(),
                                ),
                                Text(
                                  orderData['order_no'],
                                  style: cTextStyle16(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Payment Type',
                                  style: cTextStyle16(),
                                ),
                                Text(
                                  'Bank',
                                  style: cTextStyle16(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Date',
                                  style: cTextStyle16(),
                                ),
                                Text(
                                  getFormatedDate(orderData['created_at']),
                                  style: cTextStyle16(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Phone No.',
                                  style: cTextStyle16(),
                                ),
                                Text(
                                  orderData['user']['mobile_number'],
                                  style: cTextStyle16(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Deliver To',
                                  style: cTextStyle16(),
                                ),
                                SizedBox(
                                  width:200,
                                  child: Text(
                                    '${orderData['user_address']['address']+ ' '+ orderData['user_address']['area']+ ' '+ orderData['user_address']['city']['name']+ ' '+ orderData['user_address']['pin_code']}',
                                    textAlign: TextAlign.right,
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    style: cTextStyle16(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5,),


                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height:25),
                SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: InkWell(
                      onTap: () async {
                        final phoneNumber = orderData['user']['mobile_number'];
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
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Call to ${orderData['user']['name']} ('+ orderData['user']['mobile_number']+')',
                              style: mTextStyle14(),
                            ),
                          )),
                    )),
                const SizedBox(height:25),
              ],
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
