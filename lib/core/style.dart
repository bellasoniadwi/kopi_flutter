import 'package:flutter/material.dart';
import 'package:kopi_flutter/core/color.dart';

class Styles {
  static ThemeData themeDta() {
    return ThemeData(
      primaryColor: Colors.brown,
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: MaterialStateProperty.all(brown.withOpacity(0.5)),
        isAlwaysShown: true,
        mainAxisMargin: 200,
        radius: Radius.circular(50.0),
      ),
    );
  }
}
