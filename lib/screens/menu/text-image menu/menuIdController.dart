import 'package:get/get.dart';

class MenuIdController extends GetxController {
  late int _menuId;

  int get menuId => _menuId;

  set menuId(int value) {
    _menuId = value;
    update();
  }
}
