import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kopi_flutter/Kopi_Page.dart';
import 'package:kopi_flutter/core/color.dart';
import 'package:kopi_flutter/core/space.dart';
import 'package:kopi_flutter/core/text_style.dart';

class DetailsPage extends StatefulWidget {
  final String? scannedId;

  const DetailsPage({Key? key, this.scannedId}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  CollectionReference _kopis = FirebaseFirestore.instance.collection('kopis');
  Stream<DocumentSnapshot>? _kopiStream;

  @override
  void initState() {
    super.initState();
    _kopiStream = _kopis.doc(widget.scannedId!).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Get.toNamed('/kopi');
          },
          icon: Icon(
            Icons.arrow_back,
            color: black,
          ),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot?>(
          stream: _kopiStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Error fetching data: ${snapshot.error}'),
              );
            }

            if (!snapshot.hasData) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Error'),
                    content: Text('Barcode tidak sesuai',
                        textAlign: TextAlign.center),
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
              return KopiPage();
            }

            DocumentSnapshot documentSnapshot = snapshot.data!;
            if (!documentSnapshot.exists) {
              Future.delayed(Duration.zero, () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Error'),
                      content: Text(
                        'Data dengan ID ${widget.scannedId} tidak ditemukan!',
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
              });
              return KopiPage();
            }

            String jenis = documentSnapshot['jenis'] ?? '';
            String deskripsi = documentSnapshot['deskripsi'] ?? '';
            String foto = documentSnapshot['foto'] ?? '';

            return Stack(
              children: [
                Container(
                  height: height,
                  color: brown,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: height / 1.3,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(200.0),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    margin: EdgeInsets.only(right: 10.0, top: 20.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: brown,
                    ),
                    child: Icon(
                      Icons.favorite_border_outlined,
                      color: white,
                      size: 18.0,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Container(
                        height: height / 2.2,
                        child: PageView(
                          physics: BouncingScrollPhysics(),
                          children: [
                            Image.network(
                              foto ?? '',
                              height: height / 2.2,
                            )
                          ],
                        ),
                      ),
                      SpaceVH(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 70.0,
                              child: Column(
                                children: [],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    jenis ?? '',
                                    style: headline1,
                                  ),
                                  SpaceVH(height: 5.0),
                                  Text(
                                    deskripsi ?? '',
                                    maxLines: 5,
                                    textAlign: TextAlign.justify,
                                  ),
                                  SpaceVH(height: 5.0),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
