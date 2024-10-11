import 'package:ekyc/application/theme/dimension.dart';
import 'package:flutter/material.dart';

abstract class MyDarkTheme {
  static final colorScheme = ColorScheme.fromSwatch(
      primarySwatch: primarySwatch, backgroundColor: white);
  static const primaryColor = Color(0xff54B435);
  static final primaryColorOpactiy50 = const Color(0xff54B435).withOpacity(0.5);
  static const textColor = Color(0xff111111);

  static const black = Color(0xff000000);
  static const blackOpacity50 =
      Color(0x80000000); // Colors.black.withOpacity(0.5);

  static const red125 = Color(0xffDF5454);
  static const red138 = Color(0xffF17004);
  static const red142 = Color(0xffFC7300);
  static const red143 = Color(0xffFC7304);

  static const greenOpacity14 = Color(0x0E39341A);
  static const green53 = Color(0xff32392D);
  static const green106 = Color(0xff54B435);
  static const green236 = Color(0xffDCF8DA);

  static const blue = Color(0xff2196F3); // Colors.blue
  static const vividBlue = Color(0xff4F46E5);
  static const brightBlue = Color(0xff60A5FA);
  static const blue77 = Color(0xff3E5262);
  static const blue108 = Color(0xff577287);
  static final blue108Opacity25 = const Color(0xff577287).withOpacity(0.25);
  static const blue112 = Color(0xff4D6A83); // had the same color as blue108
  static const blue209 = Color(0xffB5D9F9);
  static const blue234 = Color(0xffDBEEFF);
  static const blue225 = Color(0xffCFE6FA);
  static const skyBlue = Color(0xffEEF7FF);

  static const grey = Color(0xff9E9E9E);
  static const grey200 = Color(0xffEEEEEE); // Colors.grey[200]

  static const lightCyan = Color(0xffD2E9E9);

  static const white = Color(0xffffffff);

  static const MaterialColor primarySwatch = MaterialColor(
    0xff54b435,
    <int, Color>{
      50: Color(0xff4ca230),
      100: Color(0xff43902a),
      200: Color(0xff3b7e25),
      300: Color(0xff326c20),
      400: Color(0xff2a5a1b),
      500: Color(0xff224815),
      600: Color(0xff193610),
      700: Color(0xff11240b),
      800: Color(0xff081205),
      900: Color(0xff000000),
    },
  );
}

abstract class AppTextStyle {
  static const wNormalF12 = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: Dimension.k12,
  );

  static const wNormalF16 = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: Dimension.k16,
  );

  static const w400F14 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: Dimension.k14,
  );

  static const w400F16 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: Dimension.k16,
  );

  static const wBoldF16 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: Dimension.k16,
  );

  static const wBoldF18 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: Dimension.k18,
  );

  static const wBoldF20 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: Dimension.k20,
  );

  static const w400F20 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: Dimension.k20,
  );

  static const w400F24 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: Dimension.k24,
  );

  static const w500F14 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: Dimension.k14,
  );

  static const w600F18 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: Dimension.k18,
  );
}
