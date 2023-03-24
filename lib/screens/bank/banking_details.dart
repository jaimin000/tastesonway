import 'package:flutter/material.dart';
import 'package:tastesonway/screens/bank/bank_details.dart';
import 'package:tastesonway/screens/bank/upi_details.dart';
import 'package:tastesonway/theme_data.dart';

class BankingDetails extends StatelessWidget {
  const BankingDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),

        title: Text(
          'Bank Details',
          style: cardTitleStyle20(),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [

            const SizedBox(height:25),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BankDetails()),
                );
              },
              child: Card(
                shadowColor: Colors.black,
                color: cardColor(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              './assets/images/profile/Bank Details.png',
                              height: 60,
                              width: 60,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              'Net Banking',
                              style: mTextStyle20(),
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.white,
                        height:25,
                        indent: 5,
                        endIndent: 5,
                      ),
                      Text(
                        'lorem ipsum',
                        style: cTextStyle16(),
                      ),

                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height:10),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UPIDetails()),
                );
              },
              child: Card(
                shadowColor: Colors.black,
                color: cardColor(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              './assets/images/profile/upi.png',
                              color: orangeColor(),
                              height: 60,
                              width: 60,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              'UPI',
                              style: mTextStyle20(),
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.white,
                        height:25,
                        indent: 5,
                        endIndent: 5,
                      ),
                      Text(
                        'lorem ipsum ',
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
    );
  }
}
