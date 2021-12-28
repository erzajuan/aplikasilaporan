import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  int currentIndex = 0;

  var laporan = 0;

  set changeCurrentIndex(int val) {
    currentIndex = val;
    update();
  }

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference laporan = firestore.collection("laporan");

    return laporan.snapshots();
  }
}
