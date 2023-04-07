import 'package:flutter/material.dart';
import 'package:tastesonway/utils/theme_data.dart';

class PaymentReceived extends StatelessWidget {
  const PaymentReceived({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),

        title: Text(
          'Payment Received',
          style: cardTitleStyle20(),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            const SizedBox(
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
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
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
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          shadowColor: Colors.black,
                          color: const Color.fromRGBO(37, 40, 48, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            height: 30,
                            margin: const EdgeInsets.all(10),
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
                      const Divider(
                        height: 30,
                        indent: 10,
                        endIndent: 10,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          shadowColor: Colors.black,
                          color: const Color.fromRGBO(37, 40, 48, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const CircleAvatar(
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
                      const SizedBox(height:10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          shadowColor: Colors.black,
                          // ignore: prefer_const_constructors
                          color: Color.fromRGBO(37, 40, 48, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            height: 30,
                            margin: const EdgeInsets.all(10),
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
                      const SizedBox(height:10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          shadowColor: Colors.black,
                          color: const Color.fromRGBO(37, 40, 48, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            height: 110,
                            margin: const EdgeInsets.all(10),
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
                      const SizedBox(height:10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          shadowColor: Colors.black,
                          color: const Color.fromRGBO(37, 40, 48, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            height: 30,
                            margin: const EdgeInsets.all(10),
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
                      const SizedBox(height:10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          shadowColor: Colors.black,
                          color: const Color.fromRGBO(37, 40, 48, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            height: 30,
                            margin: const EdgeInsets.all(10),
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
                      const SizedBox(height:10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          shadowColor: Colors.black,
                          color: const Color.fromRGBO(37, 40, 48, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            height: 30,
                            margin: const EdgeInsets.all(10),
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
                      const SizedBox(height:10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          shadowColor: Colors.black,
                          color: const Color.fromRGBO(37, 40, 48, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            height: 30,
                            margin: const EdgeInsets.all(10),
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
