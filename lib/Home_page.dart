import 'package:flutter/material.dart';
import 'package:kopi_flutter/core/color.dart';
import 'package:kopi_flutter/core/text_style.dart';
import 'package:kopi_flutter/data/plants.dart';
import 'package:kopi_flutter/screens/input_form.dart';
import 'package:kopi_flutter/widgets/custom_app_bar.dart';
import 'package:kopi_flutter/widgets/item_card.dart';
import 'package:kopi_flutter/widgets/bar_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Stack(
          children: [
            Row(
              children: [
                BarMenu(),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 50, left: 35.0, right: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Green'),
                        Text(
                          'Plants',
                          style: headline1,
                        ),
                        Expanded(
                          child: Scrollbar(
                            thickness: 4,
                            child: ListView.builder(
                              itemCount: plants.length,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (itemBuilder, index) {
                                final plant = plants[index];
                                return PlantItemCard(
                                  plant: plant,
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
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 18.0),
        child: FloatingActionButton(
          onPressed: () => _showAnimatedDialog(context, InputForm()),
          backgroundColor: Colors.white,
          child: Icon(Icons.add, color: Color.fromARGB(255, 110, 56, 1)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartDocked,
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
