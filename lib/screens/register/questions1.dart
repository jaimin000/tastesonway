import 'package:flutter/material.dart';
import 'package:tastesonway/screens/register/question2.dart';
import '../../theme_data.dart';

class Question1 extends StatefulWidget {
  const Question1({Key? key}) : super(key: key);
  @override
  _Question1State createState() => _Question1State();
}

class _Question1State extends State<Question1> {
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  'Which of the Following best describes you?',
                  style: TextStyle(
                     color: orangeColor(),
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                      value: '',
                      groupValue: '',
                      onChanged: (value) {},
                    ),
                    const Text(
                      'I love cooking but do not sell',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                      value: false,
                      groupValue: '',
                      onChanged: (value) {},
                    ),
                    const Text(
                      'I sell Homemade Food',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                      value: false,
                      groupValue: '',
                      onChanged: (value) {},
                    ),
                    const Text(
                      'I am a baker and sell cakes\n & baked product',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                      value: false,
                      groupValue: '',
                      onChanged: (value) {},
                    ),
                    const Text(
                      'I manage commercial kitchen\n (cloud kitchen)',
                      style: TextStyle(fontSize: 16),
                      overflow: TextOverflow.clip,

                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                      value: false,
                      groupValue: '',
                      onChanged: (value) {},
                    ),
                    const Text(
                      'I manage Cafe / Bakery / Restaurant',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                      value: false,
                      groupValue: '',
                      onChanged: (value) {},
                    ),
                    const Text(
                      'I am re-seller of food products',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                      value: false,
                      groupValue: '',
                      onChanged: (value) {},
                    ),
                    const Text(
                      'other',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const Question2()),);
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
        ),
      );
}
