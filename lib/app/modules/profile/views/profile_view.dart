import 'package:aplikasilaporan/app/modules/home/controllers/home_controller.dart';
import 'package:aplikasilaporan/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/app/controllers/auth_controller.dart';
import '/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends GetView<HomeController> {
  final authC = Get.find<AuthController>();
  FirebaseAuth auth = FirebaseAuth.instance;

  ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(controller.laporan.toString());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 30),
                  width: double.infinity,
                  height: 350,
                  decoration: BoxDecoration(
                    color: blueColor.withOpacity(0.4),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        width: 150,
                        height: 150,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/profile-pic.png',
                            ),
                          ),
                        ),
                      ),
                      Text(
                        auth.currentUser!.email.toString(),
                        style: whiteTextStyle.copyWith(
                          fontSize: 24,
                          fontWeight: medium,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  margin: EdgeInsets.only(
                    top: 300,
                    left: defaultMargin,
                    right: defaultMargin,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    color: whiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: greyColor,
                        blurRadius: 6,
                      )
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          controller.laporan.toString(),
                          style: blueTextstyle.copyWith(
                            fontSize: 30,
                            fontWeight: bold,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        const Text("Laporan")
                      ],
                    ),
                  ),
                )
              ],
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ListTile(
                  title: const Text("Tentang App"),
                  leading: const Icon(Icons.contact_support_rounded),
                  onTap: () {
                    Get.defaultDialog(
                      title: 'LaporKu',
                      content: Column(
                        children: [
                          Image.asset(
                            'assets/logo.png',
                            width: 100,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          const Text(
                              'LaporKu adalah aplikasi penampung wadah aspirasi dan keluhan masyarakat baik itu mengenai infrastruktur pemerintah daerah maupun masalah sosial lainnya,'),
                        ],
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text("Reset Password"),
                  leading: const Icon(Icons.password_outlined),
                  onTap: () {
                    Get.toNamed(Routes.RESET_PASSWORD);
                  },
                ),
                ListTile(
                  title: const Text("Log Out"),
                  leading: const Icon(Icons.logout),
                  onTap: () {
                    authC.logOut();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
