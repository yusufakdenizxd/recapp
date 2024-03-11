import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;

import 'global.dart';

class Snackbar {
  static void show(
    String message, {
    String? title,
    int time = 2,
    Color color = const Color(0xFF303030),
  }) async {
    await Flushbar(
      flushbarStyle: FlushbarStyle.GROUNDED,
      messageSize: 18,
      title: title,
      backgroundColor: color,
      message: message,
      duration: Duration(seconds: time),
    ).show(mainContext);
  }

  static void showError(
    String error, {
    String? title,
    int time = 2,
  }) async {
    await Flushbar(
      flushbarStyle: FlushbarStyle.GROUNDED,
      messageSize: 18,
      title: title,
      backgroundColor: Colors.red,
      message: error,
      duration: Duration(seconds: time),
    ).show(mainContext);
  }
}
