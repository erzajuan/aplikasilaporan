import '/app/modules/home/views/main_view.dart';
import '/app/modules/laporan/views/laporan_view.dart';
import '/app/modules/profile/views/profile_view.dart';
import '/app/theme/theme.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final List _listNav = [
    {
      "label": "Beranda",
      "icon": Icons.home,
      "fragment": MainView(),
    },
    {
      "label": "Laporanku",
      "icon": Icons.list,
      "fragment": LaporanView(),
    },
    {
      "label": "Profile",
      "icon": Icons.account_circle,
      "fragment": ProfileView(),
    }
  ];

  HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) {
        return Scaffold(
          bottomNavigationBar: DoubleBackToCloseApp(
            snackBar: const SnackBar(
              content: Text("Tekan sekali lagi untuk keluar"),
            ),
            child: BottomNavigationBar(
              selectedItemColor: blueColor,
              onTap: (int val) {
                controller.changeCurrentIndex = val;
              },
              items: _listNav.map((data) {
                return BottomNavigationBarItem(
                  label: data['label'],
                  icon: Icon(
                    data['icon'],
                  ),
                );
              }).toList(),
              currentIndex: controller.currentIndex,
            ),
          ),
          body: _listNav[controller.currentIndex]['fragment'],
        );
      },
    );
  }
}
