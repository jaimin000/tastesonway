import 'package:flutter/material.dart';
import 'package:tastesonway/theme_data.dart';

class FAQ extends StatelessWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),
        leading: IconButton(
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          'FAQ',
          style: cardTitleStyle20(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(37, 40, 48, 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all( 15.0),
                    child: ExpansionTile(
                      collapsedIconColor: orangeColor(),
                      iconColor: orangeColor(),

                      title: Text('Can We Use Tastes on way Anywhere in India ?',style: inputTextStyle18(),),
                      children: <Widget>[
                        ListTile(title: Text('Yes, We can use Tastes on way Anywhere in India',style: inputTextStyle16(),)),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(37, 40, 48, 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all( 15.0),
                    child: ExpansionTile(
                      collapsedIconColor: orangeColor(),
                      iconColor: orangeColor(),

                      title: Text('Do i need to pay any registration or Subscription fees ?',style: inputTextStyle18(),),
                      children: <Widget>[
                        ListTile(title: Text('Yes, We can use Tastes on way Anywhere in India',style: inputTextStyle16(),)),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(37, 40, 48, 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all( 15.0),
                    child: ExpansionTile(
                      collapsedIconColor: orangeColor(),
                      iconColor: orangeColor(),

                      title: Text('Does Tastes on way offers Delivery Services ?',style: inputTextStyle18(),),
                      children: <Widget>[
                        ListTile(title: Text('Yes, We can use Tastes on way Anywhere in India',style: inputTextStyle16(),)),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(37, 40, 48, 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all( 15.0),
                    child: ExpansionTile(
                      collapsedIconColor: orangeColor(),
                      iconColor: orangeColor(),

                      title: Text('Can Buyers use the app and View Menu ?',style: inputTextStyle18(),),
                      children: <Widget>[
                        ListTile(title: Text('Yes, We can use Tastes on way Anywhere in India',style: inputTextStyle16(),)),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(37, 40, 48, 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all( 15.0),
                    child: ExpansionTile(
                      collapsedIconColor: orangeColor(),
                      iconColor: orangeColor(),

                      title: Text('Does this App help me to find more Buyers from my locality ?',style: inputTextStyle18(),),
                      children: <Widget>[
                        ListTile(title: Text('Yes, We can use Tastes on way Anywhere in India',style: inputTextStyle16(),)),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );

  }
}
