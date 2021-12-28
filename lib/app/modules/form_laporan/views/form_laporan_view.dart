import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/form_laporan_controller.dart';

class FormLaporanView extends GetView<FormLaporanController> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FormLaporanView({Key? key}) : super(key: key);

  String datetime = DateFormat("EEEEE, dd, yyyy").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buat Laporan"),
        centerTitle: true,
        backgroundColor: blueColor,
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: controller.streamData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var listUser = snapshot.data!.docs;
            var index = 0;
            for (var i = 0; i < listUser.length; i++) {
              if ("${(listUser[i].data() as Map<String, dynamic>)["email"]}" ==
                  auth.currentUser?.email) {
                index = i;
              }
            }
            return Padding(
              padding: EdgeInsets.only(top: 30, left: defaultMargin),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Kirim Aduan",
                        style: blueTextstyle.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Kategori: ${Get.arguments.toString()}",
                        style: blackTextStyle,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: defaultMargin),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            validator: (value) =>
                                value == '' ? "Dont Empty" : null,
                            controller: controller.judulC,
                            autocorrect: false,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              labelText: 'judul Aduan',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            validator: (value) =>
                                value == '' ? "Dont Empty" : null,
                            controller: controller.isiC,
                            maxLines: 5,
                            maxLength: 250,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              labelText: 'Isi Aduan',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            validator: (value) =>
                                value == '' ? "Dont Empty" : null,
                            controller: TextEditingController(
                              text: 'Automatis di isi lokasinya',
                            ),
                            enabled: false,
                            keyboardType: TextInputType.none,
                            readOnly: true,
                            decoration: InputDecoration(
                              label: Row(
                                children: const [
                                  Icon(Icons.location_on),
                                  Text("Lokasi")
                                ],
                              ),
                              border: const OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            validator: (value) =>
                                value == '' ? "Dont Empty" : null,
                            controller: controller.lokasiC,
                            decoration: const InputDecoration(
                              labelText: 'Keterangan Lokasi',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Gambar Aduan",
                                style: blackTextStyle.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GetBuilder<FormLaporanController>(
                                builder: (_) {
                                  return Material(
                                    elevation: 8,
                                    child: InkWell(
                                      onTap: () {
                                        controller.pickImage();
                                      },
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[400]),
                                        child: controller.image != null
                                            ? Image.file(controller.image!)
                                            : Image.asset(
                                                'assets/addimg.png',
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (controller.formKey.currentState!
                                        .validate()) {
                                      controller.add(
                                        controller.judulC.text,
                                        controller.isiC.text,
                                        controller.lokasiC.text,
                                        "${(listUser[index].data() as Map<String, dynamic>)["nama"]}",
                                        "${(listUser[index].data() as Map<String, dynamic>)["telp"]}",
                                        Get.arguments.toString(),
                                        datetime,
                                        0,
                                        auth.currentUser!.email,
                                      );
                                    }
                                  },
                                  child: const Text("Laporkan"),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
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
