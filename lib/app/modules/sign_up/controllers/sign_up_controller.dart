import 'package:aplikasilaporan/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  TextEditingController namaC = TextEditingController();
  TextEditingController telpC = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var isPassword = true.obs;
  void changeVisible() => isPassword.value = !isPassword.value;

  void addUser(String email, String pass, String nama, String telp) async {
    CollectionReference user = firestore.collection("users");

    try {
      await user.add({
        "email": email,
        "pass": pass,
        "nama": nama,
        "telp": telp,
      });

      Get.defaultDialog(
        title: "Berhasil",
        middleText: "Berhasil Menambahkan Akun",
        onConfirm: () {
          emailC.clear();
          passC.clear();
          namaC.clear();
          telpC.clear();

          Get.toNamed(Routes.SIGN_IN);
        },
        textConfirm: "OK",
      );
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Error",
        middleText: "Tidak Berhasil Menambahkan Laporan",
        onConfirm: () => Get.offAllNamed(Routes.GET_STARTED),
      );
    }
  }

  @override
  void onInit() {
    emailC = TextEditingController();
    passC = TextEditingController();
    namaC = TextEditingController();
    passC = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    emailC.dispose();
    passC.dispose();
    namaC.dispose();
    telpC.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    emailC.dispose();
    passC.dispose();
    super.onClose();
  }
}
