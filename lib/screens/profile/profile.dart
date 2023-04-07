import 'package:flutter/material.dart';
import 'package:tastesonway/screens/contact%20us/contactus.dart';
import 'package:tastesonway/screens/fssai/fssai.dart';
import 'package:tastesonway/screens/my%20website/my_website.dart';
import 'package:tastesonway/screens/discount/create_discount_coupon.dart';
import 'package:tastesonway/screens/faq/faq.dart';
import 'package:tastesonway/screens/menu/menu_items.dart';
import 'package:tastesonway/screens/menu/my_menu_design.dart';
import 'package:tastesonway/screens/orders/received_orders.dart';
import 'package:tastesonway/screens/setting/setting.dart';
import 'package:tastesonway/utils/theme_data.dart';
import '../tutorials/tutorials.dart';

import '../bank/banking_details.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
          ),
        ],
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
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              './assets/images/profile/image 28.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      width: 312.58,
                      height: 189.19,
                      //margin: EdgeInsets.only(left: 82.87, top: 55.24),
                    ),
                    Positioned(
                      left: -380,
                      top: 150.78,
                      child: Container(
                        width: 1003.91,
                        height: 1037.91,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(39, 42, 50, 1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const Positioned(
                      top: 70,
                      right: 70,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
                        radius: 80,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          Container(
            color: const Color.fromRGBO(39, 42, 50, 1),
            child: Text(
              'Shania Fraser (ENG)',
              textAlign: TextAlign.center,
              style: mTextStyle20(),
            ),
          ),
          Container(
            color: const Color.fromRGBO(39, 42, 50, 1),
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Lorem ipsum is simply dummy text of the printing and typesetting industry.',
              textAlign: TextAlign.center,
              style: cTextStyle12(),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            color: const Color.fromRGBO(39, 42, 50, 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.star_border,
                      color: fontColor(),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text('4.8(163)', style: cTextStyle12())
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.timer_sharp,
                      color: fontColor(),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text('20 min', style: cTextStyle12())
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.local_fire_department_outlined,
                      color: fontColor(),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text('150 kcal', style: cTextStyle12())
                  ],
                ),
              ],
            ),
          ),
          Container(
            //height: 1150,
            color: const Color.fromRGBO(39, 42, 50, 1),
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              shrinkWrap: true,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreateDiscountCoupon()));
                  },
                  child: Card(
                    shadowColor: Colors.black,
                    color: const Color.fromRGBO(53, 56, 66, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: SizedBox(
                        width: 140,
                        height: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset('./assets/images/profile/Coupon.png'),
                            Text(
                              'Create Discount Coupon',
                              textAlign: TextAlign.center,
                              style: cTextStyle16(),
                            )
                          ],
                        )),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyWebsite()));
                  },
                  child: Card(
                    shadowColor: Colors.black,
                    color: const Color.fromRGBO(53, 56, 66, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: SizedBox(
                        width: 140,
                        height: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset('./assets/images/profile/Website.png'),
                            Text(
                              'My Website',
                              textAlign: TextAlign.center,
                              style: cTextStyle16(),
                            )
                          ],
                        )),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Fssai()),
                    );
                  },
                  child: Card(
                    shadowColor: Colors.black,
                    color: const Color.fromRGBO(53, 56, 66, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: SizedBox(
                        width: 140,
                        height: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset('./assets/images/profile/Fssai.png'),
                            Text(
                              'Fssai Registration',
                              textAlign: TextAlign.center,
                              style: cTextStyle16(),
                            )
                          ],
                        )),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BankingDetails()),
                    );
                  },
                  child: Card(
                    shadowColor: Colors.black,
                    color: const Color.fromRGBO(53, 56, 66, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: SizedBox(
                        width: 140,
                        height: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                                './assets/images/profile/Bank Details.png'),
                            Text(
                              'Bank Details',
                              textAlign: TextAlign.center,
                              style: cTextStyle16(),
                            )
                          ],
                        )),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ReceivedOrders()),
                    );
                  },
                  child: Card(
                    shadowColor: Colors.black,
                    color: const Color.fromRGBO(53, 56, 66, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: SizedBox(
                        width: 140,
                        height: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                                './assets/images/profile/Your Orders.png'),
                            Text(
                              'Your Orders',
                              textAlign: TextAlign.center,
                              style: cTextStyle16(),
                            )
                          ],
                        )),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MenuItems()),
                    );
                  },
                  child: Card(
                    shadowColor: Colors.black,
                    color: const Color.fromRGBO(53, 56, 66, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: SizedBox(
                        width: 140,
                        height: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset('./assets/images/profile/Menu Items.png'),
                            Text(
                              'Menu Items',
                              textAlign: TextAlign.center,
                              style: cTextStyle16(),
                            )
                          ],
                        )),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MenuDesign()),
                    );
                  },
                  child: Card(
                    shadowColor: Colors.black,
                    color: const Color.fromRGBO(53, 56, 66, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: SizedBox(
                        width: 140,
                        height: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                                './assets/images/profile/My Menu Design.png'),
                            Text(
                              'My Menu Design',
                              textAlign: TextAlign.center,
                              style: cTextStyle16(),
                            )
                          ],
                        )),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Tutorials()),
                    );
                  },
                  child: Card(
                    shadowColor: Colors.black,
                    color: const Color.fromRGBO(53, 56, 66, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: SizedBox(
                        width: 140,
                        height: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                                './assets/images/profile/VideoTutorials.png'),
                            Text(
                              'Video Tutorials',
                              textAlign: TextAlign.center,
                              style: cTextStyle16(),
                            )
                          ],
                        )),
                  ),
                ),
                Card(
                  shadowColor: Colors.black,
                  color: const Color.fromRGBO(53, 56, 66, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: SizedBox(
                      width: 140,
                      height: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                              './assets/images/profile/Shares Taste on Way.png'),
                          Text(
                            'Share Tastes On Way',
                            textAlign: TextAlign.center,
                            style: cTextStyle16(),
                          )
                        ],
                      )),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ContactUs()),
                    );
                  },
                  child: Card(
                    shadowColor: Colors.black,
                    color: const Color.fromRGBO(53, 56, 66, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: SizedBox(
                        width: 140,
                        height: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset('./assets/images/profile/Contact Us.png'),
                            Text(
                              'Contact Us',
                              textAlign: TextAlign.center,
                              style: cTextStyle16(),
                            )
                          ],
                        )),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FAQ()),
                    );
                  },
                  child: Card(
                    shadowColor: Colors.black,
                    color: const Color.fromRGBO(53, 56, 66, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: SizedBox(
                        width: 140,
                        height: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset('./assets/images/profile/FAQ.png'),
                            Text(
                              'FAQ',
                              textAlign: TextAlign.center,
                              style: cTextStyle16(),
                            )
                          ],
                        )),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Setting()),
                    );
                  },
                  child: Card(
                    shadowColor: Colors.black,
                    color: const Color.fromRGBO(53, 56, 66, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: SizedBox(
                        width: 140,
                        height: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset('./assets/images/profile/Settings.png'),
                            Text(
                              'Settings',
                              textAlign: TextAlign.center,
                              style: cTextStyle16(),
                            )
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
