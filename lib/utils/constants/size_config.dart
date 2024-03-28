import 'package:flutter/material.dart';

class SizeConfig {
  static getSpace({
    double? height = 20,
    double? width,
  }) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
