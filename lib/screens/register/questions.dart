import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastesonway/main.dart';
import 'package:tastesonway/models/hearAboutModel.dart';
import 'package:tastesonway/screens/register/cuisines.dart';
import '../../apiServices/ApiService.dart';
import '../../utils/sharedpreferences.dart';
import '../../utils/theme_data.dart';
import 'package:http/http.dart' as http;

class Questions extends StatefulWidget {
  const Questions({Key? key}) : super(key: key);
  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  int Radio1 = 0;
  int Radio2 = 0;
  bool isLoading = true;
  PageController pageController = PageController();
  int pageChanged = 0;
  List<int> check = [];
  List<bool> checkboxSelect = [];
  List<HearAboutModel> question1items = [];
  List<HearAboutModel> question2list = [];
  List<HearAboutModel> question3items = [];

  Future<void> getQuestion() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('$liveUrl/get-owner-opinion'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      dynamic hearAbout = jsonData['data']['hearAbout'];
      dynamic bestDescribe = jsonData['data']['bestDescribe'];
      dynamic wishToUse = jsonData['data']['wishToUse'];
      hearAbout
          .forEach((json) => question3items.add(HearAboutModel.fromJson(json)));
      bestDescribe
          .forEach((json) => question1items.add(HearAboutModel.fromJson(json)));
      wishToUse
          .forEach((json) => question2list.add(HearAboutModel.fromJson(json)));
      isLoading = false;
      print(question3items);
      checkboxSelect = List<bool>.filled(question2list.length, false);
      setState(() {});
      print(hearAbout);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Widget question1() => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'key_Which_of_the_following_best_describes_you'.tr,
                style: TextStyle(
                  color: orangeColor(),
                  fontSize: 16,
                ),
              ),
            ),
            Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: question1items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RadioListTile(
                        value: int.parse(question1items[index].id.toString()),
                        groupValue: Radio1,
                        activeColor: orangeColor(),
                        title: Text(
                          question1items[index].text,
                        ),
                        onChanged: (int? ind) {
                          setState(() {
                            Radio1 = ind!;
                            print('best describe : $Radio1');
                          });
                        },
                      );
                    }),
              ],
            ),
          ],
        ),
      );

  Widget question2() => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'key_Why_do_you_wish_to_use_Tastes_on_Ways'.tr,
                style: TextStyle(
                  color: orangeColor(),
                  fontSize: 16,
                ),
              ),
            ),
            Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: question2list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: orangeColor(),
                        title: Text(question2list[index].text),
                        value: checkboxSelect[index],
                        onChanged: (val) {
                          setState(
                            () {
                              checkboxSelect[index] = val!;
                              if (checkboxSelect[index] == true) {
                                check.add(int.parse(
                                    question2list[index].id.toString()));
                                print(check);
                              }
                            },
                          );
                        },
                      );
                    }),
              ],
            ),
          ],
        ),
      );

  Widget question3() => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'key_How_did_you_hear_about_Tastes_on_Ways'.tr,
                style: TextStyle(
                  color: orangeColor(),
                  fontSize: 16,
                ),
              ),
            ),
            Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: question3items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RadioListTile(
                        value: int.parse(question3items[index].id.toString()),
                        groupValue: Radio2,
                        activeColor: orangeColor(),
                        title: Text(
                          question3items[index].text,
                        ),
                        onChanged: (int? ind) {
                          setState(() {
                            Radio2 = ind!;
                            print('hear about $Radio2');
                          });
                        },
                      );
                    }),
              ],
            ),
          ],
        ),
      );

  Future fetchData() async {
    String token = await Sharedprefrences.getToken();
    final response = await http.post(
        Uri.parse('https://dev-api.tastesonway.com/api/v2/kitchen-owner-update-profile'),
        headers: {'Authorization': 'Bearer $token',
        },
        body: {
          'language_id':'1',
          'country_code':await Sharedprefrences.getCountryCode(),
          'short_code':await Sharedprefrences.getShortCode(),
          'hear_about_id': '$Radio1',
          'wish_to_use':'$Radio2',
          'best_describe_id':'$check[0]',
        }
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        var data = jsonData['data'];
        print(data);
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }


  @override
  void initState() {
    getQuestion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: backgroundColor(),
          title: Text(
            'Welcome to Tastes on Way',
            style: cardTitleStyle20(),
          ),
        ),
        backgroundColor: backgroundColor(),
        body: Container(
          child: Column(
            children: [
              Container(
                  color: cardColor(),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                    'key_We_are_Committed'.tr,
                    ),
                  )),
              const SizedBox(
                height: 15,
              ),
              isLoading
                  ? LimitedBox(
                maxHeight: 50,
                    child: CircularProgressIndicator(
                        color: orangeColor(),
                      ),
                  )
                  : SingleChildScrollView(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 1.6,
                        child: PageView(
                          controller: pageController,
                          physics: NeverScrollableScrollPhysics(),
                          onPageChanged: (index) {
                            setState(() {
                              pageChanged = index;
                            });
                            print(pageChanged);
                          },
                          children: [
                            question1(),
                            question2(),
                            question3(),
                          ],
                        ),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            var page = pageChanged - 1;
                            pageController.jumpToPage(page);
                            setState(() {});
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Card(
                                shadowColor: Colors.black,
                                color: orangeColor(),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'key_Previous'.tr,
                                    style: mTextStyle14(),
                                  ),
                                )),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            var page = pageChanged + 1;
                            if (page == 3) {
                              await fetchData();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Cuisines()),
                              );
                            } else {
                              pageController.jumpToPage(page);
                            }
                            setState(() {});
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Card(
                                shadowColor: Colors.black,
                                color: orangeColor(),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'key_Next'.tr,
                                    style: mTextStyle14(),
                                  ),
                                )),
                          ),
                        ),
                      ],
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      );
}
