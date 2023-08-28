import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kopi_flutter/core/color.dart';
import 'package:kopi_flutter/pages/details_page.dart';

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
                scanQR(context); // Panggil fungsi scanQR dengan melewatkan context
              },
              child: SvgPicture.asset(
                'assets/icon/scan.svg',
                height: 70.0,
                color: white,
              ),
            ),
          ),
          // TextButton(
          //   onPressed: () {},
          //   child: SvgPicture.asset(
          //     'assets/icon/search.svg',
          //     height: 25.0,
          //   ),
          // ),
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
            content: Text('QR Code tidak valid', textAlign: TextAlign.center,),
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
