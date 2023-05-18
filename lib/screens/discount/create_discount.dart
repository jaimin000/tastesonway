import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:tastesonway/utils/theme_data.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../apiServices/api_service.dart';
import '../../utils/sharedpreferences.dart';
import 'discount_page.dart';

class CreateDiscount extends StatefulWidget {
  final isFixedData;

  CreateDiscount({required this.isFixedData});

  @override
  State<CreateDiscount> createState() => _CreateDiscountState();
}

class _CreateDiscountState extends State<CreateDiscount> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController perUserController = TextEditingController();
  final TextEditingController noUserController = TextEditingController();
  final TextEditingController couponUptoAmountController = TextEditingController();
  final TextEditingController minOrderController = TextEditingController();
  final TextEditingController couponValueController = TextEditingController();

  bool isLoading = true;
  bool isEndDateSelected = false;
  bool isStartDateSelected = false;
  DateTime couponStartDate = DateTime.now();
  DateTime couponEndDate = DateTime.now();
  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: couponStartDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != couponStartDate) {
      setState(() {
        couponStartDate = picked;
        isStartDateSelected = true;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: couponStartDate,
        firstDate: couponStartDate,
        lastDate: DateTime(2101));
    if (picked != null && picked != couponEndDate) {
      setState(() {
        couponEndDate = picked;
        isEndDateSelected = true;
      });
    }
  }

  String dropdownvalue = '10';
  var items = [
    '10',
    '15',
    '20',
    '25',
    '30',
    '35',
    '40',
    '45',
    '50',
    '55',
    '60',
    '65',
  ];

  void CreateCoupon() async {
    String token = await Sharedprefrences.getToken();
    final response =
    await http.post(Uri.parse("$baseUrl/create-coupon"), headers: {
      'Authorization': 'Bearer $token',
    }, body: widget.isFixedData ? {
      "name":nameController.text.toString(),
      "type":"2",
      "coupon_value":couponValueController.text.toString(),
      "coupon_upto_amount":couponUptoAmountController.text.toString(),
      "valid_per_user":perUserController.text.toString(),
      "total_no_user":noUserController.text.toString(),
      "start_date":DateFormat('yyyy-MM-dd').format(couponStartDate),
      "valid_till_date":DateFormat('yyyy-MM-dd').format(couponEndDate),
      "minimum_order_value":minOrderController.text.toString()
    }
    :
    {
      "name":nameController.text.toString(),
      "type":"1",
      "coupon_value":dropdownvalue.toString(),
      "coupon_upto_amount":couponUptoAmountController.text.toString(),
      "valid_per_user":perUserController.text.toString(),
      "total_no_user":noUserController.text.toString(),
      "start_date":DateFormat('yyyy-MM-dd').format(couponStartDate),
      "valid_till_date":DateFormat('yyyy-MM-dd').format(couponEndDate),
      "minimum_order_value":minOrderController.text.toString()
    });
    print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      final data = json.decode(response.body);
      print(data);
    }else {
      setState(() {
        isLoading = true;
      });
      throw Exception('Failed to fetch data from API');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),
        title: Text(
          widget.isFixedData ? 'key_Fixed_discount'.tr :'key_DISCOUNT'.tr,
          style: cardTitleStyle20(),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3.0),
                          child: Text(
                            'key_Basic_Details'.tr,
                            style: mTextStyle18(),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            controller: nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'key_please_enter_coupan_name'.tr;
                              }
                            },
                            style: const TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10.0),
                              fillColor: inputColor(),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              hintText: 'key_enter_coupan_name'.tr,
                              hintStyle: inputTextStyle16(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        !widget.isFixedData ? SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(37, 40, 48, 1),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'key_Enter_coupan_value'.tr,
                                    textAlign: TextAlign.left,
                                    style: inputTextStyle16(),
                                  ),
                                  DropdownButton(
                                    underline: const SizedBox(),
                                    value: dropdownvalue,
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Color.fromRGBO(255, 114, 105, 1),
                                    ),
                                    items: items.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(
                                          "${items}% off",
                                          style: inputTextStyle16(),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownvalue = newValue!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ) : SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            controller: couponValueController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'key_Please_enter_coupan_value'.tr;
                              }
                            },
                            style: const TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10.0),
                              fillColor: inputColor(),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              hintText: 'key_Enter_coupan_value'.tr,
                              hintStyle: inputTextStyle16(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            controller: couponUptoAmountController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'key_Please_enter_coupan_Upto_Amount'.tr;
                              }
                            },
                            style: const TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10.0),
                              fillColor: inputColor(),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              hintText: 'key_Enter_coupan_Upto_Amount'.tr,
                              hintStyle: inputTextStyle16(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            controller: perUserController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'key_Please_enter_Valid_per_User'.tr;
                              }
                            },
                            style: const TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10.0),
                              fillColor: inputColor(),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              hintText: 'key_Enter_Valid_per_User'.tr,
                              hintStyle: inputTextStyle16(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            controller: noUserController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'key_Please_enter_Total_no_User'.tr;
                              }
                            },
                            style: const TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10.0),
                              fillColor: inputColor(),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              hintText: 'key_Enter_Total_no_User'.tr,
                              hintStyle: inputTextStyle16(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            controller: minOrderController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'key_Please_enter_Minimum_Order_Value'.tr;
                              }
                            },
                            style: const TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10.0),
                              fillColor: inputColor(),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              hintText: 'key_Enter_Minimum_Order_Value'.tr,
                              hintStyle: inputTextStyle16(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3.0),
                          child: Text(
                            'key_Set_start_end_date'.tr,
                            style: mTextStyle18(),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                _selectStartDate(context);
                              },
                              child: SizedBox(
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(37, 40, 48, 1),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      DateFormat('dd-MM-yyyy')
                                          .format(couponStartDate),
                                      textAlign: TextAlign.center,
                                      style: inputTextStyle16(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // InkWell(
                            //   onTap: () {
                            //     _selectEndDate(context);
                            //   },
                            //   child: SizedBox(
                            //     height: 40,
                            //     width: MediaQuery.of(context).size.width * 0.4,
                            //     child: Container(
                            //       decoration: BoxDecoration(
                            //         color: const Color.fromRGBO(37, 40, 48, 1),
                            //         borderRadius: BorderRadius.circular(10.0),
                            //       ),
                            //       child: Padding(
                            //         padding: const EdgeInsets.all(8.0),
                            //         child: Text(
                            //           DateFormat('dd-MM-yyyy')
                            //               .format(couponEndDate),
                            //           textAlign: TextAlign.center,
                            //           style: inputTextStyle16(),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            InkWell(
                              onTap: () {
                                _selectEndDate(context);
                              },
                              child: SizedBox(
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(37, 40, 48, 1),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      DateFormat('dd-MM-yyyy').format(couponEndDate),
                                      textAlign: TextAlign.center,
                                      style: inputTextStyle16(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: InkWell(
                              onTap: () {
                                // if (_formKey.currentState!.validate()) {
                                // if(!isEndDateSelected || !isStartDateSelected) {
                                //   ScaffoldMessenger.of(context)
                                //       .showSnackBar(const SnackBar(content: Text(
                                //       'Please select Start Date and End Date')));
                                // }
                                // _formKey.currentState?.save();
                                // CreateCoupon();
                                // ScaffoldMessenger.of(context)
                                //     .showSnackBar(const SnackBar(content: Text(
                                //     'Coupon added Successfully!')));
                                // }
                                if (_formKey.currentState!.validate()) {
                                  if (!isEndDateSelected || !isStartDateSelected) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Please select Start Date and End Date')),
                                    );
                                  } else {
                                    _formKey.currentState?.save();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Coupon added Successfully!')),
                                    );
                                    CreateCoupon();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => const DiscountPage()),
                                    );

                                  }
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
                                      'key_Proceed'.tr,
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
            ),
          ],
        ),
      ),
    );
  }
}
