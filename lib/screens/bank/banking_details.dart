import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastesonway/screens/bank/bank_details.dart';
import 'package:tastesonway/screens/bank/upi_details.dart';
import 'package:tastesonway/utils/theme_data.dart';
import '../../apiServices/api_service.dart';
import '../../utils/sharedpreferences.dart';

class BankingDetails extends StatefulWidget {
  const BankingDetails({Key? key}) : super(key: key);

  @override
  State<BankingDetails> createState() => _BankingDetailsState();
}

class _BankingDetailsState extends State<BankingDetails> {
  int id = 0;
  String upiId = "";
  String bankName = "";
  String bankHolderName = "";
  String bankAccNumber = "";
  String bankIfsc = "";

  Future getBankDetails() async {
    String token = await Sharedprefrences.getToken();
    final response = await http.get(
      Uri.parse("$baseUrl/get-kitchen-owner-bank-detail"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      var bankData = jsonData['data'][0];
      id = bankData['id']== 0 ?'':bankData['id'];
      upiId = bankData['upi_id'].toString()=="null"?'':bankData['upi_id'];
      bankName =
          bankData['bank_name'].toString()=="null" ? '' : bankData['bank_name'];
      bankHolderName = bankData['account_holder_name'].toString()=="null"
          ? ''
          : bankData['account_holder_name'];
      bankAccNumber = bankData['bank_acc_number'].toString()=="null"
          ? ''
          : bankData['bank_acc_number'];
      bankIfsc = bankData['bank_ifsc_code'].toString()=="null"
          ? ''
          : bankData['bank_ifsc_code'];
      print(id);
      setState(() {});
    }
    else if(response.statusCode == 401) {
      print("refresh token called");
      getNewToken(context);
      getBankDetails();
    }else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void initState() {
    getBankDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),
        title: Text(
          'key_Bank_Details'.tr,
          style: cardTitleStyle20(),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            const SizedBox(height: 25),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BankDetails(
                         id,bankName, bankHolderName, bankAccNumber, bankIfsc)),
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
                              'key_net_banking'.tr,
                              style: mTextStyle20(),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.white,
                        height: 25,
                        indent: 5,
                        endIndent: 5,
                      ),
                      Text(
                        bankAccNumber == ""
                            ? 'Bank Details'
                            : "$bankAccNumber  ✅",
                        style: cTextStyle16(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UPIDetails(id,upiId)));
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
                              'key_upi_id'.tr,
                              style: mTextStyle20(),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.white,
                        height: 25,
                        indent: 5,
                        endIndent: 5,
                      ),
                      Text(
                        upiId == ""
                            ? 'Bank Details'
                            : "$upiId  ✅",
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
