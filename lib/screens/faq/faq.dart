import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
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
          'key_FAQ'.tr,
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

                      title: Text('key_Can_the_Tastes_on_Way_app_be_used_anywhere_in_India'.tr,style: inputTextStyle18(),),
                      children: <Widget>[
                        ListTile(title: Text('key_Yes_Tastes_on_Way_app_can_be_used_anywhere_in_india'.tr,style: inputTextStyle16(),)),
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

                      title: Text('key_Do_I_have_to_pay_any_registration_or_subscription_fees'.tr,style: inputTextStyle18(),),
                      children: <Widget>[
                        ListTile(title: Text('key_No_this_app_is_free_to_use'.tr,style: inputTextStyle16(),)),
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

                      title: Text('key_Does_the_Tastes_on_Way_app_offer_a_delivery_service'.tr,style: inputTextStyle18(),),
                      children: <Widget>[
                        ListTile(title: Text('key_No_Tastes_on_Way_does_not_offer_a_delivery_service'.tr,style: inputTextStyle16(),)),
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

                      title: Text('key_Can_buyers_use_the_Tastes_on_Way_app_and_view_the_menu'.tr,style: inputTextStyle18(),),
                      children: <Widget>[
                        ListTile(title: Text('key_No_the_Tastes_on_Way_app_is_only_for_the_chef'.tr,style: inputTextStyle16(),)),
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

                      title: Text('key_Does_the_Tastes_on_Way_app_help_me_find_more_buyers'.tr,style: inputTextStyle18(),),
                      children: <Widget>[
                        ListTile(title: Text('key_No_The_Tastes_on_Way_app_helps_you'.tr,style: inputTextStyle16(),)),
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

                      title: Text('key_Can_the_app_be_used_by_any_kind_of_food_business'.tr,style: inputTextStyle18(),),
                      children: <Widget>[
                        ListTile(title: Text('key_Yes_the_can_be_used_by_all_busineesses_that_sell_food'.tr,style: inputTextStyle16(),)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
