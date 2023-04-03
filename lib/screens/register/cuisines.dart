import 'package:flutter/material.dart';
import 'package:tastesonway/main.dart';
import 'package:tastesonway/screens/dashboard/dashboard.dart';
import '../../theme_data.dart';

class Cuisines extends StatefulWidget {
  const Cuisines({Key? key}) : super(key: key);

  @override
  State<Cuisines> createState() => _CuisinesState();
}

class _CuisinesState extends State<Cuisines> {
  List<String> _foodItems = ['Chinese', 'Indian', 'Mexican', 'Punjabi'];
  List<String> _selectedItems = [];

  void _onItemSelect(String item) {
    setState(() {
      if (_selectedItems.contains(item)) {
        _selectedItems.remove(item);
      } else {
        _selectedItems.add(item);
      }
    });
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
              spacing: 10,
              runSpacing: 5,
              children: _foodItems.map((item) {
                return FilterChip(
                  label: Text(item),
                  selected: _selectedItems.contains(item),
                  selectedColor: orangeColor(),
                  backgroundColor: cardColor(),
                  onSelected: (selected) {
                    _onItemSelect(item);
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
                          builder: (context) => const Dashboard()),
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
