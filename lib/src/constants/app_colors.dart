
import 'package:flutter/material.dart';

class MainColors {
  static const primary = Color(0xFF246BFD);
  static const secondary = Color(0xFFFFD300);
}

class AlertStatusColors {
  static const success = Color(0xFF07BD74);
  static const info = Color(0xFF246BFD);
  static const warning = Color(0xFFFACC15);
  static const error = Color(0xFFF75555);
  static const disabled = Color(0xFFD8D8D8);
  static const disabledButton = Color(0xFF3062C8);
}

class GreyScaleColors {
  static const grey900 = Color(0xFF212121);
  static const grey800 = Color(0xFF424242);
  static const grey700 = Color(0xFF616161);
  static const grey600 = Color(0xFF757575);
  static const grey500 = Color(0xFF9E9E9E);
  static const grey400 = Color(0xFFBDBDBD);
  static const grey300 = Color(0xFFE0E0E0);
  static const grey200 = Color(0xFFEEEEEE);
  static const grey100 = Color(0xFFF5F5F5);
  static const grey50 = Color(0xFFFAFAFA);
}

class GradientsColors {
  static const gradientBlue = LinearGradient(colors: [MainColors.primary, Color(0xFF5089FF)],begin: Alignment.topLeft,end: Alignment.bottomRight);
  static const gradientYellow = LinearGradient(colors: [AlertStatusColors.warning, Color(0xFFFFE580)],begin: Alignment.topLeft,end: Alignment.bottomRight);
  static const gradientGreen = LinearGradient(colors: [MainColors.primary, Color(0xFF35DEBC)],begin: Alignment.topLeft,end: Alignment.bottomRight);
  static const gradientOrange = LinearGradient(colors: [MainColors.primary, Color(0xFFFFAB38)],begin: Alignment.topLeft,end: Alignment.bottomRight);
  static const gradientRed = LinearGradient(colors: [MainColors.primary, Color(0xFFFF8A9B)],begin: Alignment.topLeft,end: Alignment.bottomRight);
}

class DarkColors {
  static const dark1 = Color(0xFF181A20);
  static const dark2 = Color(0xFF1F222A);
  static const dark3 = Color(0xFF35383F);
}

class OtherColors {
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const transparent = Colors.transparent;
  static const red = Color(0xFFF44336);
  static const pink = Color(0xFFE91E63);
  static const purple = Color(0xFF9C27B0);
  static const deepPurple = Color(0xFF673AB7);
  static const indigo = Color(0xFF3F51B5);
  static const blue = Color(0xFF2196F3);
  static const lightBlue = Color(0xFF03A9F4);
  static const cyan = Color(0xFF00BCD4);
  static const teal = Color(0xFF009688);
  static const green = Color(0xFF4CAF50);
  static const lightGreen = Color(0xFF8BC34A);
  static const lime = Color(0xFFCDDC39);
  static const yellow = Color(0xFFFFEB38);
  static const amber = Color(0xFFFFC107);
  static const orange = Color(0xFFFF9800);
  static const deepOrange = Color(0xFFFF5722);
  static const brown = Color(0xFF795548);
  static const blueGray = Color(0xFF607D8B);
}

class BackgroundColors {
  static const blue = Color(0xFFEEF4FF);
  static const green = Color(0xFFF2FFFC);
  static const orange = Color(0xFFFFF8ED);
  static const pink = Color(0xFFFFF5F5);
  static const yellow = Color(0xFFFFFEE0);
  static const purple = Color(0xFFFCF4FF);
}

class TransparentColors {
  static Color blue = MainColors.primary.withAlpha(10);
  static Color orange = OtherColors.orange.withAlpha(10);
  static Color yellow = AlertStatusColors.warning.withAlpha(10);
  static Color red = AlertStatusColors.error.withAlpha(10);
  static Color green = OtherColors.green.withAlpha(10);
  static Color purple = OtherColors.purple.withAlpha(10);
  static Color cyan = OtherColors.cyan.withAlpha(10);
}
