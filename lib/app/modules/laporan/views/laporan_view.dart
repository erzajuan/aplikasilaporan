import 'package:aplikasilaporan/app/controllers/auth_controller.dart';
import 'package:aplikasilaporan/app/modules/home/controllers/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/app/routes/app_pages.dart';
import '/app/theme/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class LaporanView extends GetView<HomeController> {
  final authC = Get.find<AuthController>();

  FirebaseAuth auth = FirebaseAuth.instance;
  LaporanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueColor,
        title: const Text("Laporan"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
              top: Radius.circular(defaultRadius),
            )),
            context: context,
            builder: (context) {
              return Container(
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(defaultRadius),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(
                            Routes.FORM_LAPORAN,
                            arguments: "Infrastruktur",
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.amber[50],
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(defaultRadius),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Infrastruktur",
                                style: blackTextStyle.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              ClipOval(
                                child: Image.asset(
                                  'assets/infrastruktur.png',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                height: defaultMargin,
                              ),
                              Text(
                                "Laporan berkaitan dengan infrastruktur pemerintah",
                                softWrap: true,
                                textAlign: TextAlign.center,
                                style: greyTextStyle.copyWith(
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(
                            Routes.FORM_LAPORAN,
                            arguments: "Non Infrastruktur",
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.lightBlue[50],
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(defaultRadius),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Non Infrastruktur",
                                style: blackTextStyle.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              ClipOval(
                                child: Image.asset(
                                  'assets/aspirasi.png',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                height: defaultMargin,
                              ),
                              Text(
                                "Laporan mengenai keluhan masyarakat",
                                softWrap: true,
                                textAlign: TextAlign.center,
                                style: greyTextStyle.copyWith(
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
        backgroundColor: blueColor,
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: controller.streamData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var listAllLaporan = snapshot.data!.docs;
            print(auth.currentUser!.email);
            return ListView.builder(
              itemCount: listAllLaporan.length,
              itemBuilder: (context, index) {
                if ("${(listAllLaporan[index].data() as Map<String, dynamic>)["email"]}" ==
                    auth.currentUser!.email) {
                  print(controller.laporan);
                  controller.laporan = index;
                  print(controller.laporan);
                  return SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultMargin,
                        vertical: defaultSmallMargin,
                      ),
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(defaultRadius),
                              child: Image.asset(
                                "assets/dummy.jpg",
                                height: 180,
                                width: 400,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              height: 6.0,
                            ),
                            Center(
                              child: Text(
                                "${(listAllLaporan[index].data() as Map<String, dynamic>)["judul"]}",
                                style: blackTextStyle.copyWith(
                                  fontWeight: semiBold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.account_circle),
                                          Text(
                                              "${(listAllLaporan[index].data() as Map<String, dynamic>)["nama"]}"),
                                        ],
                                      ),
                                      Text(
                                          "${(listAllLaporan[index].data() as Map<String, dynamic>)["date"]}")
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                              "${(listAllLaporan[index].data() as Map<String, dynamic>)["up"]}"),
                                          IconButton(
                                            icon: Icon(Icons.arrow_circle_up),
                                            onPressed: () {},
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "•",
                                            style: TextStyle(
                                              color: yellowColor,
                                              fontSize: 36,
                                            ),
                                          ),
                                          Text(
                                              "${(listAllLaporan[index].data() as Map<String, dynamic>)["status"]}"),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return Text("");
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
