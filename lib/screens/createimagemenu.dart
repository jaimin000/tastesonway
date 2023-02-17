import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../themedata.dart';

class CreateImageMenu extends StatefulWidget {
  const CreateImageMenu({Key? key}) : super(key: key);

  @override
  State<CreateImageMenu> createState() => _CreateImageMenuState();
}

class _CreateImageMenuState extends State<CreateImageMenu> {
  bool _switchValue = true;
  int step = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetList = [
      //step 1
      Card(
        shadowColor: Colors.black,
        color: Color.fromRGBO(64, 68, 81, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: SizedBox(
          height: 250,
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Basic Details',
                  style: mTextStyle16(),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: SizedBox(
                    height: 45,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextField(
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        fillColor: Color.fromRGBO(37, 40, 48, 1),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
                        hintText: 'Name Your Menu',
                        hintStyle: inputTextStyle16(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Card(
                    shadowColor: Colors.black,
                    color: Color.fromRGBO(37, 40, 48, 1),
                    shape: RoundedRectangleBorder(
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
                            style: inputTextStyle16(),
                          ),
                        ),
                        Transform.scale(
                          scale: 0.8,
                          child: CupertinoSwitch(
                              thumbColor: Colors.black,
                              activeColor: orangeColor(),
                              value: _switchValue,
                              onChanged: null),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.9,
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
              ],
            ),
          ),
        ),
      ),
      //step 2
      Card(
        shadowColor: Colors.black,
        color: cardColor(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: SizedBox(
          height: 470,
          width: MediaQuery.of(context).size.width,
          child: Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dishes in the menu',
                      style: mTextStyle18(),
                    ),
                    Card(
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
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  'Lorem ipsum is simply dummy text of the printing and typesetting industry.',
                  style: cTextStyle12(),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: SizedBox(
                    height: 45,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.search,
                          color: orangeColor(),
                        ),
                        contentPadding: EdgeInsets.all(10.0),
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
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
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
                            children: [
                              Checkbox(
                                value: false,
                                onChanged: null,
                                checkColor: Colors.black,
                                focusColor: orangeColor(),
                                fillColor:
                                    MaterialStateProperty.all(orangeColor()),
                                side: BorderSide(
                                  color: orangeColor(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Select All',
                                  style: inputTextStyle16(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                                value: false,
                                onChanged: null,
                                checkColor: Colors.black,
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
                                overflow: Overflow.visible,
                                children: [
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
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Checkbox(
                                value: false,
                                onChanged: null,
                                checkColor: Colors.black,
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
                                overflow: Overflow.visible,
                                children: [
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
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.9,
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
              ],
            ),
          ),
        ),
      ),
      //step 3
      Column(
        children: [
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
                padding: EdgeInsets.symmetric(horizontal: 10),
                margin: EdgeInsets.all(10),
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
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
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
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
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
          // SizedBox(
          //   height: 10,
          // ),
          SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: Card(
              shadowColor: Colors.black,
              color: orangeColor(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.share),
                    Text(
                      'Whatsapp',
                      style: mTextStyle14(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ];

    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        backgroundColor: backgroundColor(),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            // setState(() {
            //   step != 0 ? step-- : null;
            // });
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          'Create New Image Menu',
          style: cardTitleStyle20(),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(7),
        padding: EdgeInsets.all(7),
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Create Image Menu",
                style: mTextStyle20(),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                        : Color.fromRGBO(53, 56, 66, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: SizedBox(
                      width: 100,
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
                SizedBox(
                  width: 5,
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
                        : Color.fromRGBO(53, 56, 66, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: SizedBox(
                      width: 100,
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
                SizedBox(
                  width: 5,
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
                        : Color.fromRGBO(53, 56, 66, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: SizedBox(
                      width: 100,
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
                SizedBox(
                  width: 5,
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            _widgetList[step],
          ],
        ),
      ),
    );
  }
}
