import 'package:flutter/material.dart';

class Apiconst{
  static const String baseurl="https://myluckynumber.in/admin/api/Mobile_app/";
  static const String baseurlphp="https://myluckynumber.in/api/";
  static const String versioncode="1.0.1";
  static const String Gamebet= baseurlphp+"betinsert.php";
  static const String Advancedraw= baseurlphp+"nextdraw.php";
  static const String MYmatch= baseurl+"battinghistory?";
  static const String Chart= baseurl+"result_bet?";
  static const String howtoplay= baseurl+"how_to_play";
  static const String referslider= baseurl+"slider_referral";
  static const String scrachcard= baseurl+"slider_sorry?";
  static const String transctionhistory= baseurl+"transhistory?user_id=";
  static const String refferalhistory= baseurl+"getcoupon?userid=";
  static const String reedemcode= baseurl+"changestatus?coupon=";
}

mixin AppConstant {
  static const Color titlecolor = Colors.white;
  static const Color subtitlecolor = Color.fromRGBO(166, 177, 187, 1);
  static const Color primaryColor = Color(0xFFffad00);
  static const Color secondaryColor = Color(0xFF272727);
  static const Color backgroundColor = Color(0xFF1e1e1e);
}
