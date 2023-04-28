import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tastesonway/utils/theme_data.dart';
import 'package:http/http.dart' as http;
import '../../apiServices/api_service.dart';
import '../../utils/sharedpreferences.dart';
import 'dart:convert';
import '../../utils/snackbar.dart';
import 'banking_details.dart';

class BankDetails extends StatefulWidget {
  int id;
  String bankName;
  String bankHolderName;
  String bankAccNumber;
  String bankIfsc;

  BankDetails(
      this.id,this.bankName, this.bankHolderName, this.bankAccNumber, this.bankIfsc);
  @override
  State<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  bool isLoading = true;
  String _searchTerm = '';
  bool showDetails = false;
  final _formKey = GlobalKey<FormState>();
  List<String> bankList = [];
  List<String> _suggestions = [];
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController accNumController = TextEditingController();
  final TextEditingController confirmAccNumController = TextEditingController();
  final TextEditingController ifscController = TextEditingController();

  Future setBankDetails() async {
    String token = await Sharedprefrences.getToken();
    final response = await http.post(
        Uri.parse("$baseUrl/add-or-update-kitchen-owner-bank-details"),
        headers: {
          'Authorization': 'Bearer $token'
        },
        body: {
          "id":"${widget.id}",
          "bank_acc_number": "${accNumController.text}",
          "bank_name": "${bankNameController.text}",
          "account_holder_name": "${nameController.text}",
          "bank_ifsc_code": "${ifscController.text}",
          "transaction_type": "1"
        });
    if (response.statusCode == 200) {
      isLoading = false;
      final jsonData = json.decode(response.body);
      var profileData = jsonData['message'];
      debugPrint(profileData);
      ScaffoldSnackbar.of(context).show(profileData);
      setState(() {});
    } else {
      isLoading=false;
      print('Request failed with status: ${response.statusCode}.');
      ScaffoldSnackbar.of(context)
          .show('Something Went Wrong Please try again!');
      setState(() {

      });
    }
  }

  Future getBanks() async {
    String token = await Sharedprefrences.getToken();
    final response = await http.get(
      Uri.parse("$baseUrl/get-banks"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      isLoading= false;
      final jsonData = json.decode(response.body);
      var banks = jsonData['data'] as List;
      if (banks.isNotEmpty) {
        for (var i = 0; i < banks.length; i++) {
          bankList.add(banks[i]['bank_name'].toString());
        }
        print(bankList);
        setState(() {});
      }
    } else {
      isLoading=false;
      print('Request failed with status: ${response.statusCode}.');
      setState(() {
      });
    }
  }

  @override
  void initState() {
    widget.bankAccNumber=="" ? showDetails = false : showDetails = true;
    bankNameController.text = widget.bankName;
    nameController.text = widget.bankHolderName;
    accNumController.text = widget.bankAccNumber;
    confirmAccNumController.text = widget.bankAccNumber;
    ifscController.text = widget.bankIfsc;
    getBanks();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    accNumController.dispose();
    confirmAccNumController.dispose();
    ifscController.dispose();
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
              setState(() {});
            },
            icon: const Icon(Icons.edit),
          ),
        ],
        elevation: 0,
        backgroundColor: backgroundColor(),
        title: Text(
          'key_Bank_Details'.tr,
          style: cardTitleStyle20(),
        ),
      ),
      body: isLoading?
          Center(child: SpinKitFadingCircle(color: orangeColor(),))
          :Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _formKey,
          child: ListView(
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
                        Column(
                          children: [
                            SizedBox(
                              height: 45,
                              width: MediaQuery.of(context).size.width,
                              child: TextFormField(
                                enabled: !showDetails,
                                controller: bankNameController,
                                onChanged: (value) async {
                                  setState(() {
                                    _searchTerm = value.toUpperCase();
                                  });
                                  List<String> filteredData = bankList
                                      .where(
                                          (item) => item.contains(_searchTerm))
                                      .toList();
                                  setState(() {
                                    _suggestions = filteredData;
                                  });
                                },
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
                                  hintText: 'key_Bank_Name'.tr,
                                  hintStyle: inputTextStyle16(),
                                ),
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: _suggestions.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  title: Text(_suggestions[index]),
                                  onTap: () {
                                    setState(() {
                                      bankNameController.text =
                                          _suggestions[index];
                                    });
                                    debugPrint(_suggestions[index]);
                                    // Clear suggestions
                                    setState(() {
                                      _suggestions = [];
                                    });
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            obscureText: showDetails,
                            enabled: !showDetails,
                            controller: nameController,
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
                              hintText: 'key_Bank_Holder_Name'.tr,
                              hintStyle: inputTextStyle16(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'key_Please_Enter_Bank_Holder_Name'.tr;
                              } else if (!RegExp('[a-zA-Z]').hasMatch(value)) {
                                return 'key_Please_Enter_Bank_Holder_Name'.tr;
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            obscureText: showDetails,
                            enabled: !showDetails,
                            controller: accNumController,
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
                              hintText: 'key_Bank_Account_Number'.tr,
                              hintStyle: inputTextStyle16(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'key_Please_Enter_Bank_Account_Number'
                                    .tr;
                              } else if (!RegExp(r'^\d{9,18}$')
                                  .hasMatch(value)) {
                                return 'key_Please_Enter_Bank_Account_Number'
                                    .tr;
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            obscureText: showDetails,
                            enabled: !showDetails,
                            controller: confirmAccNumController,
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
                              hintText: 'key_Re_enter_Bank_Account_Number'.tr,
                              hintStyle: inputTextStyle16(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'key_Please_Enter_Bank_Account_Number'
                                    .tr;
                              } else if (accNumController.text != value) {
                                return 'key_Bank_Account_Number_must_be_same'
                                    .tr;
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            textCapitalization: TextCapitalization.characters,
                            obscureText: showDetails,
                            enabled: !showDetails,
                            controller: ifscController,
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
                              hintText: 'key_ifsc_code'.tr,
                              hintStyle: inputTextStyle16(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'key_Please_Enter_ifsc_code'.tr;
                              } else if (!RegExp(r'^[A-Z]{4}[0][A-Z0-9]{6}$')
                                  .hasMatch(value)) {
                                return 'key_Please_Enter_ifsc_code'.tr;
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
                                  await setBankDetails();
                                   Get.off(() => const BankingDetails());
                                  //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BankingDetails()));
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
