import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastesonway/screens/discount/choose_promo.dart';
import 'package:tastesonway/utils/theme_data.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CreateDiscountCoupon extends StatefulWidget {
  const CreateDiscountCoupon({Key? key}) : super(key: key);

  @override
  State<CreateDiscountCoupon> createState() => _CreateDiscountCouponState();
}

class _CreateDiscountCouponState extends State<CreateDiscountCoupon> {
  int _current = 0;


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
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const SizedBox(
                      width: 312.58,
                      height: 189.19,
                      //margin: EdgeInsets.only(left: 82.87, top: 55.24),
                    ),
                    Positioned(
                      left: -343,
                      top: 130.78,
                      child: Container(
                        width: 1003.91,
                        height: 1037.91,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(39, 42, 50, 1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 100,
                      right: 105,
                      child:  Center(
                        child: InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ChoosePromo()),
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
                            child: Icon(Icons.add, color: orangeColor(),size: 50,),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(child: Text("key_New".tr,style: mTextStyle18(),)),
          const SizedBox(
            height: 35,
          ),
           CarouselSlider(
            options: CarouselOptions(
                height: MediaQuery.of(context).size.height / 3,
                onPageChanged: (i, r) {
                  setState(() {
                    _current = i;
                  });
                }),
            items: [
              SizedBox(
                width:300,
                child:Card(
                  color: const Color.fromRGBO(53, 56, 66, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    margin:const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("key_bestoffer".tr,style: cardTextStyle12(),),
                        Text("Cashback Upto ₹ 100 \nUse Code TRYME",style: cTextStyle18(),),
                        const Divider(
                          height: 20,
                          endIndent: 5,
                          indent: 5,
                          color: Colors.white,
                        ),
                        Text("Valid On Orders Above ₹ 400 ",style: cTextStyle14(),),
                        Text("You can use this ode on first order ",style: cTextStyle14(),),
                        Text("Valid from today till 26th Nov 2022",style: cTextStyle14(),),
                        const SizedBox(height:10),
                        SizedBox(height: 35,
                            width:double.infinity,
                            child: Card(color: const Color.fromRGBO(105, 111, 130, 1),child: Center(
                              child: Text("key_in_review".tr,
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
              ),
              SizedBox(
                width:300,
                child:Card(
                  color: const Color.fromRGBO(53, 56, 66, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    margin:const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("key_bestoffer".tr,style: cardTextStyle12(),),
                        Text("Cashback Upto ₹ 100 \nUse Code TRYME",style: cTextStyle18(),),
                        const Divider(
                          height: 20,
                          endIndent: 5,
                          indent: 5,
                          color: Colors.white,
                        ),
                        Text("Valid On Orders Above ₹ 400 ",style: cTextStyle14(),),
                        Text("You can use this ode on first order ",style: cTextStyle14(),),
                        Text("Valid from today till 26th Nov 2022",style: cTextStyle14(),),
                        const SizedBox(height:10),
                        SizedBox(height: 35,
                          width:double.infinity,
                          child: Card(color: const Color.fromRGBO(105, 111, 130, 1),child: Center(
                            child: Text("key_in_review".tr,
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
              ),
              SizedBox(
                width:300,
                child:Card(
                  color: const Color.fromRGBO(53, 56, 66, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    margin:const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("key_bestoffer".tr,style: cardTextStyle12(),),
                        Text("Cashback Upto ₹ 100 \nUse Code TRYME",style: cTextStyle18(),),
                        const Divider(
                          height: 20,
                          endIndent: 5,
                          indent: 5,
                          color: Colors.white,
                        ),
                        Text("Valid On Orders Above ₹ 400 ",style: cTextStyle14(),),
                        Text("You can use this ode on first order ",style: cTextStyle14(),),
                        Text("Valid from today till 26th Nov 2022",style: cTextStyle14(),),
                        const SizedBox(height:10),
                        SizedBox(height: 35,
                          width:double.infinity,
                          child: Card(color: const Color.fromRGBO(105, 111, 130, 1),child: Center(
                            child: Text("key_in_review".tr,
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
              ),

            ],
          ),
          const SizedBox(
            height:10,
          ),
          Center(
            child: AnimatedSmoothIndicator(
              activeIndex: _current,
              count:  3,
              effect:  WormEffect(
                activeDotColor: orangeColor(),
              ),
            )
          ),
          const SizedBox(
            height:10,
          ),
        ],
      ),
    );
  }
}
