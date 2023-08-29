import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kopi_flutter/Kopi_Page.dart';
import 'package:kopi_flutter/Record_Page.dart';
import 'package:kopi_flutter/core/style.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kopi App',
      debugShowCheckedModeBanner: false,
      theme: Styles.themeDta(),
      initialRoute: '/kopi', // Atur halaman awal sesuai dengan halaman pertama yang akan ditampilkan.
      getPages: [
        GetPage(name: '/kopi', page: () => KopiPage()),
        GetPage(name: '/records', page: () => RecordPage()),
      ],
    );
  }
}
