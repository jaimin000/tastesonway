import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastesonway/utils/theme_data.dart';
import 'package:http/http.dart' as http;
import '../../apiServices/api_service.dart';
import '../../utils/sharedpreferences.dart';
import 'package:intl/intl.dart';
import 'discount_page.dart';

class EditCoupon extends StatefulWidget {
  final isFixedData;
  final data;
  const EditCoupon({Key? key, required this.isFixedData, required this.data})
      : super(key: key);

  @override
  State<EditCoupon> createState() => _EditCouponState();
}

class _EditCouponState extends State<EditCoupon> {
  final _formKey = GlobalKey<FormState>();
  int refreshCounter = 0;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController perUserController = TextEditingController();
  final TextEditingController noUserController = TextEditingController();
  final TextEditingController couponUptoAmountController =
      TextEditingController();
  final TextEditingController minOrderController = TextEditingController();
  final TextEditingController couponValueController = TextEditingController();

  bool isEditable = false;
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
        initialDate: couponEndDate,
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

  void updateCoupon() async {
    String token = await Sharedprefrences.getToken();
    final response = await http.patch(Uri.parse("$baseUrl/update-coupon"),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: widget.isFixedData
            ? {
                "id": "${widget.data.id}",
                "name": nameController.text.toString(),
                "type": "2",
                "coupon_value": couponValueController.text.toString(),
                "coupon_upto_amount":
                    couponUptoAmountController.text.toString(),
                "valid_per_user": perUserController.text.toString(),
                "total_no_user": noUserController.text.toString(),
                "start_date": DateFormat('yyyy-MM-dd').format(couponStartDate),
                "valid_till_date":
                    DateFormat('yyyy-MM-dd').format(couponEndDate),
                "minimum_order_value": minOrderController.text.toString(),
                "coupon_active": "1"
              }
            : {
                "id": "${widget.data.id}",
                "name": nameController.text.toString(),
                "type": "1",
                "coupon_value": dropdownvalue.toString(),
                "coupon_upto_amount":
                    couponUptoAmountController.text.toString(),
                "valid_per_user": perUserController.text.toString(),
                "total_no_user": noUserController.text.toString(),
                "start_date": DateFormat('yyyy-MM-dd').format(couponStartDate),
                "valid_till_date":
                    DateFormat('yyyy-MM-dd').format(couponEndDate),
                "minimum_order_value": minOrderController.text.toString(),
                "coupon_active": "1"
              });
    print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      final data = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Coupon Edited Successfully!')),
      );
      print(data);
    }
    else if(response.statusCode == 401) {
      print("refresh token called");
      if (refreshCounter == 0) {
        refreshCounter++;
        bool tokenRefreshed = await getNewToken(context);
        tokenRefreshed ? updateCoupon() : null;
      }
    }
    else {
      setState(() {
        isLoading = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Something Went Wrong Please Try Again!')),
      );
      throw Exception('Failed to fetch data from API');
    }
  }

  void deleteCoupon() async {
    String token = await Sharedprefrences.getToken();
    final response =
        await http.delete(Uri.parse("$baseUrl/delete-coupon"), headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "coupon_id": "${widget.data.id}"
    });
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      final data = json.decode(response.body);
      print(data);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Coupon deleted Successfully!')),
      );
    }
    else if(response.statusCode == 401) {
      print("refresh token called");
      if (refreshCounter == 0) {
        refreshCounter++;
        bool tokenRefreshed = await getNewToken(context);
        tokenRefreshed ? deleteCoupon() : null;
      }
    }
    else {
      setState(() {
        isLoading = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Something Went Wrong Please Try Again!')),
      );
      throw Exception('Failed to fetch data from API');
    }
  }

  @override
  void initState() {
    nameController.text = widget.data.name;
    dropdownvalue = widget.data.couponValue;
    couponUptoAmountController.text = widget.data.couponUptoAmount.toString();
    perUserController.text = widget.data.validPerUser.toString();
    noUserController.text = widget.data.totalNoUser.toString();
    minOrderController.text = widget.data.minimumOrderValue.toString();
    couponValueController.text = widget.data.couponValue;

    final inputFormat = DateFormat('dd-MM-yyyy');
    final startdate = inputFormat.parse(widget.data.startDate);
    final enddate = inputFormat.parse(widget.data.validTillDate);
    couponStartDate = startdate;
    couponEndDate = enddate;
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
          'key_Edit'.tr,
          style: cardTitleStyle20(),
        ),
        actions: [
          isEditable
              ? IconButton(
                  onPressed: () {
                    deleteCoupon();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Coupon Deleted Successfully!')),
                    );
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const DiscountPage()),
                    // );
                    Navigator.pop(context,'true');
                  },
                  icon: const Icon(Icons.delete),
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      isEditable = true;
                    });
                  },
                  icon: const Icon(Icons.edit),
                ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          physics: BouncingScrollPhysics(),
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
                            'Basic Details',
                            style: mTextStyle18(),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            enabled: isEditable,
                            controller: nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'key_please_enter_coupan_name'.tr;
                              }
                              return null;
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
                        !widget.isFixedData
                            ? SizedBox(
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
                                            color: Color.fromRGBO(
                                                255, 114, 105, 1),
                                          ),
                                          items: items.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(
                                                "$items% off",
                                                style: inputTextStyle16(),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged:isEditable ? (String? newValue) {
                                            setState(() {
                                              dropdownvalue = newValue!;
                                            });
                                          } : null,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: TextFormField(
                                  enabled: isEditable,
                                  controller: couponValueController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'key_Please_enter_coupan_value'.tr;
                                    }
                                    else if(!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                      return 'key_pls_number_only'.tr;
                                    }
                                    return null;
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
                            enabled: isEditable,
                            controller: couponUptoAmountController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'key_Please_enter_coupan_Upto_Amount'.tr;
                              }
                              else if(!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                return 'key_pls_number_only'.tr;
                              }
                              return null;
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
                            enabled: isEditable,
                            controller: perUserController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'key_Please_enter_Valid_per_User'.tr;
                              }
                              else if(!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                return 'key_pls_number_only'.tr;
                              }
                              return null;
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
                            enabled: isEditable,
                            controller: noUserController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'key_Please_enter_Total_no_User'.tr;
                              }else if(!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                return 'key_pls_number_only'.tr;
                              }
                              return null;
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
                            enabled: isEditable,
                            controller: minOrderController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'key_Please_enter_Minimum_Order_Value'
                                    .tr;
                              }else if(!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                return 'key_pls_number_only'.tr;
                              }
                              return null;
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
                              onTap: isEditable
                                  ? () {
                                      _selectStartDate(context);
                                    }
                                  : null,
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
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: isEditable
                                  ? () {
                                      _selectEndDate(context);
                                    }
                                  : null,
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
                                          .format(couponEndDate),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
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
                                if (_formKey.currentState!.validate()) {
                                  // if (!isEndDateSelected || !isStartDateSelected) {
                                  //   ScaffoldMessenger.of(context).showSnackBar(
                                  //     SnackBar(content: Text('Please select Start Date and End Date')),
                                  //   );
                                  // } else {
                                  _formKey.currentState?.save();
                                  updateCoupon();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Coupon Updated Successfully!')),
                                  );
                                  // Navigator.pushReplacement(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           const DiscountPage()),
                                  // );
                                  Navigator.pop(context,'true');
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
