
import 'package:flutter/material.dart';
import 'package:saturn/utils/sizes.dart';
import 'package:saturn/utils/themes.dart';

Widget customCard({Widget? child, color}) {
  return Padding(
    padding: EdgeInsets.only(
      left: .007*screenWidth,
      right: .007*screenWidth
    ),
    child: Card(
      color: color ?? Darkmode.cardBackground,
      shadowColor: Darkmode.darkPurple,
      elevation: 30,
      child: child,
    )
  );
}