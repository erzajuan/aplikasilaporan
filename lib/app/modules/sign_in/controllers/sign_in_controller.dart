import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  var isPassword = true.obs;
  void changeVisible() => isPassword.value = !isPassword.value;
  @override
  void onClose() {
    emailC.dispose();
    passC.dispose();
    super.onClose();
  }
}
