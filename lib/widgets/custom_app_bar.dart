import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kopi_flutter/auth/signin_screen.dart';
import 'package:kopi_flutter/core/color.dart';
import 'package:kopi_flutter/pages/details_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(top: 18.0),
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () {
                scanQR(
                    context); // Panggil fungsi scanQR dengan melewatkan context
              },
              child: SvgPicture.asset(
                'assets/icon/scan.svg',
                height: 70.0,
                color: white,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 18.0),
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                prefs.remove('isLoggedIn'); // Hapus status login saat logout
                print("Signed Out");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignInScreen()));
              },
              child: SvgPicture.asset(
                'assets/icon/logout.svg',
                height: 70.0,
                color: Color.fromARGB(255, 110, 56, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> scanQR(BuildContext context) async {
  try {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666',
      'Cancel',
      true,
      ScanMode.QR,
    );

    if (barcodeScanRes.contains('//')) {
      // Barcode tidak sesuai, tampilkan pesan kesalahan
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(
              'QR Code tidak valid',
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Redirect to the detail page with the scanned document ID
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsPage(
            scannedId: barcodeScanRes,
          ),
        ),
      );
    }
  } on PlatformException {
    // Handle platform exception
  }
}
