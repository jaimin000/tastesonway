import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastesonway/utils/theme_data.dart';

class UnderMaintenanceWidget extends StatelessWidget {
  final Widget child;
  final bool isShow;
  final VoidCallback callback;

  const UnderMaintenanceWidget(
      {Key? key, required this.isShow, required this.child, required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var widgetList = <Widget>[];
    if (isShow) {
      final modal = SingleChildScrollView(
        child: Stack(
          children: [
            Container(
                color: backgroundColor(),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/undermaintenance.png',
                      width:300,
                      height: 320,
                      fit: BoxFit.fill,
                    ),

                    Text('key_we_are_currently_under_maintenance'.tr,
                        style: mTextStyle18()),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('key_we_will_be_back_soon'.tr,
                        textAlign: TextAlign.center,
                        style: mTextStyle16()),
                    const SizedBox(
                      height: 30,
                    ),
                    ButtonTheme(
                        minWidth: 164.0,
                        height: 50.0,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: orangeColor(), // Background color
                            ),
                            onPressed: callback,
                            child: Text(
                                'key_Try_Again'.tr,
                                style: mTextStyle14())))
                  ],
                )),
          ],
        ),
      );
      widgetList.add(modal);
    } else {
      widgetList.add(child);
    }
    return Stack(
      children: widgetList,
    );
  }
}
