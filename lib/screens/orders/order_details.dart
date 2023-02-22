import 'package:flutter/material.dart';
import 'package:tastesonway/screens/profile.dart';
import '../../theme_data.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  int step = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetList = [
      //today
      Column(
        children: [
          SizedBox(
            child: Card(
              shadowColor: Colors.black,
              color: Color.fromRGBO(64, 68, 81, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Your Order',
                            style: mTextStyle16(),
                          ),
                          Text(
                            'Accepted',
                            style: cardTextStyle16(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Divider(
                      height: 20,
                      color:Colors.white,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Align(alignment: Alignment.centerLeft, child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7.0),
                      child: Text("Test Menu Items",style:cTextStyle16(),),
                    )),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '1 X ₹ 50',
                            style: cTextStyle16(),
                          ),
                          Text(
                            '₹ 50',
                            style: cTextStyle16(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Divider(
                      height: 20,
                      color:Colors.white,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Item Total',
                            style: cTextStyle16(),
                          ),
                          Text(
                            '₹ 50',
                            style: cTextStyle16(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Discount',
                            style: cTextStyle16(),
                          ),
                          Text(
                            '₹ 5',
                            style: cTextStyle16(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Divider(
                      thickness: 1,
                      height: 20,
                      color:orangeColor(),
                      indent: 10,
                      endIndent: 10,
                    ),
                    SizedBox(height: 5,),
                    Align(alignment: Alignment.centerLeft, child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("Order Details",style:mTextStyle16(),),
                    )),
                    SizedBox(height: 5,),
                    Divider(
                      height: 20,
                      color:Colors.white,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Order Number',
                            style: cTextStyle16(),
                          ),
                          Text(
                            '6141',
                            style: cTextStyle16(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Payment Type',
                            style: cTextStyle16(),
                          ),
                          Text(
                            'Bank',
                            style: cTextStyle16(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Date',
                            style: cTextStyle16(),
                          ),
                          Text(
                            '25th Nov,2022',
                            style: cTextStyle16(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Phone No.',
                            style: cTextStyle16(),
                          ),
                          Text(
                            '+91-123456789',
                            style: cTextStyle16(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Deliver To',
                            style: cTextStyle16(),
                          ),
                          SizedBox(
                            width:200,
                            child: Text(
                              '408, Shivalik Shilp Opp. Itc Narmada Vastrapur',
                              overflow: TextOverflow.ellipsis,
                              style: cTextStyle16(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),


                  ],
                ),
              ),
            ),
          ),
          SizedBox(height:25),
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
                      'Call to John (+91-123456789)',
                      style: mTextStyle14(),
                    ),
                  ))),
          SizedBox(height:25),
        ],
      ),
      //tomorrow
      Column(
        children: [
          SizedBox(
            child: Card(
              shadowColor: Colors.black,
              color: Color.fromRGBO(64, 68, 81, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Your Order',
                            style: mTextStyle16(),
                          ),
                          Text(
                            'Accepted',
                            style: cardTextStyle16(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Divider(
                      height: 20,
                      color:Colors.white,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Align(alignment: Alignment.centerLeft, child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7.0),
                      child: Text("Test Menu Items",style:cTextStyle16(),),
                    )),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '1 X ₹ 50',
                            style: cTextStyle16(),
                          ),
                          Text(
                            '₹ 50',
                            style: cTextStyle16(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Divider(
                      height: 20,
                      color:Colors.white,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Item Total',
                            style: cTextStyle16(),
                          ),
                          Text(
                            '₹ 50',
                            style: cTextStyle16(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Discount',
                            style: cTextStyle16(),
                          ),
                          Text(
                            '₹ 5',
                            style: cTextStyle16(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Divider(
                      thickness: 1,
                      height: 20,
                      color:orangeColor(),
                      indent: 10,
                      endIndent: 10,
                    ),
                    SizedBox(height: 5,),
                    Align(alignment: Alignment.centerLeft, child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("Order Details",style:mTextStyle16(),),
                    )),
                    SizedBox(height: 5,),
                    Divider(
                      height: 20,
                      color:Colors.white,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Order Number',
                            style: cTextStyle16(),
                          ),
                          Text(
                            '6141',
                            style: cTextStyle16(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Payment Type',
                            style: cTextStyle16(),
                          ),
                          Text(
                            'Bank',
                            style: cTextStyle16(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Date',
                            style: cTextStyle16(),
                          ),
                          Text(
                            '25th Nov,2022',
                            style: cTextStyle16(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Phone No.',
                            style: cTextStyle16(),
                          ),
                          Text(
                            '+91-123456789',
                            style: cTextStyle16(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Deliver To',
                            style: cTextStyle16(),
                          ),
                          SizedBox(
                            width:200,
                            child: Text(
                              '408, Shivalik Shilp Opp. Itc Narmada Vastrapur',
                              overflow: TextOverflow.ellipsis,
                              style: cTextStyle16(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),


                  ],
                ),
              ),
            ),
          ),
          SizedBox(height:25),
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
                      'Call to John (+91-123456789)',
                      style: mTextStyle14(),
                    ),
                  ))),
          SizedBox(height:25),
        ],
      ),
      //other
      Column(
        children: [
          SizedBox(
            child: Card(
              shadowColor: Colors.black,
              color: Color.fromRGBO(64, 68, 81, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Your Order',
                            style: mTextStyle16(),
                          ),
                          Text(
                            'Accepted',
                            style: cardTextStyle16(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Divider(
                      height: 20,
                      color:Colors.white,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Align(alignment: Alignment.centerLeft, child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7.0),
                      child: Text("Test Menu Items",style:cTextStyle16(),),
                    )),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '1 X ₹ 50',
                            style: cTextStyle16(),
                          ),
                          Text(
                            '₹ 50',
                            style: cTextStyle16(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Divider(
                      height: 20,
                      color:Colors.white,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Item Total',
                            style: cTextStyle16(),
                          ),
                          Text(
                            '₹ 50',
                            style: cTextStyle16(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Discount',
                            style: cTextStyle16(),
                          ),
                          Text(
                            '₹ 5',
                            style: cTextStyle16(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Divider(
                      thickness: 1,
                      height: 20,
                      color:orangeColor(),
                      indent: 10,
                      endIndent: 10,
                    ),
                    SizedBox(height: 5,),
                    Align(alignment: Alignment.centerLeft, child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("Order Details",style:mTextStyle16(),),
                    )),
                    SizedBox(height: 5,),
                    Divider(
                      height: 20,
                      color:Colors.white,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Order Number',
                            style: cTextStyle16(),
                          ),
                          Text(
                            '6141',
                            style: cTextStyle16(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Payment Type',
                            style: cTextStyle16(),
                          ),
                          Text(
                            'Bank',
                            style: cTextStyle16(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Date',
                            style: cTextStyle16(),
                          ),
                          Text(
                            '25th Nov,2022',
                            style: cTextStyle16(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Phone No.',
                            style: cTextStyle16(),
                          ),
                          Text(
                            '+91-123456789',
                            style: cTextStyle16(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Deliver To',
                            style: cTextStyle16(),
                          ),
                          SizedBox(
                            width:200,
                            child: Text(
                              '408, Shivalik Shilp Opp. Itc Narmada Vastrapur',
                              overflow: TextOverflow.ellipsis,
                              style: cTextStyle16(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),


                  ],
                ),
              ),
            ),
          ),
          SizedBox(height:25),
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
                      'Call to John (+91-123456789)',
                      style: mTextStyle14(),
                    ),
                  ))),
          SizedBox(height:25),
        ],
      ),
    ];
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),
        leading: IconButton(
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          'Order Details',
          style: cardTitleStyle20(),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            SizedBox(
              height: 25,
            ),
            Row(
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
                            'Today',
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
                            'Tomorrow',
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
                            'Other',
                            style: mTextStyle16(),
                          )),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            _widgetList[step],
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
