import 'package:get/get.dart';
import 'package:hive/hive.dart';

class AppController extends GetxController {
  /* *************** Variables *************** */

  /* *************** Controller life cycle *************** */

  @override
  void onClose() {
    //Close All Boxes
    Hive.close();
    super.onClose();
  }

  /* *************** Functions *************** */

}
