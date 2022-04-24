import 'package:flutter/material.dart';


double screenWidth(context, {dividedBy = 1}) {
   return MediaQuery.of(context).size.width / dividedBy;
}

double screenHeight(context, {dividedBy = 1}) {
  return MediaQuery.of(context).size.height / dividedBy;
}

push(context, Widget route) {
  return Navigator.push(context, MaterialPageRoute(builder:(context) => route));
}

pop(context) {
  return Navigator.pop(context);
}