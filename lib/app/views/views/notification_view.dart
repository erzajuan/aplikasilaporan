import '/app/theme/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class NotificationView extends GetView {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: blueColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.notifications),
            const SizedBox(
              width: 6,
            ),
            Text(
              "Notification",
              style: whiteTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold,
              ),
            )
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/notif.json', width: 300, height: 180),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Anda belum mendapatkan notifikasi",
              style: greyTextStyle.copyWith(
                fontSize: 16,
                fontWeight: light,
              ),
            )
          ],
        ),
      ),
    );
  }
}
