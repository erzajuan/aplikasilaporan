import 'package:aplikasilaporan/app/modules/home/controllers/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailView extends GetView<HomeController> {
  const DetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var indexDetail = Get.arguments;
    return StreamBuilder<QuerySnapshot<Object?>>(
      stream: controller.streamData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          var listAllLaporan = snapshot.data!.docs;
          return Scaffold(
            body: DefaultTabController(
              length: 2,
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      expandedHeight: 200.0,
                      floating: false,
                      pinned: false,
                      backgroundColor: blueColor,
                      flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          title: Text("Detail Page", style: whiteTextStyle),
                          background: Image.asset(
                            "assets/dummy.jpg",
                            fit: BoxFit.cover,
                          )),
                    ),
                  ];
                },
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(defaultSmallMargin),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.account_circle),
                                  Text(
                                      "${(listAllLaporan[indexDetail].data() as Map<String, dynamic>)["nama"]}"),
                                ],
                              ),
                              Text(
                                  "${(listAllLaporan[indexDetail].data() as Map<String, dynamic>)["date"]}")
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: defaultSmallMargin),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "•",
                                style:
                                    TextStyle(color: yellowColor, fontSize: 36),
                              ),
                              Text(
                                  "${(listAllLaporan[indexDetail].data() as Map<String, dynamic>)["status"]}"),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defaultSmallMargin),
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${(listAllLaporan[indexDetail].data() as Map<String, dynamic>)["judul"]}",
                              style: blackTextStyle.copyWith(
                                fontWeight: bold,
                                fontSize: 28,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: defaultMargin),
                              child: Text(
                                "${(listAllLaporan[indexDetail].data() as Map<String, dynamic>)["isi"]}",
                                style: blackTextStyle.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
