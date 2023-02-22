import 'package:flutter/material.dart';
import 'package:tastesonway/theme_data.dart';

class PaymentReceived extends StatelessWidget {
  const PaymentReceived({Key? key}) : super(key: key);

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
          'Payment Received',
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
            Card(
              shadowColor: Colors.black,
              color: cardColor(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Basic Details',
                          style: mTextStyle18(),
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          shadowColor: Colors.black,
                          color: Color.fromRGBO(37, 40, 48, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            height: 30,
                            margin: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    '5th Dec 2022',
                                    style: cTextStyle16(),
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                                Text(
                                  '1 Order',
                                  style: cTextStyle16(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        height: 30,
                        indent: 10,
                        endIndent: 10,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          shadowColor: Colors.black,
                          color: Color.fromRGBO(37, 40, 48, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
                                  radius: 40,
                                ),
                                Text(
                                  'John Doe',
                                  style: cardTextStyle18(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height:10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          shadowColor: Colors.black,
                          color: Color.fromRGBO(37, 40, 48, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            height: 30,
                            margin: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Payment Status',
                                  style: cTextStyle16(),
                                ),
                                Flexible(
                                  child: Text(
                                    'Received',
                                    style: cardTextStyle16(),
                                    overflow: TextOverflow.clip,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height:10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          shadowColor: Colors.black,
                          color: Color.fromRGBO(37, 40, 48, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            height: 110,
                            margin: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Delivery Address',
                                  style: cTextStyle16(),
                                ),
                                Flexible(
                                  child: Text(
                                    '1002, Shivalik Abaise, Opp. Venus Atlantis, Anand nagar road, Ahmedabad  Gujarat.',
                                    style: cTextStyle14(),
                                    overflow: TextOverflow.clip,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height:10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          shadowColor: Colors.black,
                          color: Color.fromRGBO(37, 40, 48, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            height: 30,
                            margin: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,                              children: [
                              Text(
                                'Delivery Time',
                                style: cTextStyle16(),
                              ),
                              Flexible(
                                child: Text(
                                  '5th Dec 2022, 14:42',
                                  style: cTextStyle16(),
                                  overflow: TextOverflow.clip,
                                ),
                              ),

                            ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height:10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          shadowColor: Colors.black,
                          color: Color.fromRGBO(37, 40, 48, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            height: 30,
                            margin: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,                              children: [
                              Flexible(
                                child: Text(
                                  'Order Amount',
                                  style: cTextStyle16(),
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                              Text(
                                '₹ 75',
                                style: cTextStyle16(),
                              ),
                            ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height:10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          shadowColor: Colors.black,
                          color: Color.fromRGBO(37, 40, 48, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            height: 30,
                            margin: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,                              children: [
                              Flexible(
                                child: Text(
                                  'Tax & Charges',
                                  style: cTextStyle16(),
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                              Text(
                                '₹ 25',
                                style: cTextStyle16(),
                              ),
                            ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height:10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          shadowColor: Colors.black,
                          color: Color.fromRGBO(37, 40, 48, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            height: 30,
                            margin: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,                              children: [
                              Flexible(
                                child: Text(
                                  'Total Amount',
                                  style: cTextStyle16(),
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                              Text(
                                '₹ 100',
                                style: cTextStyle16(),
                              ),
                            ],
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
      ),
    );
  }
}
