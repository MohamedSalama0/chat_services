
import 'package:flutter/material.dart';

void pushReplacement(context, screen) {
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ));
}
void push(context, screen) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ));
}