import 'package:flutter/material.dart';
import 'package:tastesonway/screens/register/cuisines.dart';
import 'package:tastesonway/screens/register/question3.dart';
import '../../theme_data.dart';

class Question2 extends StatefulWidget {
  const Question2({Key? key}) : super(key: key);
  @override
  _Question2State createState() => _Question2State();
}

class _Question2State extends State<Question2> {
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
              'Why do you wish to use Tastes On Way?',
              style: TextStyle(
                color: orangeColor(),
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CheckboxListTile(
                title: const Text('To track my Expenses'),
                value: true,
                onChanged:(bool? value) { },
                controlAffinity: ListTileControlAffinity.leading
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CheckboxListTile(
                title: const Text('To manage my Orders'),
                value: false,
                onChanged:(bool? value) { },
                controlAffinity: ListTileControlAffinity.leading
            ),
          ),Padding(
            padding: const EdgeInsets.all(8.0),
            child: CheckboxListTile(
                title: const Text('To create beautiful Menu Card'),
                value: false,
                onChanged:(bool? value) { },
                controlAffinity: ListTileControlAffinity.leading
            ),
          ),Padding(
            padding: const EdgeInsets.all(8.0),
            child: CheckboxListTile(
                title: const Text('To create an Online Store'),
                value: false,
                onChanged:(bool? value) { },
                controlAffinity: ListTileControlAffinity.leading
            ),
          ),Padding(
            padding: const EdgeInsets.all(8.0),
            child: CheckboxListTile(
                title: const Text('To Create a Website'),
                value: false,
                onChanged:(bool? value) { },
                controlAffinity: ListTileControlAffinity.leading
            ),
          ),Padding(
            padding: const EdgeInsets.all(8.0),
            child: CheckboxListTile(
                title: const Text('Others'),
                value: false,
                onChanged:(bool? value) { },
                controlAffinity: ListTileControlAffinity.leading
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
                      MaterialPageRoute(builder: (context) => const Question3()),);
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
