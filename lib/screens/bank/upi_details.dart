import 'dart:convert';
import 'package:flutter/material.dart';
 
import 'package:get/get.dart';
import 'package:tastesonway/screens/bank/banking_details.dart';
import 'package:tastesonway/utils/theme_data.dart';
import 'package:http/http.dart'as http;
import '../../apiServices/api_service.dart';
import '../../utils/sharedpreferences.dart';
import '../../utils/snackbar.dart';

class UPIDetails extends StatefulWidget {
  final id;
  final upiId;
  const UPIDetails(this.id,this.upiId);
  @override
  State<UPIDetails> createState() => _UPIDetailsState();
}

class _UPIDetailsState extends State<UPIDetails> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController upiIdController = TextEditingController();
  bool showDetails = false;

Future setUpi() async {
  isLoading = true;
  String token = await Sharedprefrences.getToken();
    final response = await http.post(
      Uri.parse("$baseUrl/add-or-update-kitchen-owner-bank-details"),
      headers: {'Authorization': 'Bearer $token'},
      body:{
        "id":"${widget.id}",
        "upi_id":upiIdController.text,
        "transaction_type":"2"
      }
    );
    if (response.statusCode == 200) {
      isLoading = false;
      final jsonData = json.decode(response.body);
      var profileData = jsonData['message'];
      debugPrint(profileData);
      ScaffoldSnackbar.of(context).show(profileData);
      setState(() {
      });
    } else {
      isLoading = false;
      print('Request failed with status: ${response.statusCode}.');
      ScaffoldSnackbar.of(context).show('Something Went Wrong Please try again!');
      setState(() {
      });
    }
  }

  @override
  void initState() {
    widget.upiId == ""?showDetails=false:showDetails=true;
    upiIdController.text = widget.upiId;
    super.initState();
  }

  @override
  void dispose() {
    upiIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showDetails = false;
              setState(() {
              });
            },
            icon: const Icon(Icons.edit),
          ),
        ],
        elevation: 0,
        backgroundColor: backgroundColor(),
        title: Text(
          'key_upi_id'.tr,
          style: cardTitleStyle20(),
        ),
      ),
      body: isLoading?
          Center(child: CircularProgressIndicator(color:orangeColor()),)
          :Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _formKey,
          child: Column(
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
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'key_Basic_Details'.tr,
                          style: mTextStyle18(),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          // height: 45,
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            obscureText: showDetails,
                            enabled: !showDetails,
                            controller: upiIdController,
                            style: const TextStyle(
                                color: Colors.white), //<-- SEE HERE
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10.0),
                              fillColor: inputColor(),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              hintText: 'key_upi_id'.tr,
                              hintStyle: inputTextStyle16(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'key_enter_your_upi_id'.tr;
                              } else if (!RegExp(r'^[\w\-\.]+@[\w\-\.]+$')
                                  .hasMatch(value)) {
                                return 'key_enter_your_valid_upi_id'.tr;
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: InkWell(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState?.save();
                                  isLoading=true;
                                  setState(() {
                                  });
                                  await setUpi();
                                  Get.off(() => const BankingDetails());
                                   return Future.value(true);
                                }
                              },
                              child: Card(
                                  shadowColor: Colors.black,
                                  color: orangeColor(),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Proceed',
                                      style: mTextStyle14(),
                                    ),
                                  )),
                            )),
                        const SizedBox(
                          height: 10,
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
