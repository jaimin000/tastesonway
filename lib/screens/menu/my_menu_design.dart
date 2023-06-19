import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tastesonway/utils/theme_data.dart';
import '../../apiServices/api_service.dart';
import '../../models/theme_category_model.dart';
import '../../models/theme_image_model.dart';
import '../../utils/sharedpreferences.dart';
import 'package:http/http.dart' as http;

import '../undermaintenance.dart';

class MenuDesign extends StatefulWidget {
  const MenuDesign({Key? key}) : super(key: key);

  @override
  State<MenuDesign> createState() => _MenuDesignState();
}

class _MenuDesignState extends State<MenuDesign> {
  int refreshCounter = 0;
  bool isServicePresent = false;
  bool _isLoading = true;
  int selectedIndex = 0;
  String name = "";
  int selectedBackgroundIndex = 0;
  List<ThemeCategoryModel> themeCategoryList = [];
  List<ThemeImageModel> image = <ThemeImageModel>[];

  Future getTheme(BuildContext context, int index) async {
    // name = await Sharedprefrences.getMenuName();
    String token = await Sharedprefrences.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/get-theme'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      selectedBackgroundIndex = 0;
      themeCategoryList.clear();
      for (var categoryName in data['data'].keys) {
        themeCategoryList.add(ThemeCategoryModel(
            categoryName: categoryName.toString(), categoryIndex: index));
      }
      var themeName =
      data['data'][themeCategoryList[index].categoryName] as List;

      var tagObjs = themeName
          .map((tagJson) => ThemeImageModel.fromJson(tagJson))
          .toList();
      image = tagObjs;


      setState(() {
        _isLoading = false;
      });
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
          tokenRefreshed ? getTheme(context, index): null;
        }
      }
    }else {
      setState(() {
        _isLoading = false;
      });
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void initState() {
    super.initState();
    getTheme(context, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),
        title: Text(
          'List of Items',
          style: cardTitleStyle20(),
        ),
      ),
      body: UnderMaintenanceWidget(
        isShow: isServicePresent,
        callback: () async {
          await getTheme(context, 0);
        },
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: SizedBox(
                height: 70,
                child: ListView.builder(
                  itemCount: themeCategoryList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                              getTheme(this.context, index);
                            });
                          },
                          child: Card(
                            shadowColor: Colors.black,
                            color: selectedIndex == index
                                ? orangeColor()
                                : const Color.fromRGBO(
                                53, 56, 66, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(15.0),
                            ),
                            child: SizedBox(
                              height: 40,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  themeCategoryList[index]
                                      .categoryName,
                                  maxLines: 2,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style: mTextStyle14(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: SizedBox(
                    height: MediaQuery.of(context).size.height*0.75,
                    width: MediaQuery.of(context).size.width,
                    child: _isLoading
                        ?  Center(
                          child: CircularProgressIndicator(
                      color: orangeColor(),
                    ),
                        )
                        // : ListView.builder(
                        // itemCount: image.length,
                        // shrinkWrap: true,
                        // scrollDirection: Axis.horizontal,
                        // itemBuilder:
                        //     (BuildContext context, int index) {
                        //   return Row(children: [
                        //     Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: InkWell(
                        //             onTap: () async {
                        //               setState(() {});
                        //             },
                        //             child: ClipRRect(
                        //                 borderRadius:
                        //                 const BorderRadius.only(
                        //                     topRight:
                        //                     Radius.circular(
                        //                         7),
                        //                     topLeft:
                        //                     Radius.circular(
                        //                         7)),
                        //                 child: Stack(children: [
                        //                   SizedBox(
                        //                     height: 150,
                        //                     width: MediaQuery.of(context).size.width*0.4,
                        //                     child: Image.network(
                        //                       image[index].picture ??
                        //                           'https://via.placeholder.com/150x150?text=Default%20Image',
                        //                       fit: BoxFit.fill,
                        //                       errorBuilder: (context,
                        //                           url, error) =>
                        //                       const Icon(
                        //                         Icons.error,
                        //                         size: 25,
                        //                       ),
                        //                       loadingBuilder:
                        //                           (BuildContext
                        //                       context,
                        //                           Widget child,
                        //                           ImageChunkEvent?
                        //                           loadingProgress) {
                        //                         if (loadingProgress ==
                        //                             null)
                        //                           return child;
                        //                         return Center(
                        //                           child:
                        //                           CircularProgressIndicator(
                        //                             color:
                        //                             orangeColor(),
                        //                             value: loadingProgress
                        //                                 .expectedTotalBytes !=
                        //                                 null
                        //                                 ? loadingProgress
                        //                                 .cumulativeBytesLoaded /
                        //                                 loadingProgress
                        //                                     .expectedTotalBytes!
                        //                                 : null,
                        //                           ),
                        //                         );
                        //                       },
                        //                     ),
                        //                   ),
                        //                   Positioned(
                        //                       bottom: 0.0,
                        //                       child: Container(
                        //                           height: 20,
                        //                           width: 140,
                        //                           padding:
                        //                           const EdgeInsets
                        //                               .symmetric(
                        //                               horizontal:
                        //                               3),
                        //
                        //                           child:  Center(
                        //                               child: Text(
                        //                                  image[index].name??
                        //                                   'test',
                        //                                   style:
                        //                                   const TextStyle(
                        //                                     fontSize:
                        //                                     12,
                        //                                     color: Colors
                        //                                         .black,
                        //                                   )))))
                        //                 ]))))
                        //   ]);
                        // })
                  :GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.9,
                      ),
                      itemCount: image.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () async {
                              setState(() {});
                            },
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(7),
                                topLeft: Radius.circular(7),
                                bottomLeft: Radius.circular(7),
                                bottomRight: Radius.circular(7),
                              ),
                              child: Stack(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.45,
                                    child: Image.network(
                                      image[index].picture ??
                                          'https://via.placeholder.com/150x150?text=Default%20Image',
                                      fit: BoxFit.fill,
                                      errorBuilder: (context, url, error) => const Icon(
                                        Icons.error,
                                        size: 25,
                                      ),
                                      loadingBuilder: (BuildContext context, Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Center(
                                          child: CircularProgressIndicator(
                                            color: orangeColor(),
                                            value: loadingProgress.expectedTotalBytes != null
                                                ? loadingProgress.cumulativeBytesLoaded /
                                                loadingProgress.expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Positioned(
                                    top:170,
                                    bottom: 0,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.all(3),
                                      color: Colors.white60,
                                      child: Text(
                                        image[index].name ?? 'test',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                ))
          ],
        ),
      ),
    );
  }
}
