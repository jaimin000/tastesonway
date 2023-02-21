import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../theme_data.dart';

class EditItem extends StatefulWidget {
  const EditItem({Key? key}) : super(key: key);

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  bool _switchValue = false;
  int step = 1;

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
            // setState(() {
            //   step != 0 ? step-- : null;
            // });
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          'Edit Item',
          style: cardTitleStyle20(),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Create Text Menu",
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
                SizedBox(
                  width: 5,
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Card(
              shadowColor: Colors.black,
              color: cardColor(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: SizedBox(
                height: 640,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Basic Details',
                        style: mTextStyle18(),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Lorem ipsum is simply dummy text of the printing and typesetting industry.',
                        style: cTextStyle12(),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          style: TextStyle(color: Colors.white), //<-- SEE HERE

                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
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
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          style: TextStyle(color: Colors.white), //<-- SEE HERE

                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            fillColor: inputColor(),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            hintText: 'Price Per Serving',
                            hintStyle: inputTextStyle16(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          style: TextStyle(color: Colors.white), //<-- SEE HERE

                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.ios_share,
                              color: orangeColor(),
                            ),
                            contentPadding: EdgeInsets.all(10.0),
                            fillColor: inputColor(),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            hintText: 'Upload Image',
                            hintStyle: inputTextStyle16(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(37, 40, 48, 1),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Type Of Dish Veg',
                                  textAlign: TextAlign.center,
                                  style: inputTextStyle16(),
                                ),
                              ),
                              Transform.scale(
                                scale: 0.8,
                                child: CupertinoSwitch(
                                    thumbColor: Colors.black,
                                    activeColor: Colors.green,
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
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 90,
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          style: TextStyle(color: Colors.white), //<-- SEE HERE

                          minLines: 3,
                          maxLines: 5,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            fillColor: inputColor(),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            hintText: 'Add Dish Description',
                            hintStyle: inputTextStyle16(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Extra Toppings',
                        style: mTextStyle18(),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: TextField(
                              style:
                                  TextStyle(color: Colors.white), //<-- SEE HERE

                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.0),
                                fillColor: inputColor(),
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                                hintText: 'Name',
                                hintStyle: inputTextStyle16(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: TextField(
                              style:
                                  TextStyle(color: Colors.white), //<-- SEE HERE

                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.0),
                                fillColor: inputColor(),
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                                hintText: 'Price',
                                hintStyle: inputTextStyle16(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromRGBO(37, 40, 48, 1),
                              ),
                              child: Center(
                                child: Text(
                                  "+",
                                  style: inputTextStyle16(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      SizedBox(
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
                      SizedBox(
                        height: 10,
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
