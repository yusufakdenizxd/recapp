import 'package:flutter/material.dart';
import 'package:recapp/src/core/context_extension.dart';
import 'package:recapp/src/core/global.dart';

Future<int?> selectionPicker({required List<String> data, required String title}) async {
  int? res;

  await showDialog(
    context: mainContext,
    builder: (context) => AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
      title: Text(
        title,
        style: TextStyle(color: mainContext.theme.primaryColor),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < data.length; i++)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    res = i;
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(),
                    ),
                    height: 80,
                    width: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data[i],
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    ),
  );
  return res;
}
