import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastesonway/utils/theme_data.dart';
import 'package:http/http.dart' as http;
import '../../apiServices/api_service.dart';
import '../../utils/sharedpreferences.dart';
import '../../utils/snackbar.dart';

class ReviewHistory extends StatefulWidget {
  const ReviewHistory({Key? key}) : super(key: key);

  @override
  State<ReviewHistory> createState() => _ReviewHistoryState();
}

class _ReviewHistoryState extends State<ReviewHistory> {

  List orderHistory = [];
  bool isLoading = true;

  Future fetchHistory() async {
    String token = await Sharedprefrences.getToken();
    final response = await http.get(
      Uri.parse("$baseUrl/get-kitchen-owner-review-history"),
      headers: {'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        isLoading = false;
        var data = jsonData['data'];
        orderHistory = data['data'].toList();
        print(orderHistory);
      });
    } else if(response.statusCode == 401) {
      print("refresh token called");
      getNewToken(context);
      fetchHistory();
    }else {
      setState(() {
        isLoading = false;
      });
      ScaffoldSnackbar.of(context)
          .show('Something Went Wrong Please Try Again');
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future deleteHistory(String id) async {
    String token = await Sharedprefrences.getToken();
    final response = await http.delete(
      Uri.parse("$baseUrl/delete-kitchen-owner-review"),
      headers: {'Authorization': 'Bearer $token'},
      body:{"kitchen_owner_review_id":id},
    );

    if (response.statusCode == 200) {
      isLoading = false;
      final jsonData = json.decode(response.body);
      print(jsonData);
      ScaffoldSnackbar.of(context)
          .show('Review History Deleted Successfully!');
      setState(() {
      });
    } else if(response.statusCode == 401) {
      print("refresh token called");
      getNewToken(context);
      deleteHistory(id);
    }else {
      isLoading =false;
      print('Request failed with status: ${response.statusCode}.');
      ScaffoldSnackbar.of(context)
          .show('Something Went Wrong Please Try Again!');
      setState(() {
      });
    }
  }

  String getStatus(int i){
    if(i==1){
      return 'Under review';
    }
    else if(i==2){
      return 'Approved';
    }
    else{
      return 'Rejected';
    }
  }

  @override
  void initState() {
    fetchHistory();
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
          'key_Reviews_History'.tr,
          style: cardTitleStyle20(),
        ),
      ),
      body: isLoading?
      Center(child:CircularProgressIndicator(color:orangeColor()))
          : Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child:
        ListView.builder(
          itemCount: orderHistory.length,
            itemBuilder:(BuildContext context, int index){
            return Column(
              children: [
                SizedBox(
                  child: Card(
                    shadowColor: Colors.black,
                    color: const Color.fromRGBO(64, 68, 81, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height:10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                getStatus(orderHistory[index]['review_status']),
                                style: mTextStyle16(),
                              ),
                              InkWell(
                                onTap: (){
                                  deleteHistory(orderHistory[index]['id'].toString()).
                                  then((value) => setState(() {
                                  fetchHistory();
                                  }));

                                },
                                  child: Icon(Icons.delete_rounded,color: orangeColor(),)),
                            ],
                          ),
                          const SizedBox(height:5),
                          Text(
                            '${'Your '+ orderHistory[index]['review_type']} is in Review',
                            style: cTextStyle16(),
                          ),
                          const SizedBox(height:5),
                          const Divider(
                            height: 20,
                            color: Colors.white,
                            endIndent: 5,
                            indent: 5,
                          ),
                          const SizedBox(height:5),
                          Text(
                            '${'You have changed '+ orderHistory[index]['review_type']} Details, our team will Review it and get back to you!',
                            style: cTextStyle16(),
                          ),
                          const SizedBox(height:10),

                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25,),
              ],
            );
            }
        ),
      ),
    );
  }
}
