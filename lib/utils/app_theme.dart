import 'package:flutter/material.dart';
import 'constants.dart';

///
const primaryColor = Color(0xFF26A69A);

///
const secondaryColor = Color(0xFFE8F5E9);

///
const blackColor = Color(0xDD000000);

///
const whiteColor = Color(0xFFFFFFFF);

///
const LinearGradient postGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Colors.black26]);

///
ThemeData appTheme() => ThemeData(
      primaryColor: primaryColor,
      primaryColorLight: whiteColor,
      primaryColorDark: blackColor,
      accentColor: secondaryColor,
      iconTheme: const IconThemeData(color: blackColor, size: Constants.thirty),
    );
