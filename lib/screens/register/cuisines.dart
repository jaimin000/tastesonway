import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tastesonway/main.dart';
import '../../apiServices/ApiService.dart';
import '../../models/cuisines.dart';
import '../../utils/theme_data.dart';
import 'package:http/http.dart' as http;

class Cuisines extends StatefulWidget {
  const Cuisines({Key? key}) : super(key: key);

  @override
  State<Cuisines> createState() => _CuisinesState();
}

class _CuisinesState extends State<Cuisines> {
  List<CuisineModel> _foodItems = [];
  List<String> _selectedItems = [];

  void _onItemSelect(item) {
    setState(() {
      if (_selectedItems.contains(item)) {
        _selectedItems.remove(item);
      } else {
        _selectedItems.add(item);
      }
    });
    print(_selectedItems);
  }

  Future fetchData() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('https://dev-api.tastesonway.com/api/owners/get-cuisines'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (mounted) {
        setState(() {
          var data = jsonData['data'];
          print(data);
        });
        dynamic cuisineData = jsonData['data'];
        cuisineData
            .forEach((json) => _foodItems.add(CuisineModel.fromJson(json)));
        setState(() {});
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
  @override
  void initState() {
    fetchData();
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
          'Welcome to Tastes on Way',
          style: cardTitleStyle20(),
        ),
      ),
      body: ListView(
        children: [
          Container(
              color: cardColor(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'We are committed to helping chefs Food Busines with menu Creation, order management, sales tracking and lots more.',
                ),
              )),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'How did you hear about Tastes On Way?',
              style: TextStyle(
                color: orangeColor(),
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 5,
              runSpacing: 2,
              children: _foodItems.map((item) {
                return FilterChip(
                  label: Text(item.name!),
                  selected: item.isSelected ?? false,
                  selectedColor: orangeColor(),
                  backgroundColor: cardColor(),
                  onSelected: (value) {
                    item.isSelected = value;
                    setState(() {
                    });
                  },
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Home()),
                    );
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
                          'Next',
                          style: mTextStyle14(),
                        ),
                      )),
                )),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
