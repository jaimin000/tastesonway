import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:tastesonway/utils/theme_data.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../models/tutorials_list_model.dart';

class Tutorials extends StatelessWidget {
  late YoutubePlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  List<TutorialModel> tutorialList = [];
  List<TutorialFAQQuestionModel> tutorialFAQList = [];

  youtubePlayer() {
    _controller = YoutubePlayerController(
      initialVideoId: 'iLnmTe5Q2Qw',
      flags: const YoutubePlayerFlags(
        mute: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var tutorialFAQList = <TutorialFAQQuestionModel>[
      TutorialFAQQuestionModel(
          question:
              'key_Can_the_Tastes_on_Way_app_be_used_anywhere_in_India'.tr,
          answer: 'key_Yes_Tastes_on_Way_app_can_be_used_anywhere_in_india'.tr),
      TutorialFAQQuestionModel(
          question:
              'key_Do_I_have_to_pay_any_registration_or_subscription_fees'.tr,
          answer: 'key_No_this_app_is_free_to_use'.tr),
      TutorialFAQQuestionModel(
          question:
              'key_Can_buyers_use_the_Tastes_on_Way_app_and_view_the_menu'.tr,
          answer: 'key_No_the_Tastes_on_Way_app_is_only_for_the_chef'.tr)
    ];
    tutorialList.add(TutorialModel(
        title: 'key_How_can_I_create_a_beautiful_Menu_Card'.tr,
        youtubeUrl: 'TQqTBPHhpuQ',
        questions: tutorialFAQList));
    tutorialList.add(TutorialModel(
        title: 'key_How_can_I_create_a_Text_Menu'.tr,
        youtubeUrl: 'TQqTBPHhpuQ',
        questions: tutorialFAQList));
    var tutorialFAQList2 = <TutorialFAQQuestionModel>[
      TutorialFAQQuestionModel(
          question:
              'key_Does_the_Tastes_on_Way_app_offer_a_delivery_service'.tr,
          answer: 'key_No_Tastes_on_Way_does_not_offer_a_delivery_service'.tr),
      TutorialFAQQuestionModel(
          question: 'key_Do_I_have_to_pay_a_service_charges'.tr,
          answer: 'key_No_this_app_is_free'.tr),
      TutorialFAQQuestionModel(
          question:
              'key_Will_other_sellers_be_able_to_view_my_details_on_the_Tastes_on_Way_app'
                  .tr,
          answer: 'key_No_The_Tastes_on_Way_app_is_your_personal_assistant'.tr)
    ];
    tutorialList.add(TutorialModel(
        title: 'key_How_can_I_create_an_account'.tr,
        youtubeUrl: 'LEalE2ULmp4',
        questions: tutorialFAQList2));
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        backgroundColor: backgroundColor(),
        elevation: 0,
        title: Text(
          'key_Tutorials'.tr,
          style: cardTitleStyle20(),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            ListView.builder(
              itemCount: tutorialList.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext ctxt, int index) => InkWell(
                onTap: () => tutorialDetails(tutorialList[index], context),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(37, 40, 48, 1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.75,
                              child: Text(
                                tutorialList[index].title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                softWrap: true,
                                style: inputTextStyle16(),
                              ),
                            ),
                            Icon(
                              Icons.play_circle_rounded,
                              color: orangeColor(),
                              size: 35,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(10),
            //   child: Center(
            //     child: Container(
            //         height: MediaQuery.of(context).size.height / 10,
            //         width: MediaQuery.of(context).size.width,
            //         decoration: const BoxDecoration(
            //           borderRadius:
            //           BorderRadius.all(Radius.circular(20)),
            //         ),
            //         child: Card(
            //           elevation: 3,
            //           child: Padding(
            //             padding:
            //             const EdgeInsets.only(left: 10, right: 10),
            //             child: Row(
            //               mainAxisAlignment:
            //               MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Expanded(
            //                   flex: 12,
            //                   child: Text(
            //                     tutorialList[index].title,
            //                     style: const TextStyle(
            //                         fontSize: 14,
            //                         fontWeight: FontWeight.w600),
            //                   ),
            //                 ),
            //                 const Expanded(
            //                   child: Icon(
            //                     Icons.play_circle,
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //         )),
            //   ),
            // ))),
          ],
        ),
      ),
    );
  }

  void tutorialDetails(TutorialModel tutorialList, BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
        backgroundColor: cardColor(),
        context: context,
        useRootNavigator: true,
        isScrollControlled: true,
        builder: (context) => SizedBox(
              height: MediaQuery.of(context).size.height / 1.1,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: [
                          InkWell(
                              onTap: () => Navigator.of(context).pop(),
                              child: const Icon(
                                CupertinoIcons.xmark,
                              )),
                          const SizedBox(
                            width: 20,
                          ),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'key_Orders'.tr,
                                  style: const TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width*0.75,
                                  child: Text(
                                    'key_How_can_I_record_my_orders_on_Tastes_on_ways'
                                        .tr,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: YoutubePlayer(
                        controller: YoutubePlayerController(
                          initialVideoId: tutorialList.youtubeUrl,
                          //Add videoID.
                          flags: const YoutubePlayerFlags(
                            controlsVisibleAtStart: true,
                          ),
                        ),
                        showVideoProgressIndicator: true,
                        // progressIndicatorColor: Colors.orange,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      'key_Frequently_Asked_Questions'.tr,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                  ListView.builder(
                      itemCount: tutorialList.questions.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext ctxt, int index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: GFAccordion(
                                    titleBorderRadius:const BorderRadius.all(Radius.circular(10)),
                                    contentBackgroundColor: cardColor(),
                                  collapsedTitleBackgroundColor: inputColor(),
                                  contentPadding: const EdgeInsets.only(top: 5,
                                      left: 10, right: 10),
                                  expandedTitleBackgroundColor: inputColor(),
                                  title: tutorialList.questions[index].question,
                                  contentChild: Text(
                                      tutorialList.questions[index].answer),
                                  textStyle: mTextStyle14()
                                ),
                              ),
                            ],
                          )),

                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                              shadowColor: Colors.black,
                              color: orangeColor(),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'key_Got_It'.tr,
                                  style: mTextStyle14(),
                                ),
                              ))),
                    ),
                  ),
                ],
              )),
            ));
  }
}
