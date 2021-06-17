import 'package:flutter/material.dart';

///
const primaryColor = Color(0xFF26A69A);

///
const secondaryColor = Color(0xFFE8F5E9);

///
const LinearGradient postGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Colors.black26]);

///
ThemeData appTheme() => ThemeData(
      primaryColor: primaryColor,
      accentColor: secondaryColor,
      iconTheme: const IconThemeData(color: Colors.black, size: 30),
    );
