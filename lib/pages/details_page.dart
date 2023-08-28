import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kopi_flutter/core/color.dart';
import 'package:kopi_flutter/core/space.dart';
import 'package:kopi_flutter/core/text_style.dart';

class DetailsPage extends StatefulWidget {
  final DocumentSnapshot? documentSnapshot;

  const DetailsPage({Key? key, this.documentSnapshot}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
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
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: black,
          ),
        ),
      ),
      body: Stack(
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
                        widget.documentSnapshot?['foto'],
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
                              widget.documentSnapshot?['jenis'],
                              style: headline1,
                            ),
                            SpaceVH(height: 5.0),
                            Text(
                              widget.documentSnapshot?['deskripsi'],
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
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Container(
          //     height: 150.0,
          //     child: Padding(
          //       padding: const EdgeInsets.only(left: 20, right: 20),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             widget.documentSnapshot?['deskripsi'],
          //             maxLines: 5,
          //             style: TextStyle(
          //                 color: Colors.white,
          //                 fontWeight: FontWeight.bold,
          //                 fontSize: 15),
          //             textAlign: TextAlign.justify,
          //           ),
          //           SpaceVH(height: 20.0),
          //         ],
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  Widget bottomTag({
    required String text,
    required String image,
    required String headingText,
  }) {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/icon/$image',
          height: 30.0,
          color: white,
        ),
        SpaceVH(height: 15.0),
        Text(
          headingText,
          style: headline3,
        ),
        SpaceVH(height: 5.0),
        Text(
          text,
          style: headline4,
        ),
      ],
    );
  }
}
