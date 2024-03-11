import 'package:flutter/material.dart';
import 'package:recapp/src/core/context_extension.dart';
import 'package:recapp/src/core/global.dart';
import 'package:vibration/vibration.dart';

Future<double?> doublePicker({
  required String title,
  double? max,
  double? initial,
}) async {
  double? ret;
  final TextEditingController controller = TextEditingController(text: initial == null ? "" : initial.toString());
  final GlobalKey<FormState> formKey = GlobalKey();
  await showDialog(
    context: mainContext,
    builder: (context) => AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
      title: Text(
        title,
        style: TextStyle(color: mainContext.theme.primaryColor),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: mainContext.theme.primaryColor),
          onPressed: () {
            ret = null;
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: mainContext.theme.primaryColor),
          onPressed: () {
            if (!formKey.currentState!.validate()) {
              Vibration.vibrate();
              return;
            }
            ret = double.parse(controller.text);
            Navigator.pop(context);
          },
          child: const Text(
            'Ok',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ],
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controller,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                  decoration: InputDecoration(
                    floatingLabelStyle: TextStyle(
                      fontSize: 14,
                      color: mainContext.theme.primaryColor,
                    ),
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: mainContext.theme.primaryColor,
                    ),
                    focusColor: mainContext.theme.primaryColor,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: mainContext.theme.primaryColor),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: mainContext.theme.primaryColor),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: mainContext.theme.primaryColor),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Bu Alan Gerekli";
                    }
                    double? temp = double.tryParse(value);
                    if (temp == null) {
                      return "Bu Alan'a Tam Sayı Giriniz";
                    }
                    if (max != null && temp > max) {
                      return "Maksimum Adetten ${temp - max} adet fazla";
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
  return ret;
}
