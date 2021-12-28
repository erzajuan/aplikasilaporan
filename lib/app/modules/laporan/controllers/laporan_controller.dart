import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class LaporanController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference laporan = firestore.collection("laporan");

    return laporan.snapshots();
  }

  Future<QuerySnapshot<Object?>> getData() async {
    CollectionReference laporan = firestore.collection("laporan");

    return laporan.get();
  }
}
