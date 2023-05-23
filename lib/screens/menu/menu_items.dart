import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tastesonway/utils/theme_data.dart';
import 'package:http/http.dart' as http;
import '../../apiServices/api_service.dart';
import '../../models/MenuItemModel.dart';
import '../../utils/sharedpreferences.dart';

class MenuItems extends StatefulWidget {
  const MenuItems({Key? key}) : super(key: key);

  @override
  State<MenuItems> createState() => _MenuItemsState();
}

class _MenuItemsState extends State<MenuItems> {
  bool _isLoading = true;
  late List<dynamic> menuData = [];
  List<MenuItemModel> menuItemList = [];

  Future getMenuItem() async {
    String? ownerId = await Sharedprefrences.getId();
    String token = await Sharedprefrences.getToken();
    final response =
        await http.post(Uri.parse('$baseUrl/get-menu-item'), headers: {
      'Authorization': 'Bearer $token'
    }, body: {
      'business_owner_id': ownerId,
    });
    if (response.statusCode == 200) {
      _isLoading = false;
      final Map<String, dynamic> data = json.decode(response.body);
      menuData = data['data'][1]['data'];
      for (int i = 0; i < menuData.length; i++) {
        menuItemList.add(MenuItemModel(
          name: menuData[i]['name'],
          type: menuData[i]['type'],
          price: menuData[i]['amount'],
          image: menuData[i]['picture'],
        ));
      }

      setState(() {});
    } else if(response.statusCode == 401) {
      print("refresh token called");
      bool tokenRefreshed = await getNewToken(context);
      tokenRefreshed ?getMenuItem():null;
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
    getMenuItem();
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
        body: _isLoading? Center(
          child: CircularProgressIndicator(
            color: orangeColor(),
          ),
        ) :Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(children: [
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    style: const TextStyle(color: Colors.white), //<-- SEE HERE

                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.search,
                        color: orangeColor(),
                      ),
                      contentPadding: const EdgeInsets.all(10.0),
                      fillColor: inputColor(),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      hintText: 'Search Menu Items',
                      hintStyle: inputTextStyle16(),
                    ),
                  ),
                ),
              ),
              ListView.builder(
                  itemCount: menuItemList.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(children: [
                      const SizedBox(height: 10),
                      SizedBox(
                          height: 120,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                              shadowColor: Colors.black,
                              color: cardColor(),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Container(
                                  padding: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.all(8),
                                  child: Row(children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        menuItemList[index].image,
                                        height: 100,
                                        width: 95,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                menuItemList[index]
                                                    .name,
                                                style: mTextStyle20(),
                                              ),
                                              const SizedBox(height: 5,),
                                              Text(
                                                '₹ ${menuItemList[index].price}',
                                                style: cTextStyle18(),
                                              )
                                            ]))
                                  ]))))
                    ]);
                  })
            ])));
  }
}
