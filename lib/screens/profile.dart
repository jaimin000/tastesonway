import 'package:flutter/material.dart';
import 'package:tastesonway/themedata.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  overflow: Overflow.visible,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              './assets/images/profile/image 28.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      width: 312.58,
                      height: 189.19,
                      //margin: EdgeInsets.only(left: 82.87, top: 55.24),
                    ),
                    Positioned(
                      child: Container(
                        width: 1003.91,
                        height: 1037.91,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(39, 42, 50, 1),
                          shape: BoxShape.circle,
                        ),
                      ),
                      left: -380,
                      top: 150.78,
                    ),
                    Positioned(
                      top: 70,
                      right: 70,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
                        radius: 80,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Text(
            'Shania Fraser (ENG)',
            textAlign: TextAlign.center,
            style: mTextStyle20(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Lorem ipsum is simply dummy text of the printing and typesetting industry.',
              textAlign: TextAlign.center,
              style: cTextStyle12(),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.star_border,
                      color: fontColor(),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('4.8(163)', style: cTextStyle12())
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.timer_sharp,
                      color: fontColor(),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('20 min', style: cTextStyle12())
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.local_fire_department_outlined,
                      color: fontColor(),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('150 kcal', style: cTextStyle12())
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 1150,
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              shrinkWrap: true,
              children: [
                Card(
                  shadowColor: Colors.black,
                  color: Color.fromRGBO(53, 56, 66, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: SizedBox(
                      width: 140,
                      height: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset('./assets/images/profile/Coupon.png'),
                          Text(
                            'Create Discount Coupon',
                            textAlign: TextAlign.center,
                            style: cTextStyle16(),
                          )
                        ],
                      )),
                ),
                Card(
                  shadowColor: Colors.black,
                  color: Color.fromRGBO(53, 56, 66, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: SizedBox(
                      width: 140,
                      height: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset('./assets/images/profile/Website.png'),
                          Text(
                            'My Website',
                            textAlign: TextAlign.center,
                            style: cTextStyle16(),
                          )
                        ],
                      )),
                ),
                Card(
                  shadowColor: Colors.black,
                  color: Color.fromRGBO(53, 56, 66, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: SizedBox(
                      width: 140,
                      height: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset('./assets/images/profile/Fssai.png'),
                          Text(
                            'Fssai Registration',
                            textAlign: TextAlign.center,
                            style: cTextStyle16(),
                          )
                        ],
                      )),
                ),
                Card(
                  shadowColor: Colors.black,
                  color: Color.fromRGBO(53, 56, 66, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: SizedBox(
                      width: 140,
                      height: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                              './assets/images/profile/Bank Details.png'),
                          Text(
                            'Bank Details',
                            textAlign: TextAlign.center,
                            style: cTextStyle16(),
                          )
                        ],
                      )),
                ),
                Card(
                  shadowColor: Colors.black,
                  color: Color.fromRGBO(53, 56, 66, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: SizedBox(
                      width: 140,
                      height: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                              './assets/images/profile/Your Orders.png'),
                          Text(
                            'Your Orders',
                            textAlign: TextAlign.center,
                            style: cTextStyle16(),
                          )
                        ],
                      )),
                ),
                Card(
                  shadowColor: Colors.black,
                  color: Color.fromRGBO(53, 56, 66, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: SizedBox(
                      width: 140,
                      height: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset('./assets/images/profile/Menu Items.png'),
                          Text(
                            'Menu Items',
                            textAlign: TextAlign.center,
                            style: cTextStyle16(),
                          )
                        ],
                      )),
                ),
                Card(
                  shadowColor: Colors.black,
                  color: Color.fromRGBO(53, 56, 66, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: SizedBox(
                      width: 140,
                      height: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                              './assets/images/profile/My Menu Design.png'),
                          Text(
                            'My Menu Design',
                            textAlign: TextAlign.center,
                            style: cTextStyle16(),
                          )
                        ],
                      )),
                ),
                Card(
                  shadowColor: Colors.black,
                  color: Color.fromRGBO(53, 56, 66, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: SizedBox(
                      width: 140,
                      height: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                              './assets/images/profile/VideoTutorials.png'),
                          Text(
                            'Video Tutorials',
                            textAlign: TextAlign.center,
                            style: cTextStyle16(),
                          )
                        ],
                      )),
                ),
                Card(
                  shadowColor: Colors.black,
                  color: Color.fromRGBO(53, 56, 66, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: SizedBox(
                      width: 140,
                      height: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                              './assets/images/profile/Shares Taste on Way.png'),
                          Text(
                            'Share Tastes On Way',
                            textAlign: TextAlign.center,
                            style: cTextStyle16(),
                          )
                        ],
                      )),
                ),
                Card(
                  shadowColor: Colors.black,
                  color: Color.fromRGBO(53, 56, 66, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: SizedBox(
                      width: 140,
                      height: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset('./assets/images/profile/Contact Us.png'),
                          Text(
                            'Contact Us',
                            textAlign: TextAlign.center,
                            style: cTextStyle16(),
                          )
                        ],
                      )),
                ),
                Card(
                  shadowColor: Colors.black,
                  color: Color.fromRGBO(53, 56, 66, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: SizedBox(
                      width: 140,
                      height: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset('./assets/images/profile/FAQ.png'),
                          Text(
                            'FAQ',
                            textAlign: TextAlign.center,
                            style: cTextStyle16(),
                          )
                        ],
                      )),
                ),
                Card(
                  shadowColor: Colors.black,
                  color: Color.fromRGBO(53, 56, 66, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: SizedBox(
                      width: 140,
                      height: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset('./assets/images/profile/Settings.png'),
                          Text(
                            'Settings',
                            textAlign: TextAlign.center,
                            style: cTextStyle16(),
                          )
                        ],
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
