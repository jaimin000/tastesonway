import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastesonway/screens/discount/choose_discount.dart';
import 'package:tastesonway/screens/discount/edit_coupon.dart';
import 'package:tastesonway/utils/theme_data.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;
import '../../apiServices/api_service.dart';
import '../../models/coupon.dart';
import '../../utils/sharedpreferences.dart';
import '../../utils/snackbar.dart';
import '../undermaintenance.dart';
import 'package:intl/intl.dart';

class DiscountPage extends StatefulWidget {
  const DiscountPage({Key? key}) : super(key: key);

  @override
  State<DiscountPage> createState() => _DiscountPageState();
}

class _DiscountPageState extends State<DiscountPage> {
  bool isServicePresent = false;
  int _current = 0;
  List apiData = [];
  int couponStatus = 2;
  bool isLoading = true;
  int refreshCounter = 0;
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");


  void fetchCoupon() async {
    String token = await Sharedprefrences.getToken();
   String? ownerId = await Sharedprefrences.getId();
    final response =
        await http.post(Uri.parse("$baseUrl/get-coupons"), headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "kitchen_owner_id": ownerId,
    });
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      final data = json.decode(response.body);
      List<dynamic> responseData = data['data']['data'];
      apiData = responseData.map((item) {
        Map<String, dynamic> couponData = item['coupon'];
        return Coupon(
          id: couponData['id'],
          name: couponData['name'],
          type: couponData['type'],
          couponValue: couponData['coupon_value'],
          validPerUser: couponData['valid_per_user'],
          totalNoUser: couponData['total_no_user'],
          startDate: couponData['start_date'],
          validTillDate: couponData['valid_till_date'],
          minimumOrderValue: couponData['minimum_order_value'],
          couponUptoAmount: couponData['coupon_upto_amount'],
          status: couponData['status'],
          couponActive: couponData['coupon_active'],
        );
      }).toList();
    // } else if(response.statusCode == 401) {
    //   print("refresh token called");
    //   await bool tokenRefreshed = await getNewToken(context);
    //   fetchCoupon();
    }
    else if (response.statusCode == 401) {
      final jsonData = json.decode(response.body);
      if (jsonData['message']
          .toString()
          .contains('maintenance')) {
        print('server is undermaintenance');
        setState(() {
          isServicePresent = true;
        });
      }
      else if(!isServicePresent) {
        print("refresh token called");
        if (refreshCounter == 0) {
          refreshCounter++;
          bool tokenRefreshed = await getNewToken(context);
          tokenRefreshed ? fetchCoupon(): null;
        }
      }
    }
    else {
      setState(() {
        isLoading = true;
      });
      throw Exception('Failed to fetch data from API');
    }
  }

  void fetchCouponStatus(int id) async {
    String token = await Sharedprefrences.getToken();
    final response =
    await http.post(Uri.parse("$baseUrl/update-coupon-status"), headers: {
      'Authorization': 'Bearer $token',
    }, body: {
        "id" : "$id",
        "coupon_active": "$couponStatus"
    });
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      final data = json.decode(response.body);
      print(data);
      ScaffoldSnackbar.of(context).show(data['message']);

    } else if(response.statusCode == 401) {
      print("refresh token called");
      if (refreshCounter == 0) {
        refreshCounter++;
        bool tokenRefreshed = await getNewToken(context);
        tokenRefreshed ? fetchCouponStatus(id) : null;
      }
    }
    else {
      setState(() {
        isLoading = true;
      });
      throw Exception('Failed to fetch data from API');
    }
  }

  @override
  void initState() {
    fetchCoupon();
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
          'key_Outlet_Promos'.tr,
          style: cardTitleStyle20(),
        ),
      ),
      body:
      // isLoading
      //     ? Center(
      //         child: CircularProgressIndicator(
      //           color: orangeColor(),
      //         ),
      //       ) :
      UnderMaintenanceWidget(
        isShow: isServicePresent,
        callback: () async {
           fetchCoupon();
        },
             child: SingleChildScrollView(
                child: Column(
                  // shrinkWrap: true,
                  // scrollDirection: Axis.vertical,
                  children: [
                    SizedBox(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                const SizedBox(
                                  width: 312.58,
                                  height: 189.19,
                                  //margin: EdgeInsets.only(left: 82.87, top: 55.24),
                                ),
                                // Positioned(
                                //   left: -343,
                                //   top: 130.78,
                                //   child: Container(
                                //     width: 1003.91,
                                //     height: 1037.91,
                                //     decoration: const BoxDecoration(
                                //       color: Color.fromRGBO(39, 42, 50, 1),
                                //       shape: BoxShape.circle,
                                //     ),
                                //   ),
                                // ),
                                Positioned(
                                  top: 100,
                                  right: 105,
                                  child: Center(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ChooseDiscount()),
                                        ).then((value) {
                                          if (value == "true") {
                                            setState(() {
                                              fetchCoupon();
                                            });
                                          }
                                        });
                                      },
                                      child: Container(
                                        height: 110,
                                        width: 110,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color.fromRGBO(53, 56, 66, 1),
                                        ),
                                        alignment: Alignment.center,
                                        child: Icon(
                                          Icons.add,
                                          color: orangeColor(),
                                          size: 50,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: Text(
                      "key_New".tr,
                      style: mTextStyle18(),
                    )),
                    const SizedBox(
                      height: 35,
                    ),
                    apiData.isNotEmpty ? const SizedBox() : const SizedBox(height:100),
                    apiData.isNotEmpty ?
                    CarouselSlider(
                      options: CarouselOptions(
                        enableInfiniteScroll: false,
                        height: MediaQuery.of(context).size.height / 2.3,
                        onPageChanged: (i, r) {
                          setState(() {
                            _current = i;
                          });
                        },
                      ),
                      items: apiData.map((item) {
                        bool couponActive = item.couponActive == 'Yes' ? true : false;
                        return SizedBox(
                          child: Card(
                            color: const Color.fromRGBO(53, 56, 66, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              margin: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("key_bestoffer".tr,
                                      style: cardTextStyle12()),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap:(){
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => EditCoupon(isFixedData: item.type == '% Off'?false:true,data: item)),
                                              ).then((value) {
                                                if (value == "true") {
                                                  setState(() {
                                                    fetchCoupon();
                                                  });
                                                }
                                              });
                                            },
                                            child: Container(
                                              constraints:  BoxConstraints(
                                                maxWidth: MediaQuery.of(context).size.width*0.5, // Set the maximum width as desired
                                              ),
                                              child: Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: item.type == "% Off"
                                                          ? "${item.couponValue} ${item.type} Upto "
                                                          : "${item.type} Upto ",
                                                      style: cTextStyle18(),
                                                    ),
                                                    TextSpan(
                                                      text: "₹ ${item.couponUptoAmount}",
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: "\nUse Code ",
                                                      style: cTextStyle16(),
                                                    ),
                                                    TextSpan(
                                                      text: item.name,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Transform.scale(
                                            scale: 0.8,
                                            child: CupertinoSwitch(
                                                thumbColor: Colors.black,
                                                activeColor: orangeColor(),
                                                value:dateFormat.parse(item.validTillDate).isBefore(DateTime.now()) ? false : couponActive,
                                                onChanged: dateFormat.parse(item.validTillDate).isBefore(DateTime.now()) ? null :(bool value) async {
                                                  setState(() {
                                                    couponActive = value;
                                                    print(couponActive);
                                                  });
                                                  couponStatus = couponActive ? 1:2;
                                                   fetchCouponStatus(item.id);
                                                   fetchCoupon();
                                                  setState(() {
                                                  });
                                                }),
                                          ),
                                        ],
                                      ),
                                  const Divider(
                                    height: 20,
                                    endIndent: 5,
                                    indent: 5,
                                    color: Colors.white,
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      text: 'Valid On Orders Above ',
                                      style: cTextStyle14(),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '₹ ${item.minimumOrderValue}',
                                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      text: 'You can use this ${item.name} code only ',
                                      style: cTextStyle14(),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '${item.validPerUser}',
                                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                                        ),
                                        TextSpan(
                                          text: ' times',
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      text: 'Applicable for maximum ',
                                      style: cTextStyle14(),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '${item.totalNoUser}',
                                          style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                                        ),
                                        const TextSpan(
                                          text: ' users',
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      text: 'Valid from ',
                                      style: cTextStyle14(),
                                      children: [
                                        TextSpan(
                                          text: '${item.startDate}',
                                          style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                                        ),
                                      ]
                                    ),

                                  ),
                                  Text.rich(
                                    TextSpan(
                                        text: 'till ',
                                        style: cTextStyle14(),
                                        children: [
                                          TextSpan(
                                            text: ' ${item.validTillDate}',
                                            style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                                          ),
                                        ]
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    height: 35,
                                    width: double.infinity,
                                    child: Card(
                                      color:
                                          const Color.fromRGBO(105, 111, 130, 1),
                                      child: Center(
                                        child:
                                        dateFormat.parse(item.validTillDate).isBefore(DateTime.now()) ? Text('key_Expired'.tr,
                                          textAlign: TextAlign.center,
                                          style: cardTextStyle16())
                                            : Text(
                                          item.status == 1
                                              ? "key_in_review".tr
                                              : item.status == 2
                                                  ? "key_accepted".tr
                                                  : "key_rejected".tr,
                                         textAlign: TextAlign.center,
                                          style: mTextStyle16(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ) : Padding(
                      padding: const EdgeInsets.only(top:20.0),
                      child: Text('key_No_running_promos'.tr,style: cardTextStyle18()),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    apiData.isNotEmpty ? Center(
                        child: AnimatedSmoothIndicator(
                      activeIndex: _current,
                      count: apiData.length,
                      effect: WormEffect(
                        activeDotColor: orangeColor(),
                      ),
                    )) : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('key_Create_promos_and_grow_your_business_now'.tr,
                        style: mTextStyle16(),overflow: TextOverflow.clip,),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
           ),
    );
  }
}
