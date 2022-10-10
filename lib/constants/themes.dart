import 'package:flutter/material.dart';
import '../components/colors/colors.dart';

class ThemeStyle {
  static ThemeData themeData(bool darkThemeOk, BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: darkThemeOk ? kWhiteColor : kBlackColor,
      primaryColor: kGreen,
      colorScheme: ThemeData().colorScheme.copyWith(
          secondary: darkThemeOk ? kGreen : kBlackColor,
          brightness: darkThemeOk ? Brightness.light : Brightness.light),
      cardColor: darkThemeOk ? kWhiteColor : kBlackColor,
      canvasColor: darkThemeOk ? kWhiteColor : kBlackColor,
    );
  }
}
