import 'package:flutter/material.dart';

class TailleConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenH;
  static late double screenW;
  static late double defaultSize;
  static late Orientation orienation;
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenH = _mediaQueryData.size.height;
    screenW = _mediaQueryData.size.width;
  }
}

double screenProportionGetHeight(double screenHeight) {
  double ecranH = TailleConfig.screenH;
  return (screenHeight / 812.0) * ecranH;
}

double screenProportionGetWidht(double screenHeight) {
  double ecranH = TailleConfig.screenW;
  return (screenHeight / 375.0) * ecranH;
}
