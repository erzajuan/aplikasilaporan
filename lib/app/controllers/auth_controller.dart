import 'package:firebase_auth/firebase_auth.dart';
import '/app/routes/app_pages.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  Stream<User?> get streamAuth => auth.authStateChanges();

  void resetPassword(String email) async {
    if (email != '' && GetUtils.isEmail(email)) {
      try {
        await auth.sendPasswordResetEmail(email: email);
        Get.defaultDialog(
          title: 'Berhasil',
          middleText: 'Kami telah mengirimkan reset password ke email $email',
          onConfirm: () {
            Get.back();

            Get.back();
          },
          textConfirm: 'Oke',
        );
      } catch (e) {
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Tidak dapat mengirimkan reset password.",
        );
      }
    } else {
      Get.defaultDialog(
        title: 'Terjadi kesalahan',
        middleText: 'Email tersebut tidak valid',
      );
    }
  }

  void login(String email, String password) async {
    try {
      UserCredential myUser = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (myUser.user!.emailVerified) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.defaultDialog(
            title: "Verifikasi Email",
            middleText:
                "Kamu perlu melakukan verifikasi email terlebih dahulu.");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.defaultDialog(
          title: "User Not Found",
          middleText: "user dengan email tsb belum terdaftar",
        );
      } else if (e.code == 'wrong-password') {
        Get.defaultDialog(
          title: 'Wrong Password',
          middleText: 'Password yang anda masukkan salah',
        );
      }
    }
  }

  void signUp(String email, String password) async {
    try {
      UserCredential myUser =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await myUser.user!.sendEmailVerification();
      Get.defaultDialog(
        title: "Verification Email",
        middleText: "Kami telah mengirikan email verifikasi ke $email.",
        onConfirm: () {
          Get.back();
          Get.back();
        },
        textConfirm: "Ya, Saya akan cek email.",
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.defaultDialog(
          title: 'Something Wrong',
          middleText: 'Email sudah ada yang menggunakan',
        );
      }
    } catch (e) {
      print(e);
    }
  }

  void logOut() {
    try {
      Get.defaultDialog(
        title: 'Pesan Konfirmasi',
        middleText: 'Yakin ingin keluar ?',
        textConfirm: 'Ya',
        textCancel: 'Tidak',
        onConfirm: () async {
          await FirebaseAuth.instance.signOut();

          Get.offAllNamed(Routes.GET_STARTED);
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
