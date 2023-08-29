import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:kopi_flutter/Kopi_Page.dart';
import 'package:kopi_flutter/Record_Page.dart';
import 'package:kopi_flutter/auth/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:kopi_flutter/core/style.dart';
import 'package:kopi_flutter/data/user_data.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final bool isLoggedIn = await checkLoggedInStatus();
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserData()),
      ],
      child: GetMaterialApp(
      title: 'Kopi App',
      debugShowCheckedModeBanner: false,
      theme: Styles.themeDta(),
      // initialRoute: '/kopi', // Atur halaman awal sesuai dengan halaman pertama yang akan ditampilkan.
      getPages: [
        GetPage(name: '/kopi', page: () => KopiPage()),
        GetPage(name: '/records', page: () => RecordPage()),
      ],
      home: isLoggedIn ? KopiPage() : SignInScreen(),
    ),
    );
  }
}

Future<bool> checkLoggedInStatus() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
}