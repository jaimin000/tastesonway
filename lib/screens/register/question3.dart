import 'package:flutter/material.dart';
import 'package:tastesonway/screens/register/cuisines.dart';
import '../../theme_data.dart';

class Question3 extends StatefulWidget {
  const Question3({Key? key}) : super(key: key);
  @override
  _Question3State createState() => _Question3State();
}

class _Question3State extends State<Question3> {
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
              'How did you hear about Tastes On Way?',
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
                  'A friend told me',
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
                  'Facebook',
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
                  'Instagram',
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
                  'Whatsapp',
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
                  'Google',
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
                  'Youtube',
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
                    Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Cuisines()),);
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
