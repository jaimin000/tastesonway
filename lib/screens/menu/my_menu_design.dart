import 'package:flutter/material.dart';
import 'package:tastesonway/theme_data.dart';

class MenuDesign extends StatefulWidget {
  const MenuDesign({Key? key}) : super(key: key);

  @override
  State<MenuDesign> createState() => _MenuDesignState();
}

class _MenuDesignState extends State<MenuDesign> {
  int step = 0;

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
          'List of Items',
          style: cardTitleStyle20(),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: SizedBox(
              height:45,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Card(
                    shadowColor: Colors.black,
                    color: orangeColor(),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: SizedBox(
                      width: 100,
                      height: 45,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Regular',
                            style: mTextStyle16(),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Card(
                    shadowColor: Colors.black,
                    color: Color.fromRGBO(53, 56, 66, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: SizedBox(
                      width: 100,
                      height: 45,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Holi',
                            style: mTextStyle16(),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Card(
                    shadowColor: Colors.black,
                    color: Color.fromRGBO(53, 56, 66, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: SizedBox(
                      width: 100,
                      height: 45,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Diwali',
                            style: mTextStyle16(),
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Card(
                    shadowColor: Colors.black,
                    color: Color.fromRGBO(53, 56, 66, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: SizedBox(
                      width: 100,
                      height: 45,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Navratri',
                            style: mTextStyle16(),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.65,
            width: MediaQuery.of(context).size.width,
            child: GridView.count(
              padding: const EdgeInsets.all(20),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        './assets/images/your menus/Continental.png',
                        fit: BoxFit.fill,
                        height: 130,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        './assets/images/your menus/Breakfast.png',
                        fit: BoxFit.fill,
                        height: 130,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        './assets/images/your menus/Grill Heaven.png',
                        fit: BoxFit.fill,
                        height: 130,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        './assets/images/your menus/Midnight Mojito.png',
                        fit: BoxFit.fill,
                        height: 130,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        './assets/images/your menus/Tandoori Tofu.png',
                        fit: BoxFit.fill,
                        height: 130,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        './assets/images/your menus/Veggie Blast.png',
                        fit: BoxFit.fill,
                        height: 130,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
