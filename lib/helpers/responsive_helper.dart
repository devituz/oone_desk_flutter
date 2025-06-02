import 'package:flutter/cupertino.dart';

class ScreenSize {
  final BuildContext context;
  late double width;
  late double height;

  ScreenSize(this.context) {
    final size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
  }

  bool get isSmall => width < 600;
  bool get isMedium => width >= 600 && width < 1024;
  bool get isLarge => width >= 1024;

  double wp(double percent) => width * percent;  // width percentage
  double hp(double percent) => height * percent; // height percentage
}