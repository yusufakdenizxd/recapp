import 'package:flutter/material.dart';

Widget Function(Object, StackTrace) errorHandler = (p0, p1) {
  debugPrint("$p0 \n $p1");
  return const Center(
    child: Text(
      "Bir Hata Oluştu",
      style: TextStyle(
        color: Colors.red,
      ),
    ),
  );
};
