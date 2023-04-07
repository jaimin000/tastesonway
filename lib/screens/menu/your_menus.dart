import 'package:flutter/material.dart';
import '../../utils/theme_data.dart';

class YourMenus extends StatefulWidget {
  const YourMenus({Key? key}) : super(key: key);

  @override
  State<YourMenus> createState() => _YourMenusState();
}

class _YourMenusState extends State<YourMenus> {
  int step = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [
      //text
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: TextField(
                style: const TextStyle(color: Colors.white), //<-- SEE HERE
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.search,
                    color: orangeColor(),
                  ),
                  contentPadding: const EdgeInsets.all(10.0),
                  fillColor: inputColor(),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  hintText: 'Search Menu Items',
                  hintStyle: inputTextStyle16(),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 120,
              width: MediaQuery.of(context).size.width,
              child: Card(
                shadowColor: Colors.black,
                color: cardColor(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          './assets/images/tea.jpg',
                          height: 90,
                          width: 95,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Masala Tea',
                              style: mTextStyle20(),
                            ),
                            Text(
                              '₹ 200',
                              style: cTextStyle18(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 120,
              width: MediaQuery.of(context).size.width,
              child: Card(
                shadowColor: Colors.black,
                color: cardColor(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          './assets/images/tea.jpg',
                          height: 90,
                          width: 95,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Masala Tea',
                              style: mTextStyle20(),
                            ),
                            Text(
                              '₹ 200',
                              style: cTextStyle18(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 120,
              width: MediaQuery.of(context).size.width,
              child: Card(
                shadowColor: Colors.black,
                color: cardColor(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          './assets/images/tea.jpg',
                          height: 90,
                          width: 95,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Masala Tea',
                              style: mTextStyle20(),
                            ),
                            Text(
                              '₹ 200',
                              style: cTextStyle18(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      //image
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: TextField(
                style: const TextStyle(color: Colors.white), //<-- SEE HERE

                cursorColor: Colors.white,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.search,
                    color: orangeColor(),
                  ),
                  contentPadding: const EdgeInsets.all(10.0),
                  fillColor: inputColor(),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  hintText: 'Search Menu Items',
                  hintStyle: inputTextStyle16(),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Themes", style: mTextStyle20()),
                Row(
                  children: [
                    Text("All", style: mTextStyle14()),
                    const SizedBox(
                      width: 5,
                    ),
                    Image.asset(
                      './assets/images/Arrow - Right.png',
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: SizedBox(
              height: 45,
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
                  const SizedBox(
                    width: 5,
                  ),
                  Card(
                    shadowColor: Colors.black,
                    color: const Color.fromRGBO(53, 56, 66, 1),
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
                  const SizedBox(
                    width: 5,
                  ),
                  Card(
                    shadowColor: Colors.black,
                    color: const Color.fromRGBO(53, 56, 66, 1),
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
                  const SizedBox(
                    width: 5,
                  ),
                  Card(
                    shadowColor: Colors.black,
                    color: const Color.fromRGBO(53, 56, 66, 1),
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
            height: MediaQuery.of(context).size.height * 0.53,
            //width: MediaQuery.of(context).size.width,
            child: GridView.count(
              padding: const EdgeInsets.all(15),
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
    ];
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),

        title: Text(
          'Your Menus',
          style: cardTitleStyle20(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        step = 0;
                      });
                    },
                    child: Card(
                      shadowColor: Colors.black,
                      color: step == 0
                          ? orangeColor()
                          : const Color.fromRGBO(53, 56, 66, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2.2,
                        height: 45,
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Text Menu',
                              style: mTextStyle16(),
                            )),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        step = 1;
                      });
                    },
                    child: Card(
                      shadowColor: Colors.black,
                      color: step == 1
                          ? orangeColor()
                          : const Color.fromRGBO(53, 56, 66, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2.2,
                        height: 45,
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Image Menu',
                              style: mTextStyle16(),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            widgetList[step],
          ],
        ),
      ),
    );
  }
}
