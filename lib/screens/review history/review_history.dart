import 'package:flutter/material.dart';
import 'package:tastesonway/theme_data.dart';

class ReviewHistory extends StatelessWidget {
  const ReviewHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),
        title: Text(
          'Review History',
          style: cardTitleStyle20(),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            SizedBox(
              height: 25,
            ),
            Column(
              children: [
                SizedBox(height: 25,),
                SizedBox(
                  child: Card(
                    shadowColor: Colors.black,
                    color: Color.fromRGBO(64, 68, 81, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height:10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'In Review',
                                style: mTextStyle16(),
                              ),
                              Icon(Icons.delete_rounded,color: orangeColor(),),
                            ],
                          ),
                          SizedBox(height:5),
                          Text(
                            'Your Menu Changes is in Review',
                            style: cTextStyle16(),
                          ),
                          SizedBox(height:5),
                          Divider(
                            height: 20,
                            color: Colors.white,
                            endIndent: 5,
                            indent: 5,
                          ),
                          SizedBox(height:5),
                          Text(
                            'You have changed Menu Details, our team will Review it and get back to you!',
                            style: cTextStyle16(),
                          ),
                          SizedBox(height:10),

                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                SizedBox(
                  child: Card(
                    shadowColor: Colors.black,
                    color: Color.fromRGBO(64, 68, 81, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height:10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'In Review',
                                style: mTextStyle16(),
                              ),
                              Icon(Icons.delete_rounded,color: orangeColor(),),
                            ],
                          ),
                          SizedBox(height:5),
                          Text(
                            'Your Menu Changes is in Review',
                            style: cTextStyle16(),
                          ),
                          SizedBox(height:5),
                          Divider(
                            height: 20,
                            color: Colors.white,
                            endIndent: 5,
                            indent: 5,
                          ),
                          SizedBox(height:5),
                          Text(
                            'You have changed Menu Details, our team will Review it and get back to you!',
                            style: cTextStyle16(),
                          ),
                          SizedBox(height:10),

                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                SizedBox(
                  child: Card(
                    shadowColor: Colors.black,
                    color: Color.fromRGBO(64, 68, 81, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height:10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'In Review',
                                style: mTextStyle16(),
                              ),
                              Icon(Icons.delete_rounded,color: orangeColor(),),
                            ],
                          ),
                          SizedBox(height:5),
                          Text(
                            'Your Menu Changes is in Review',
                            style: cTextStyle16(),
                          ),
                          SizedBox(height:5),
                          Divider(
                            height: 20,
                            color: Colors.white,
                            endIndent: 5,
                            indent: 5,
                          ),
                          SizedBox(height:5),
                          Text(
                            'You have changed Menu Details, our team will Review it and get back to you!',
                            style: cTextStyle16(),
                          ),
                          SizedBox(height:10),

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
