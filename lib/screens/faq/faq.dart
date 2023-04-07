import 'package:flutter/material.dart';
import 'package:tastesonway/utils/theme_data.dart';

class FAQ extends StatelessWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),

        title: Text(
          'FAQ',
          style: cardTitleStyle20(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(37, 40, 48, 1),
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
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(37, 40, 48, 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all( 15.0),
                    child: ExpansionTile(
                      collapsedIconColor: orangeColor(),
                      iconColor: orangeColor(),

                      title: Text('Do i need to pay any registration or subscription fees ?',style: inputTextStyle18(),),
                      children: <Widget>[
                        ListTile(title: Text('No, this app is free to use. You don\'t have to pay any registration or subscription fees ',style: inputTextStyle16(),)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(37, 40, 48, 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all( 15.0),
                    child: ExpansionTile(
                      collapsedIconColor: orangeColor(),
                      iconColor: orangeColor(),

                      title: Text('Does Tastes on way offers Delivery Services ?',style: inputTextStyle18(),),
                      children: <Widget>[
                        ListTile(title: Text('No, Tastes on way does not offer a delivery service',style: inputTextStyle16(),)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(37, 40, 48, 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all( 15.0),
                    child: ExpansionTile(
                      collapsedIconColor: orangeColor(),
                      iconColor: orangeColor(),

                      title: Text('Can Buyers use the app and View Menu ?',style: inputTextStyle18(),),
                      children: <Widget>[
                        ListTile(title: Text('No, the Tastes on way app is only for the chef or the food business owner to manage their food business',style: inputTextStyle16(),)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(37, 40, 48, 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all( 15.0),
                    child: ExpansionTile(
                      collapsedIconColor: orangeColor(),
                      iconColor: orangeColor(),

                      title: Text('Does this App help me to find more Buyers from my locality ?',style: inputTextStyle18(),),
                      children: <Widget>[
                        ListTile(title: Text('No, the Tastes on way app helps you manage your existing food business more efficiently. you can track all your orders in place, send payment reminders to buyers and automatically view your monthly sales and profit. you can also create beautiful menus and share them on chat and social media',style: inputTextStyle16(),)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );

  }
}
