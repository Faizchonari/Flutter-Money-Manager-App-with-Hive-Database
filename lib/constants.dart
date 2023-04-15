import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

const Color primaryColor = Color(0xff1c1c1e);
const Color secondaryColor = Color(0xff8e8e93);
const Color accentColor = Color(0xff007aff);

final blackgradiant = Color.alphaBlend(
    Color.alphaBlend(
        primaryColor.withOpacity(0.6), secondaryColor.withOpacity(0.3)),
    accentColor.withOpacity(0.1));

Expanded emptyScreen(BuildContext context) {
  return Expanded(
      child: SizedBox(
    width: 350,
    child: Opacity(
        opacity: 0.6,
        child: Lottie.asset('images/empty.json', fit: BoxFit.contain)),
  ));
}
