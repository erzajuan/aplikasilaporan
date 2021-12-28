import 'package:get/get.dart';

import '../controllers/form_laporan_controller.dart';

class FormLaporanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormLaporanController>(
      () => FormLaporanController(),
    );
  }
}
