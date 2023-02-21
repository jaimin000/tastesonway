import 'package:flutter/material.dart';
import 'package:tastesonway/screens/discount/discount.dart';
import 'package:tastesonway/screens/discount/fixed_discount.dart';

import '../../theme_data.dart';

class ChoosePromo extends StatelessWidget {
  const ChoosePromo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);

          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          'Choose Promo',
          style: cardTitleStyle20(),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            SizedBox(
              height: 25,
            ),
            Text(
              "Outlet Promos",
              style: mTextStyle20(),
            ),
            SizedBox(height: 5,),
            Text("These Promos will run all on items in your outlet",style: cardTitleStyle14(),),
            SizedBox(height:25),
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
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(8),
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
                              'Discount',
                              style: mTextStyle20(),
                            ),
                          ),
                        ],
                      ),
                      Divider(color: Colors.white,
                      height:25,
                      indent: 5,
                        endIndent: 5,
                      ),
                      Text(
                        'Get more orders with the most famous discount on Tastes On Way',
                        style: cTextStyle16(),
                      ),

                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height:10),
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
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(8),
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
                              'Fixed Discount',
                              style: mTextStyle20(),
                            ),
                          ),
                        ],
                      ),
                      Divider(color: Colors.white,
                        height:25,
                        indent: 5,
                        endIndent: 5,
                      ),
                      Text(
                        'Delight Customers with offers like ₹100 Off on the orders ',
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
