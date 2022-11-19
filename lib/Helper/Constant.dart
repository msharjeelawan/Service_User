import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mutwaffer_user/translations/locale_keys.g.dart';
class Constant {
  static String appTitle = LocaleKeys.Mutawaffer.tr();
  static String welcomeText = "Welcome to ";
  static String companyName="Mutwaffer";
  static String orderNote1="Don’t forget to rate Service Provider after getting job done.";
  static String orderNote2="Warranty only be valid if you receive Mutwaffer invoice from Service Provider after payment.";

  static double? _width, _height;

  static double getWidth(BuildContext context) {
    return _width ??= MediaQuery
        .of(context)
        .size
        .width;
  }

  static double getHeight(BuildContext context) {
    return _height ??= MediaQuery
        .of(context)
        .size
        .height;
  }

  static TextStyle whiteStyle=const TextStyle(color: Colors.white,);
  static Color containerBorderColor=const Color.fromRGBO(192, 0, 0, 1);
  static Color tileBGColor=const Color.fromRGBO(242, 242, 242, 1);
  static Color primaryColor=const Color.fromRGBO(88, 178, 64, 1);
  static Color tilelefttext=const Color.fromRGBO(82, 120, 192, 1);
  static Color leftCircleOnProfileScreen=const Color.fromRGBO(221, 234, 246, 1);
  static Color dashboardNotificationColor = const Color.fromRGBO(162, 64, 83, 1);
  static Color walletContainerBG=const Color.fromRGBO(225, 239, 216, 1);
  static Color starOrangeColor=const Color.fromRGBO(237, 125, 49, 1);
  static Color jobConfirmScreenContainerColor=const Color.fromRGBO(242, 242, 242, 1);
  static Color jobConfirmScreenContainerColor2=const Color.fromRGBO(247, 247, 247, 1);
  static Color black=Colors.black;
  static Color white=Colors.white;
}