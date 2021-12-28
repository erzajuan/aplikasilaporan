import 'dart:io';
import 'package:aplikasilaporan/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FormLaporanController extends GetxController {
  late TextEditingController judulC;
  late TextEditingController isiC;
  late TextEditingController lokasiC;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final formKey = GlobalKey<FormState>();
  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      var imageTemporary = File(image.path);
      this.image = imageTemporary;
      update();
    } on PlatformException catch (e) {
      Get.defaultDialog(
        title: 'Tidak Berhasil',
        middleText: 'Gagal mengambil gambar: $e',
      );
    }
  }

  void add(
    String judul,
    String isi,
    String lokasi,
    String nama,
    String telp,
    String status,
    String date,
    int up,
    String? email,
  ) async {
    CollectionReference laporan = firestore.collection("laporan");

    try {
      await laporan.add({
        "judul": judul,
        "isi": isi,
        "lokasi": lokasi,
        "nama": nama,
        "telp": telp,
        "status": status,
        "date": date,
        "up": up,
        "email": email,
      });

      Get.defaultDialog(
        title: "Berhasil",
        middleText: "Berhasil Menambahkan Laporan",
        onConfirm: () {
          judulC.clear();
          isiC.clear();
          lokasiC.clear();
          Get.toNamed(Routes.HOME);
        },
        textConfirm: "OK",
      );
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Error",
        middleText: "Tidak Berhasil Menambahkan Laporan",
        onConfirm: () => Get.offAllNamed(Routes.HOME),
      );
    }
  }

  @override
  void onInit() {
    judulC = TextEditingController();
    isiC = TextEditingController();
    lokasiC = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    judulC.dispose();
    isiC.dispose();
    lokasiC.dispose();
    super.dispose();
  }

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference user = firestore.collection("users");

    return user.snapshots();
  }
}
