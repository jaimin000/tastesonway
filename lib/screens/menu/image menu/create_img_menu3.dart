import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastesonway/models/theme_category_model.dart';
import '../../../apiServices/api_service.dart';
import '../../../models/theme_image_model.dart';
import '../../../utils/theme_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';
import 'imageMenuIdController.dart';

class CreateImgMenu3 extends StatefulWidget {
  const CreateImgMenu3({Key? key}) : super(key: key);

  @override
  State<CreateImgMenu3> createState() => _CreateImgMenu3State();
}

class _CreateImgMenu3State extends State<CreateImgMenu3> {
  List<ThemeImageModel> image = <ThemeImageModel>[];
  String backgroundImage = "";
  List<ThemeCategoryModel> themeCategoryList = [];
  bool _isLoading = true;
  int selectedIndex = 0;
  int selectedBackgroundIndex = 0;
  int menuId = 0;

  Future getTheme(BuildContext context, int index) async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('$devUrl/get-theme'),
      headers: {'Authorization': 'Bearer $token'},
    );
    setState(() {
      _isLoading = false;
    });
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      //print(data);
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
      backgroundImage = image[0].picture;
    } else {
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
          'Create New Image Menu',
          style: cardTitleStyle20(),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 25,
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
          //   child: Text(
          //     "Create Image Menu",
          //     style: mTextStyle20(),
          //   ),
          // ),
          // const SizedBox(
          //   height: 25,
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  shadowColor: Colors.black,
                  color: const Color.fromRGBO(53, 56, 66, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.28,
                    height: 45,
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Step 1',
                          style: mTextStyle16(),
                        )),
                  ),
                ),
                Card(
                  shadowColor: Colors.black,
                  color: const Color.fromRGBO(53, 56, 66, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.28,
                    height: 45,
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Step 2',
                          style: mTextStyle16(),
                        )),
                  ),
                ),
                Card(
                  shadowColor: Colors.black,
                  color: orangeColor(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.28,
                    height: 45,
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Step 3',
                          style: mTextStyle16(),
                        )),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.40,
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: backgroundColor(),
                        child: _isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                    color: orangeColor()),
                              )
                            : Image.network(
                                backgroundImage ??
                                    'https://via.placeholder.com/150x150?text=Default%20Image',
                                fit: BoxFit.cover,
                                errorBuilder: (context, url, error) =>
                                    const Icon(
                                  Icons.error,
                                  size: 55,
                                ),
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: orangeColor(),
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                              ),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width*0.8,
                          child: ListView(
                            children:  [
                              SizedBox(height: 20,),
                               Center(child: Text("Menu Name",style: mTextStyle18(),)),
                               SizedBox(height:5),
                               Center(child: Text("Dishes In The Menu",style: mTextStyle14(),)),
                              const Divider(
                                color: Colors.white60,
                              indent: 30,
                              endIndent: 30,
                              thickness: 2.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                        child: Image.asset('./assets/images/tea.jpg',width: 50,height: 50,fit: BoxFit.cover)),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text('Cheesy Pizza',style: mTextStyle16(),),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Image.asset('./assets/images/veg.png',color: Colors.green,height: 20,),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text('₹ 100',style: mTextStyle16(),),
                                  ),
                                ],
                              ),Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                        child: Image.asset('./assets/images/tea.jpg',width: 50,height: 50,fit: BoxFit.cover)),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text('Cheesy Pizza',style: mTextStyle16(),),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Image.asset('./assets/images/veg.png',color: Colors.green,height: 20,),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text('₹ 100',style: mTextStyle16(),),
                                  ),
                                ],
                              ),Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                        child: Image.asset('./assets/images/tea.jpg',width: 50,height: 50,fit: BoxFit.cover)),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text('Cheesy Pizza',style: mTextStyle16(),),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Image.asset('./assets/images/veg.png',color: Colors.green,height: 20,),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text('₹ 100',style: mTextStyle16(),),
                                  ),
                                ],
                              ),Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                        child: Image.asset('./assets/images/tea.jpg',width: 50,height: 50,fit: BoxFit.cover)),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text('Cheesy Pizza',style: mTextStyle16(),),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Image.asset('./assets/images/veg.png',color: Colors.green,height: 20,),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text('₹ 100',style: mTextStyle16(),),
                                  ),
                                ],
                              ),


                            ],
                          )
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Themes", style: mTextStyle20()),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Row(
                        children: [
                          Text("All", style: mTextStyle14()),
                          const SizedBox(
                            width: 5,
                          ),
                          Image.asset(
                            './assets/images/Arrow - Right.png',
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: SizedBox(
                  height: 50,
                  child: _isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: orangeColor(),
                          ),
                        )
                      : ListView.builder(
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
                                        : const Color.fromRGBO(53, 56, 66, 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: SizedBox(
                                      height: 40,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          themeCategoryList[index].categoryName,
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
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: SizedBox(
                  height: 110,
                  width: MediaQuery.of(context).size.width,
                  child: _isLoading
                      ? const SizedBox()
                      : ListView.builder(
                          itemCount: image.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedBackgroundIndex = index;
                                        backgroundImage = image[index].picture;
                                      });
                                    },
                                    child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(7),
                                            topLeft: Radius.circular(7)),
                                        child: Stack(
                                          children: [
                                            SizedBox(
                                              height: 110,
                                              width: 140,
                                              child: Image.network(
                                                image[index].picture ??
                                                    'https://via.placeholder.com/150x150?text=Default%20Image',
                                                fit: BoxFit.fill,
                                                errorBuilder:
                                                    (context, url, error) =>
                                                        const Icon(
                                                  Icons.error,
                                                  size: 25,
                                                ),
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                  if (loadingProgress == null)
                                                    return child;
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: orangeColor(),
                                                      value: loadingProgress
                                                                  .expectedTotalBytes !=
                                                              null
                                                          ? loadingProgress
                                                                  .cumulativeBytesLoaded /
                                                              loadingProgress
                                                                  .expectedTotalBytes!
                                                          : null,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 0.0,
                                              child: Container(
                                                height: 20,
                                                width: 140,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 3),
                                                color:
                                                    selectedBackgroundIndex ==
                                                            index
                                                        ? orangeColor()
                                                        : Colors.white,
                                                child: Center(
                                                  child: Text(
                                                    image[index].name,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
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
                        'Proceed',
                        style: mTextStyle14(),
                      ),
                    ))),
          ),
        ],
      ),
    );
  }
}
