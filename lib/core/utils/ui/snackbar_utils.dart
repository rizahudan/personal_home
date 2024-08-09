import 'package:flutter/material.dart';

void showSuccessSnackBar(BuildContext context) {
  final snackBar = SnackBar(
    content: const Text('Action was successful!'),
    backgroundColor:
        Theme.of(context).snackBarTheme.backgroundColor ?? Colors.greenAccent,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    margin: EdgeInsets.only(
      top: MediaQuery.of(context).padding.top + kToolbarHeight,
      left: 10,
      right: 10,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showFailureSnackBar(BuildContext context) {
  final snackBar = SnackBar(
    content: const Text('Action failed! Please try again.'),
    backgroundColor:
        Theme.of(context).snackBarTheme.backgroundColor ?? Colors.redAccent,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    margin: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + kToolbarHeight,
        left: 10,
        right: 10),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
