import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kopi_flutter/core/color.dart';
import 'package:kopi_flutter/core/space.dart';
import 'package:kopi_flutter/core/text_style.dart';
import 'package:kopi_flutter/screens/input_form.dart';
import 'package:kopi_flutter/widgets/custom_app_bar.dart';
import 'package:kopi_flutter/widgets/bar_menu.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({Key? key}) : super(key: key);

  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  final CollectionReference _kopis =
      FirebaseFirestore.instance.collection('kopis');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: StreamBuilder(
          stream: _kopis.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return SafeArea(
                child: Stack(
                  children: [
                    Row(
                      children: [
                        BarMenu(),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 50, left: 35.0, right: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Catatan Record'),
                                Text(
                                  'Pemantauan Kopi',
                                  style: headline1,
                                ),
                                Expanded(
                                  child: Scrollbar(
                                    thickness: 4,
                                    child: ListView.builder(
                                      itemCount:
                                          streamSnapshot.data!.docs.length,
                                      physics: BouncingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        // final plant = plants[index];
                                        final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                                        return InkWell(
                                          onTap: () {
                                            // Navigator.push(context,
                                            //   MaterialPageRoute(
                                            //     builder: (builder) =>
                                            //       DetailsPage(documentSnapshot: documentSnapshot),));
                                          },
                                          child: Container(
                                            height: 400.0,
                                            margin:
                                                EdgeInsets.only(right: 10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Image.network(
                                                  documentSnapshot['foto'],
                                                  height: 250.0,
                                                ),
                                                SpaceVH(height: 20.0),
                                                Text(
                                                  documentSnapshot['jenis'],
                                                  style: headline2,
                                                ),
                                                SpaceVH(height: 5.0),
                                                Text(
                                                  documentSnapshot['deskripsi'],
                                                  maxLines: 5,
                                                  textAlign: TextAlign.justify,
                                                ),
                                                SpaceVH(height: 20.0),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // Text(
                                                    //   plant.price,
                                                    //   style: headline2,
                                                    // ),
                                                    // SpaceVH(width: 20.0),
                                                    // Container(
                                                    //   height: 20.0,
                                                    //   width: 20.0,
                                                    //   decoration: BoxDecoration(
                                                    //     color: white,
                                                    //     shape: BoxShape.circle,
                                                    //     boxShadow: [
                                                    //       BoxShadow(
                                                    //         color: black
                                                    //             .withOpacity(
                                                    //                 0.3),
                                                    //         blurRadius: 10.0,
                                                    //         offset:
                                                    //             Offset(1, 6),
                                                    //       ),
                                                    //     ],
                                                    //   ),
                                                    //   child: Icon(
                                                    //     Icons.add,
                                                    //     size: 10.0,
                                                    //   ),
                                                    // )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    CustomAppBar(),
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 18.0),
        child: FloatingActionButton(
          onPressed: () => _showAnimatedDialog(context, InputForm()),
          backgroundColor: Colors.white,
          child: Icon(Icons.add, color: Color.fromARGB(255, 110, 56, 1)),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniStartDocked,
    );
  }

  void _showAnimatedDialog(BuildContext context, var val) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: val,
          );
        });
  }
}
