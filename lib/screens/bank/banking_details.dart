import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastesonway/screens/bank/bank_details.dart';
import 'package:tastesonway/screens/bank/upi_details.dart';
import 'package:tastesonway/utils/theme_data.dart';
import '../../apiServices/api_service.dart';
import '../../utils/sharedpreferences.dart';
import '../../utils/snackbar.dart';
import '../undermaintenance.dart';

class BankingDetails extends StatefulWidget {
  const BankingDetails({Key? key}) : super(key: key);

  @override
  State<BankingDetails> createState() => _BankingDetailsState();
}

class _BankingDetailsState extends State<BankingDetails> {
  bool isServicePresent = false;
  int id = 0;
  int defaultTransaction = 1;
  String upiId = "";
  String bankName = "";
  String bankHolderName = "";
  String bankAccNumber = "";
  String bankIfsc = "";
  int refreshCounter = 0;
  bool isNetbanking = false;
  bool isUPI = false;

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
      id = bankData['id'] == 0 ? '' : bankData['id'];
      upiId = bankData['upi_id'].toString() == "null" ? '' : bankData['upi_id'];
      bankName = bankData['bank_name'].toString() == "null"
          ? ''
          : bankData['bank_name'];
      bankHolderName = bankData['account_holder_name'].toString() == "null"
          ? ''
          : bankData['account_holder_name'];
      bankAccNumber = bankData['bank_acc_number'].toString() == "null"
          ? ''
          : bankData['bank_acc_number'];
      bankIfsc = bankData['bank_ifsc_code'].toString() == "null"
          ? ''
          : bankData['bank_ifsc_code'];
      defaultTransaction = bankData['transaction_type'];
      defaultTransaction == 1 ? isNetbanking = true : isUPI = true;
      print("defaultTransaction : $defaultTransaction");
      setState(() {});
    } else if (response.statusCode == 401) {
      final jsonData = json.decode(response.body);
      if (jsonData['message']
          .toString()
          .contains('maintenance')) {
        print('server is undermaintenance');
        setState(() {
          isServicePresent = true;
        });
      }
      else if(!isServicePresent) {
        print("refresh token called");
        if (refreshCounter == 0) {
          refreshCounter++;
          bool tokenRefreshed = await getNewToken(context);
          tokenRefreshed ? getBankDetails(): null;
        }
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future updateDefaultBankOption(id) async {
    String token = await Sharedprefrences.getToken();
    final response = await http.patch(
      Uri.parse("$baseUrl/update-transaction-type"),
      headers: {
        'Authorization': 'Bearer $token',
      },body: {
      "id":id.toString(),
      "transaction_type":isNetbanking?"1":"2",
    },
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      var message = jsonData['message'];
      ScaffoldSnackbar.of(context).show(message);
      setState(() {});
    } else if (response.statusCode == 401) {
      print("refresh token called");
      if (refreshCounter == 0) {
        refreshCounter++;
        bool tokenRefreshed = await getNewToken(context);
        tokenRefreshed ? updateDefaultBankOption(id):null;
      }
    } else {
      ScaffoldSnackbar.of(context).show("Something Went Wrong Please Try Again!");
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, "true");
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: UnderMaintenanceWidget(
        isShow: isServicePresent,
        callback: () async {
          await getBankDetails();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              const SizedBox(height: 25),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BankDetails(id, bankName,
                            bankHolderName, bankAccNumber, bankIfsc)),
                  ).then((value) {
                    if (value == "true") {
                      setState(() {
                        getBankDetails();
                      });
                    }
                  });
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            Checkbox(
                              value: isNetbanking,
                              onChanged: (value) {
                                updateDefaultBankOption(id);
                                setState(() {
                                  isUPI = false;
                                  isNetbanking = value!;
                                });
                              },
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
                              : "$bankAccNumber",
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
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UPIDetails(id, upiId)))
                      .then((value) {
                    if (value == "true") {
                      setState(() {
                        getBankDetails();
                      });
                    }
                  });
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            Checkbox(
                              value: isUPI,
                              onChanged: (value) {
                                updateDefaultBankOption(id);
                                setState(() {
                                  isNetbanking = false;
                                  isUPI = value!;
                                });
                              },
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
                          upiId == "" ? 'Bank Details' : "$upiId",
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
    );
  }
}
