import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kopi_flutter/Home_page.dart';
import 'package:kopi_flutter/core/style.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kopi App',
      debugShowCheckedModeBanner: false,
      theme: Styles.themeDta(),
      home: HomePage(),
    );
  }
}
