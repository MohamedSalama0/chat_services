import 'package:flutter/material.dart';

void showMySnackbar(String message, context) {
  final SnackBar snackBar = SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text(message)],
    ),
    behavior: SnackBarBehavior.floating,
  );
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(snackBar);
}
