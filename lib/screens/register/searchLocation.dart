import 'package:flutter/material.dart';
import 'package:tastesonway/theme_data.dart';

class SearchLocation extends StatelessWidget {
  const SearchLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor(),

        title: Text(
          'Search Location',
          style: cardTitleStyle20(),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [

            SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width,
              child: TextField(
                style: const TextStyle(color: Colors.white), //<-- SEE HERE
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search,color: orangeColor(),),
                  contentPadding: const EdgeInsets.all(10.0),
                  fillColor: inputColor(),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  hintText: 'Search For Your Location ...',
                  hintStyle: inputTextStyle16(),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
