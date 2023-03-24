import 'package:flutter/material.dart';
import 'package:tastesonway/screens/dashboard/stories.dart';
import 'package:tastesonway/screens/earning%20summary/earning_summary.dart';
import 'package:tastesonway/screens/menu/image%20menu/create_image_menu.dart';
import 'package:tastesonway/screens/menu/text%20menu/create_text_menu1.dart';
import 'package:tastesonway/screens/menu/your_menus.dart';
import 'package:tastesonway/screens/orders/received_orders.dart';
import 'package:tastesonway/screens/profile/profile.dart';
import 'package:tastesonway/screens/orders/yourorders.dart';
import 'dart:core';
import '../../theme_data.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Good Morning",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w800),
                ),
                Text(
                  "Sania Fraser",
                  style: mTextStyle20(),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Profile()),
                );
              },
              child: const CircleAvatar(
                backgroundImage:
                NetworkImage(
                    'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            const SizedBox(
              height: 105,
              child: Stories(),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                style: const TextStyle(color: Colors.white), //<-- SEE HERE
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                    fillColor: inputColor(),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    hintText: 'Find Your Dishes',
                    hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
                    suffixIcon:
                        Image.asset('./assets/images/dashboard/Filter.png')),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Quick Links", style: mTextStyle20()),
                  Row(
                    children: [
                      Text("All", style: mTextStyle14()),
                      const SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        './assets/images/dashboard/Arrow - Right.png',
                        height: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const YourOrders()),
                        );
                      },
                      child: Card(
                        shadowColor: Colors.black,
                        color: const Color.fromRGBO(53, 56, 66, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: SizedBox(
                            width: 150,
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                    './assets/images/dashboard/food.png'),
                                Text(
                                  'Orders',
                                  style: cTextStyle18(),
                                )
                              ],
                            )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const YourMenus()),
                        );
                      },
                      child: Card(
                        shadowColor: Colors.black,
                        color: const Color.fromRGBO(53, 56, 66, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: SizedBox(
                            width: 150,
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                    './assets/images/dashboard/menu.png'),
                                Text(
                                  'Menus',
                                  style: cTextStyle18(),
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
                          width: 150,
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Others',
                                style: cTextStyle18(),
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Your Menus", style: mTextStyle20()),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const YourMenus()),
                      );
                    },
                    child: Row(
                      children: [
                        Text("All", style: mTextStyle14()),
                        const SizedBox(
                          width: 5,
                        ),
                        Image.asset(
                          './assets/images/dashboard/Arrow - Right.png',
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 130,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CreateTextMenu()),
                        );
                      },
                      child: Card(
                        color: const Color.fromRGBO(53, 56, 66, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Container(
                          width: 330,
                          height: 130,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  './assets/images/dashboard/Rectangle 39389.png'),
                              fit: BoxFit.fill,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text("Create New\n Text Menu",
                                  style: cardTextStyle20()),
                            ),
                          ),
                        ), //
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CreateImageMenu()),
                        );
                      },
                      child: Card(
                        color: const Color.fromRGBO(53, 56, 66, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Container(
                          width: 330,
                          height: 130,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  './assets/images/dashboard/Rectangle 39389.png'),
                              fit: BoxFit.fill,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text("Create New\n Image Menu",
                                  style: cardTextStyle20()),
                            ),
                          ),
                        ), //
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Card(
                      shadowColor: Colors.black,
                      color: const Color.fromRGBO(53, 56, 66, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: SizedBox(
                          width: 180,
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('0', style: cTextStyle36()),
                              Text(
                                'Your Menus',
                                style: cTextStyle18(),
                              )
                            ],
                          )),
                    ),
                    Card(
                      shadowColor: Colors.black,
                      color: const Color.fromRGBO(53, 56, 66, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: SizedBox(
                          width: 180,
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('2', style: cTextStyle36()),
                              Text(
                                'Menu Items',
                                style: cTextStyle18(),
                              )
                            ],
                          )),
                    ),
                    Card(
                      shadowColor: Colors.black,
                      color: const Color.fromRGBO(53, 56, 66, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: SizedBox(
                          width: 180,
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('2', style: cTextStyle36()),
                              Text(
                                'Menu Items',
                                style: cTextStyle18(),
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReceivedOrders()),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Your Orders", style: mTextStyle20()),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const YourOrders()),
                        );
                      },
                      child: Row(
                        children: [
                          Text("All", style: mTextStyle14()),
                          const SizedBox(
                            width: 5,
                          ),
                          Image.asset(
                            './assets/images/dashboard/Arrow - Right.png',
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 130,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Card(
                      color: const Color.fromRGBO(53, 56, 66, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const YourOrders()),
                          );
                        },
                        child: Container(
                          width: 300,
                          height: 130,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  './assets/images/dashboard/Frame 48095724.png'),
                              fit: BoxFit.fill,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text("View Your\n Orders",
                                  style: cardTextStyle20()),
                            ),
                          ),
                        ),
                      ), //
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ReceivedOrders()),
                        );
                      },
                      child: Card(
                        color: const Color.fromRGBO(53, 56, 66, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Container(
                          width: 300,
                          height: 130,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  './assets/images/dashboard/Frame 48095724.png'),
                              fit: BoxFit.fill,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text("View Received\n Orders",
                                  style: cardTextStyle20()),
                            ),
                          ),
                        ), //
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Card(
                      shadowColor: Colors.black,
                      color: const Color.fromRGBO(53, 56, 66, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: SizedBox(
                          width: 150,
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('0', style: cTextStyle36()),
                              Text(
                                'Today',
                                style: cTextStyle18(),
                              )
                            ],
                          )),
                    ),
                    Card(
                      shadowColor: Colors.black,
                      color: const Color.fromRGBO(53, 56, 66, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: SizedBox(
                          width: 150,
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('2', style: cTextStyle36()),
                              Text(
                                'Yesterday',
                                style: cTextStyle18(),
                              )
                            ],
                          )),
                    ),
                    Card(
                      shadowColor: Colors.black,
                      color: const Color.fromRGBO(53, 56, 66, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: SizedBox(
                          width: 150,
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('2', style: cTextStyle36()),
                              Text(
                                'Yesterday',
                                style: cTextStyle18(),
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Earning Summary", style: mTextStyle20()),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EarningSummary()),
                      );
                    },
                    child: Row(
                      children: [
                        Text("All", style: mTextStyle14()),
                        const SizedBox(
                          width: 5,
                        ),
                        Image.asset(
                          './assets/images/dashboard/Arrow - Right.png',
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EarningSummary()),
                );
              },
              child: SizedBox(
                height: 130,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Card(
                        color: const Color.fromRGBO(53, 56, 66, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Container(
                          width: 330,
                          height: 130,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  './assets/images/dashboard/Rectangle 39389-1.png'),
                              fit: BoxFit.fill,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text("View Earning\n Summary",
                                  style: cardTextStyle20()),
                            ),
                          ),
                        ), //
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Card(
                        color: const Color.fromRGBO(53, 56, 66, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Container(
                          width: 330,
                          height: 130,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  './assets/images/dashboard/Rectangle 39389-1.png'),
                              fit: BoxFit.fill,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text("View Earning\n Summary",
                                  style: cardTextStyle20()),
                            ),
                          ),
                        ), //
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Card(
                      shadowColor: Colors.black,
                      color: const Color.fromRGBO(53, 56, 66, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: SizedBox(
                          width: 220,
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('₹100', style: cTextStyle36()),
                              Text(
                                'This Week',
                                style: cTextStyle18(),
                              )
                            ],
                          )),
                    ),
                    Card(
                      shadowColor: Colors.black,
                      color: const Color.fromRGBO(53, 56, 66, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: SizedBox(
                          width: 220,
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('₹200', style: cTextStyle36()),
                              Text(
                                'This Month',
                                style: cTextStyle18(),
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          )),
                    ),
                    Card(
                      shadowColor: Colors.black,
                      color: const Color.fromRGBO(53, 56, 66, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: SizedBox(
                          width: 220,
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('₹200', style: cTextStyle36()),
                              Text(
                                'Last Month',
                                style: cTextStyle18(),
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
