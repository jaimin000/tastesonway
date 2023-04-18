import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:tastesonway/utils/theme_data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../../apiServices/api_service.dart';
import '../../utils/snackbar.dart';


class ContactUs extends StatelessWidget {
  ContactUs({Key? key}) : super(key: key);

  String message = "";

  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'tastesonway@gmail.com',
  );

  Future<String> getCallback() async {
    var token = await getToken();
    const url = "$baseUrl/create-request-callback";
    final tokenResponse = await http.post(Uri.parse(url),headers: {
      'Authorization': 'Bearer $token'
    },);
    final json = jsonDecode(tokenResponse.body);
    message = (json['message']).toString();
    return message;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),
        title: Text(
          'key_Contact_Us'.tr,
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
            InkWell(
              onTap: (){
                launchUrl(emailLaunchUri);
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        child: Image.asset(
                          './assets/images/profile/mail.png',
                          height: 40,
                          width: 40,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          'key_Email_Us'.tr,
                          style: mTextStyle18(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height:10),
            InkWell(
              onTap: () async {
                await getCallback();
                ScaffoldSnackbar.of(context).show(message.toString());
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        child: Image.asset(
                          './assets/images/profile/Contact Us.png',
                          height: 40,
                          width: 40,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          'key_Request_Callback'.tr,
                          style: mTextStyle18(),
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
