import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastesonway/utils/theme_data.dart';
import 'package:http/http.dart' as http;
import '../../apiServices/api_service.dart';
import '../../utils/sharedpreferences.dart';
import 'order_details.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class YourOrders extends StatefulWidget {
  const YourOrders({Key? key}) : super(key: key);

  @override
  State<YourOrders> createState() => _YourOrdersState();
}

class _YourOrdersState extends State<YourOrders> {
  List orderData = [];
  bool isLoading = true;
  String getFormatedDate(String date) {
    var tempDate = DateFormat("MMM dd, yyyy hh:mm:ss a").parse(date);

    return DateFormat('dd-MM-yyyy').format(tempDate);
  }

  Future<void> fetchOrder() async {
    String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZGV2LWFwaS50YXN0ZXNvbndheS5jb21cL2FwaVwvdjJcL2tpdGNoZW4tb3duZXItbG9naW4tcmVnaXN0cmF0aW9uIiwiaWF0IjoxNjgyNjU5NTAwLCJleHAiOjE2ODQ1Nzk1MDAsIm5iZiI6MTY4MjY1OTUwMCwianRpIjoiazVvbWNFN3FBSVNjSHA4SyIsInN1YiI6MTM3LCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.oCSoJBQvPhVeqGstefU-W085MADkmYZ7NNFBKYwpOhk";
    final response = await http.post(
      Uri.parse("$baseUrl/kitchen-owner-order-list"),
      headers: {'Authorization': 'Bearer $token'},
      body: {"date": "all"},
    );
    if (response.statusCode == 200) {
      isLoading=false;
      final jsonData = json.decode(response.body);
      setState(() {
         orderData = jsonData['data']['orderList']['data']  as List;
      });
    } else {
      isLoading=false;
      setState(() {
      });
      print('Request failed with status: ${response.statusCode}.');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Something Went Wrong Please try again !')));
    }
  }

  @override
  void initState() {
    fetchOrder();
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
          'key_Your_Orders'.tr,
          style: cardTitleStyle20(),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_alt_outlined),
          ),
        ],
      ),
      body: isLoading?Center(child: SpinKitFadingCircle(color: orangeColor(),)):Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView.builder(
          itemCount: orderData.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Stack(
                  clipBehavior: Clip.none, children: [
                  SizedBox(
                    height: 180,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  OrderDetails(id:orderData[index]['id'])),
                        );
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
                                        '₹ '+ orderData[index]['order_detail'][0]['item_price'].toString(),
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
                                        orderData[index]['order_status'],
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
                              getFormatedDate(orderData[index]['created_at']),
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
      ),
    );
  }
}
