import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:kopi_flutter/core/color.dart';
import 'package:kopi_flutter/core/space.dart';
import 'package:kopi_flutter/core/text_style.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsRecord extends StatefulWidget {
  final DocumentSnapshot? documentSnapshot;
  const DetailsRecord({Key? key, this.documentSnapshot}) : super(key: key);

  @override
  _DetailsRecordState createState() => _DetailsRecordState();
}

class _DetailsRecordState extends State<DetailsRecord> {
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
              height: height / 1.5,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(200.0),
                ),
              ),
            ),
          ),
          // Align(
          //   alignment: Alignment.topRight,
          //   child: Container(
          //     height: 30.0,
          //     width: 30.0,
          //     margin: EdgeInsets.only(right: 10.0, top: 20.0),
          //     decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: brown,
          //     ),
          //     child: Icon(
          //       Icons.favorite_border_outlined,
          //       color: white,
          //       size: 18.0,
          //     ),
          //   ),
          // ),
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100.0,
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
                            maxLines: 2,
                          ),
                          SpaceVH(height: 20.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 120.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SvgPicture.asset(
                          'assets/icon/clock.svg',
                          height: 30.0,
                          color: white,
                        ),
                        SpaceVH(height: 15.0),
                        Text(
                          'Waktu',
                          style: headline3,
                        ),
                        SpaceVH(height: 5.0),
                        Text(
                          _getFormattedTimestamp(
                              widget.documentSnapshot?['timestamps']),
                          style: headline4,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            final latitude =
                                widget.documentSnapshot?['latitude'];
                            final longitude =
                                widget.documentSnapshot?['longitude'];
                            final url =
                                'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
                            launch(url);
                          },
                          child: SvgPicture.asset(
                            'assets/icon/location.svg',
                            height: 30.0,
                            color: white,
                          ),
                        ),
                        SpaceVH(height: 15.0),
                        Text(
                          'Lokasi',
                          style: headline3,
                        ),
                        SpaceVH(height: 5.0),
                        Text(
                          widget.documentSnapshot?['latitude'] +
                              ', ' +
                              widget.documentSnapshot?['longitude'],
                          style: headline4,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getFormattedTimestamp(Timestamp? timestamp) {
    if (timestamp == null) {
      // Handle the case when 'timestamps' is null, set a default value or return an empty string
      return 'No Timestamp';
    }
    // Convert the Timestamp to DateTime
    DateTime dateTime = timestamp.toDate();
    // Format the DateTime as a human-readable string (change the format as desired)
    String formattedDateTime =
        DateFormat('dd-MM-yyyy  HH:mm:ss').format(dateTime);
    return formattedDateTime;
  }
}
