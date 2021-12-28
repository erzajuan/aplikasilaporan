import 'package:aplikasilaporan/app/modules/reset_password/bindings/reset_password_binding.dart';
import 'package:aplikasilaporan/app/modules/reset_password/views/reset_password_view.dart';
import 'package:get/get.dart';
import '/app/modules/form_laporan/bindings/form_laporan_binding.dart';
import '/app/modules/form_laporan/views/form_laporan_view.dart';
import '/app/modules/home/bindings/home_binding.dart';
import '/app/modules/home/views/detail_view.dart';
import '/app/modules/home/views/home_view.dart';
import '/app/modules/laporan/bindings/laporan_binding.dart';
import '/app/modules/laporan/views/laporan_view.dart';
import '/app/modules/profile/bindings/profile_binding.dart';
import '/app/modules/profile/views/profile_view.dart';
import '/app/modules/sign_in/bindings/sign_in_binding.dart';
import '/app/modules/sign_in/views/sign_in_view.dart';
import '/app/modules/sign_up/bindings/sign_up_binding.dart';
import '/app/modules/sign_up/views/sign_up_view.dart';
import '/app/views/views/get_started_view.dart';
import '/app/views/views/notification_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.GET_STARTED;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.GET_STARTED,
      page: () => const GetStartedView(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
    ),
    GetPage(
      name: _Paths.DETAIL,
      page: () => const DetailView(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.LAPORAN,
      page: () => LaporanView(),
      binding: LaporanBinding(),
    ),
    GetPage(
      name: _Paths.FORM_LAPORAN,
      page: () => FormLaporanView(),
      binding: FormLaporanBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
  ];
}
