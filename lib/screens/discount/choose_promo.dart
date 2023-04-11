import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastesonway/screens/discount/discount.dart';
import 'package:tastesonway/screens/discount/fixed_discount.dart';

import '../../utils/theme_data.dart';

class ChoosePromo extends StatelessWidget {
  const ChoosePromo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),
        title: Text(
          'key_Choose_promo'.tr,
          style: cardTitleStyle20(),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "key_Outlet_Promos".tr,
                style: mTextStyle20(),
              ),
            ),
            const SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text("key_These_promos_will_run_all_on_items_in_your_outlet".tr,style: cardTitleStyle14(),),
            ),
            const SizedBox(height:25),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Discount()),
                );
              },
              child: Card(
                shadowColor: Colors.black,
                color: cardColor(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              './assets/images/profile/Coupon.png',
                              height: 60,
                              width: 60,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              'key_discount'.tr,
                              style: mTextStyle20(),
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.white,
                      height:25,
                      indent: 5,
                        endIndent: 5,
                      ),
                      Text(
                        'key_Get_more_orders_with_the_most_famous_discount_on_Tastes_On_Way'.tr,
                        style: cTextStyle16(),
                      ),

                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height:10),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FixedDiscount()),
                );
              },
              child: Card(
                shadowColor: Colors.black,
                color: cardColor(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              './assets/images/profile/Coupon.png',
                              height: 60,
                              width: 60,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              'key_Fixed_discount'.tr,
                              style: mTextStyle20(),
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.white,
                        height:25,
                        indent: 5,
                        endIndent: 5,
                      ),
                      Text(
                        'key_Delight_customers_with_offers_like_100_OFF_on_the_orders'.tr,
                        style: cTextStyle16(),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
