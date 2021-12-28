import 'package:aplikasilaporan/app/modules/form_laporan/controllers/form_laporan_controller.dart';
import 'package:aplikasilaporan/app/modules/home/controllers/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/app/routes/app_pages.dart';
import '/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainView extends GetView<HomeController> {
  MainView({Key? key}) : super(key: key);
  var formC = Get.put(FormLaporanController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueColor,
        title: const Text("Laporan"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: controller.streamData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var listAllLaporan = snapshot.data!.docs;
            return ListView.builder(
              itemCount: listAllLaporan.length,
              itemBuilder: (context, index) {
                return SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultMargin,
                      vertical: defaultSmallMargin,
                    ),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(Routes.DETAIL, arguments: index);
                      },
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(defaultRadius),
                              child: Image.asset(
                                'assets/jalan.jpeg',
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
                  ),
                );
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
