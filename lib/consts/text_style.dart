import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

myStyle({double? size = 14, color = KPwhite,weight = FontWeight.normal}){
  return TextStyle(
      fontSize: size,
      color: color,
      fontWeight: weight
  );
}