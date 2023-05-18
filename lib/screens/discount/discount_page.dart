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

class DiscountPage extends StatefulWidget {
  const DiscountPage({Key? key}) : super(key: key);

  @override
  State<DiscountPage> createState() => _DiscountPageState();
}

class _DiscountPageState extends State<DiscountPage> {
  int _current = 0;
  List apiData = [];
  int couponStatus = 2;
  bool isLoading = true;

  void fetchCoupon() async {
    String token = await Sharedprefrences.getToken();
    final response =
        await http.post(Uri.parse("$baseUrl/get-coupons"), headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "kitchen_owner_id": "${await getOwnerId()}",
    });
    print(getOwnerId());
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
    } else {
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
    }else {
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
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: orangeColor(),
              ),
            )
          : SingleChildScrollView(
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
                                                const ChoosePromo()),
                                      );
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
                  CarouselSlider(
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height / 2.5,
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
                                            );
                                          },
                                          child: Container(
                                            constraints:  BoxConstraints(
                                              maxWidth: MediaQuery.of(context).size.width*0.5, // Set the maximum width as desired
                                            ),
                                            child: Text(
                                              item.type == "% Off"
                                                  ? "${item.couponValue} ${item.type} Upto ₹ ${item.couponUptoAmount} \nUse Code ${item.name}" : "${item.type} Upto ₹ ${item.couponUptoAmount} \nUse Code ${item.name}",
                                                style: cTextStyle18(),
                                              ),
                                          ),
                                        ),
                                        Transform.scale(
                                          scale: 0.8,
                                          child: CupertinoSwitch(
                                              thumbColor: Colors.black,
                                              activeColor: orangeColor(),
                                              value: couponActive,
                                              onChanged: (bool value) async {
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
                                Text(
                                    "Valid On Orders Above ₹ ${item.minimumOrderValue}",
                                    style: cTextStyle14()),
                                Text(
                                    "You can use this ${item.name} code only ${item.validPerUser} times ",
                                    style: cTextStyle14()),
                                Text(
                                    "Applicable for maximum ${item.totalNoUser} users ",
                                    style: cTextStyle14()),
                                Text(
                                  "Valid from ${item.startDate} till ${item.validTillDate}",
                                  style: cTextStyle14(),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 35,
                                  width: double.infinity,
                                  child: Card(
                                    color:
                                        const Color.fromRGBO(105, 111, 130, 1),
                                    child: Center(
                                      child: Text(
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
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                      child: AnimatedSmoothIndicator(
                    activeIndex: _current,
                    count: apiData.length,
                    effect: WormEffect(
                      activeDotColor: orangeColor(),
                    ),
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
    );
  }
}
