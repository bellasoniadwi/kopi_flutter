import 'package:flutter/material.dart';
import 'package:kopi_flutter/core/color.dart';
import 'package:kopi_flutter/core/text_style.dart';
import 'package:kopi_flutter/data/menu.dart';
import 'package:kopi_flutter/widgets/clipper.dart';

class BarMenu extends StatefulWidget {
  const BarMenu({Key? key}) : super(key: key);

  @override
  _BarMenuState createState() => _BarMenuState();
}

class _BarMenuState extends State<BarMenu> {
  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85.0,
      color: brown,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < menuItems.length; i++)
            menuButton(
              text: menuItems[i].name,
              onTap: () {
                setState(() {
                  selectIndex = i;
                });
              },
              index: i,
            ),
        ],
      ),
    );
  }

  Widget menuButton({
    required String text,
    required int index,
    required Function() onTap,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        RotatedBox(
          quarterTurns: 3,
          child: Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: TextButton(
              onPressed: onTap,
              child: Text(
                text,
                style: buttonText,
              ),
            ),
          ),
        ),
        selectIndex == index
            ? RotatedBox(
                quarterTurns: 2,
                child: ClipPath(
                  clipper: CustomMenuClip(),
                  child: Container(
                    width: 35,
                    height: 110,
                    color: white,
                    child: Center(
                      child: CircleAvatar(
                        backgroundColor: brown,
                        radius: 3,
                      ),
                    ),
                  ),
                ),
              )
            : SizedBox(
                width: 35,
                height: 110,
              ),
      ],
    );
  }
}
