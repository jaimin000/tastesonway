import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tastesonway/screens/menu/text%20menu/add_new_item.dart';
import '../../../theme_data.dart';

class CreateImageMenu extends StatefulWidget {
  const CreateImageMenu({Key? key}) : super(key: key);

  @override
  State<CreateImageMenu> createState() => _CreateImageMenuState();
}

class _CreateImageMenuState extends State<CreateImageMenu> {
  bool _checkValue = true;
  bool _switchValue = true;
  int step = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [
      //step 1
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Card(
          shadowColor: Colors.black,
          color: cardColor(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: SizedBox(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Basic Details',
                    style: mTextStyle18(),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Lorem ipsum is simply dummy text of the printing and typesetting industry.',
                    style: cTextStyle12(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      style: const TextStyle(color: Colors.white), //<-- SEE HERE

                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10.0),
                        fillColor: inputColor(),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
                        hintText: 'Name Of Menu Item',
                        hintStyle: inputTextStyle16(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(37, 40, 48, 1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'This is Permanent Menu',
                              textAlign: TextAlign.center,
                              style: inputTextStyle16(),
                            ),
                          ),
                          Transform.scale(
                            scale: 0.8,
                            child: CupertinoSwitch(
                                thumbColor: Colors.black,
                                activeColor: orangeColor(),
                                value: _switchValue,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _switchValue = value ?? false;
                                  });
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        step = 1;
                      });
                    },
                    child: SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                            shadowColor: Colors.black,
                            color: orangeColor(),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Proceed',
                                style: mTextStyle14(),
                              ),
                            ))),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
      //step 2
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Card(
          shadowColor: Colors.black,
          color: cardColor(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: SizedBox(
            height: 500,
            width: MediaQuery.of(context).size.width,
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Dishes in the menu',
                        style: mTextStyle18(),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddNewItem()),
                          );
                        },
                        child: Card(
                          shadowColor: Colors.black,
                          color: orangeColor(),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: SizedBox(
                            width: 100,
                            height: 35,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Add New',
                                  style: mTextStyle14(),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Lorem ipsum is simply dummy text of the printing and typesetting industry.',
                    style: cTextStyle12(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shadowColor: Colors.black,
                      color: inputColor(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Checkbox(
                                  value: _checkValue,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _checkValue = value ?? false;
                                    });
                                    Colors.black;
                                  },
                                  focusColor: orangeColor(),
                                  fillColor:
                                      MaterialStateProperty.all(orangeColor()),
                                  side: BorderSide(
                                    color: orangeColor(),
                                  ),
                                ),
                                Text(
                                  'Select All',
                                  style: inputTextStyle16(),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: Divider(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Checkbox(
                                  value: _checkValue,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _checkValue = value ?? false;
                                    });
                                    checkColor:
                                    Colors.black;
                                  },
                                  focusColor: orangeColor(),
                                  fillColor:
                                      MaterialStateProperty.all(orangeColor()),
                                  side: BorderSide(
                                    color: orangeColor(),
                                  ),
                                ),
                                Text(
                                  'Masala Tea \n ₹ 50',
                                  style: inputTextStyle16(),
                                ),
                                Stack(
                                  clipBehavior: Clip.none, children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.asset(
                                        './assets/images/tea.jpg',
                                        height: 60,
                                        width: 65,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Positioned(
                                      top: 45,
                                      right: 10,
                                      child: Card(
                                        shadowColor: Colors.black,
                                        color: orangeColor(),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: SizedBox(
                                          width: 40,
                                          height: 20,
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Edit',
                                                style: mTextStyle14(),
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Checkbox(
                                  value: _checkValue,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _checkValue = value ?? false;
                                    });
                                    checkColor:
                                    Colors.black;
                                  },
                                  focusColor: orangeColor(),
                                  fillColor:
                                      MaterialStateProperty.all(orangeColor()),
                                  side: BorderSide(
                                    color: orangeColor(),
                                  ),
                                ),
                                Text(
                                  'Special Tea \n ₹ 80',
                                  style: inputTextStyle16(),
                                ),
                                Stack(
                                  clipBehavior: Clip.none, children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.asset(
                                        './assets/images/tea.jpg',
                                        height: 60,
                                        width: 65,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Positioned(
                                      top: 45,
                                      right: 10,
                                      child: Card(
                                        shadowColor: Colors.black,
                                        color: orangeColor(),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: SizedBox(
                                          width: 40,
                                          height: 20,
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Edit',
                                                style: mTextStyle14(),
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        step = 2;
                      });
                    },
                    child: SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: orangeColor(),
                          ),
                          child: Center(
                            child: Text(
                              'Proceed',
                              style: mTextStyle14(),
                            ),
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      //step 3
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:10.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              // width: MediaQuery.of(context).size.width,
              child: Container(
                color: backgroundColor(),
                child: Image.asset('./assets/images/imagemenu/frame.png',),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Themes", style: mTextStyle20()),
                Padding(
                  padding: const EdgeInsets.only(right:10.0),
                  child: Row(
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
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: SizedBox(
              height: 110,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Card(
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child:
                        Image.asset('./assets/images/your menus/Breakfast.png'),
                  ),
                  Card(
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child:
                        Image.asset('./assets/images/your menus/Continental.png'),
                  ),
                  Card(
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child:
                        Image.asset('./assets/images/your menus/Grill Heaven.png'),
                  ),
                  Card(
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child:
                        Image.asset('./assets/images/your menus/Midnight Mojito.png'),
                  ),
                  Card(
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child:
                        Image.asset('./assets/images/your menus/Tandoori Tofu.png'),
                  ),
                  Card(
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child:
                        Image.asset('./assets/images/your menus/Veggie Blast.png'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ];

    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),

        title: Text(
          'Create New Image Menu',
          style: cardTitleStyle20(),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              "Create Image Menu",
              style: mTextStyle20(),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      width: MediaQuery.of(context).size.width * 0.28,
                      height: 45,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Step 1',
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
                      width: MediaQuery.of(context).size.width * 0.28,
                      height: 45,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Step 2',
                            style: mTextStyle16(),
                          )),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    setState(() {
                      step = 2;
                    });
                  },
                  child: Card(
                    shadowColor: Colors.black,
                    color: step == 2
                        ? orangeColor()
                        : const Color.fromRGBO(53, 56, 66, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.28,
                      height: 45,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Step 3',
                            style: mTextStyle16(),
                          )),
                    ),
                  ),
                ),

              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          widgetList[step],
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
