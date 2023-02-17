import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tastesonway/screens/addnewitem.dart';
import 'package:tastesonway/screens/createimagemenu.dart';
import 'package:tastesonway/screens/createtextmenu.dart';
import 'package:tastesonway/screens/yourmenus.dart';
import 'dart:core';
import '../themedata.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
        backgroundColor: backgroundColor(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
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
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 38,
                            backgroundColor: Colors.orange,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg?auto=compress&cs=tinysrgb&w=800'),
                              radius: 35,
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text("Chef 1", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 38,
                          backgroundColor: Colors.orange,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg?auto=compress&cs=tinysrgb&w=800'),
                            radius: 35,
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text("Chef 1", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 38,
                          backgroundColor: Colors.orange,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg?auto=compress&cs=tinysrgb&w=800'),
                            radius: 35,
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text("Chef 1", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 38,
                          backgroundColor: Colors.orange,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg?auto=compress&cs=tinysrgb&w=800'),
                            radius: 35,
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text("Chef 1", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 38,
                          backgroundColor: Colors.orange,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg?auto=compress&cs=tinysrgb&w=800'),
                            radius: 35,
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text("Chef 1", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                )),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                style: TextStyle(color: Colors.white), //<-- SEE HERE
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                    fillColor: inputColor(),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    hintText: 'Find Your Dishes',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                    suffixIcon:
                        Image.asset('./assets/images/dashboard/Filter.png')),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Quick Links", style: mTextStyle20()),
                  Row(
                    children: [
                      Text("All", style: mTextStyle14()),
                      SizedBox(
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
            SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Card(
                      shadowColor: Colors.black,
                      color: Color.fromRGBO(53, 56, 66, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: SizedBox(
                          width: 150,
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset('./assets/images/dashboard/food.png'),
                              Text(
                                'Orders',
                                style: cTextStyle18(),
                              )
                            ],
                          )),
                    ),
                    Card(
                      shadowColor: Colors.black,
                      color: Color.fromRGBO(53, 56, 66, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: SizedBox(
                          width: 150,
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset('./assets/images/dashboard/food.png'),
                              Text(
                                'Orders',
                                style: cTextStyle18(),
                              )
                            ],
                          )),
                    ),
                    Card(
                      shadowColor: Colors.black,
                      color: Color.fromRGBO(53, 56, 66, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: SizedBox(
                          width: 150,
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset('./assets/images/dashboard/food.png'),
                              Text(
                                'Orders',
                                style: cTextStyle18(),
                              )
                            ],
                          )),
                    ),
                    Card(
                      shadowColor: Colors.black,
                      color: Color.fromRGBO(53, 56, 66, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: SizedBox(
                          width: 150,
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset('./assets/images/dashboard/food.png'),
                              Text(
                                'Orders',
                                style: cTextStyle18(),
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                        SizedBox(
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
            SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 130,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
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
                        color: Color.fromRGBO(53, 56, 66, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Container(
                          width: 330,
                          height: 130,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  './assets/images/dashboard/Rectangle 39389.png'),
                              fit: BoxFit.fill,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text("Create New\n Text Menu",
                                  style: cardTextStyle18()),
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
                              builder: (context) => CreateImageMenu()),
                        );
                      },
                      child: Card(
                        color: Color.fromRGBO(53, 56, 66, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Container(
                          width: 330,
                          height: 130,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  './assets/images/dashboard/Rectangle 39389.png'),
                              fit: BoxFit.fill,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text("Create New\n Image Menu",
                                  style: cardTextStyle18()),
                            ),
                          ),
                        ), //
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Card(
                      shadowColor: Colors.black,
                      color: Color.fromRGBO(53, 56, 66, 1),
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
                      color: Color.fromRGBO(53, 56, 66, 1),
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
                      color: Color.fromRGBO(53, 56, 66, 1),
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
            SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Your Orders", style: mTextStyle20()),
                  Row(
                    children: [
                      Text("All", style: mTextStyle14()),
                      SizedBox(
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
            SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 130,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Card(
                      color: Color.fromRGBO(53, 56, 66, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        width: 300,
                        height: 130,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                './assets/images/dashboard/Frame 48095724.png'),
                            fit: BoxFit.fill,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text("View Your\n Orders",
                                style: cardTextStyle18()),
                          ),
                        ),
                      ), //
                    ),
                    Card(
                      color: Color.fromRGBO(53, 56, 66, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        width: 300,
                        height: 130,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                './assets/images/dashboard/Frame 48095724.png'),
                            fit: BoxFit.fill,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text("View Your\n Orders",
                                style: cardTextStyle18()),
                          ),
                        ),
                      ), //
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Card(
                      shadowColor: Colors.black,
                      color: Color.fromRGBO(53, 56, 66, 1),
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
                      color: Color.fromRGBO(53, 56, 66, 1),
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
                      color: Color.fromRGBO(53, 56, 66, 1),
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
            SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Earning Summary", style: mTextStyle20()),
                  Row(
                    children: [
                      Text("All", style: mTextStyle14()),
                      SizedBox(
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
            SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 130,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Card(
                      color: Color.fromRGBO(53, 56, 66, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        width: 330,
                        height: 130,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                './assets/images/dashboard/Rectangle 39389-1.png'),
                            fit: BoxFit.fill,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text("View Earning\n Summary",
                                style: cardTextStyle18()),
                          ),
                        ),
                      ), //
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Card(
                      color: Color.fromRGBO(53, 56, 66, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        width: 330,
                        height: 130,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                './assets/images/dashboard/Rectangle 39389-1.png'),
                            fit: BoxFit.fill,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text("View Earning\n Summary",
                                style: cardTextStyle18()),
                          ),
                        ),
                      ), //
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Card(
                      shadowColor: Colors.black,
                      color: Color.fromRGBO(53, 56, 66, 1),
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
                      color: Color.fromRGBO(53, 56, 66, 1),
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
                      color: Color.fromRGBO(53, 56, 66, 1),
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
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
