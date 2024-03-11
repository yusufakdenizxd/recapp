import 'package:flutter/material.dart';
import 'package:recapp/src/core/global.dart';
import 'package:vibration/vibration.dart';

Future<String?> stringPicker({
  required String title,
  bool validate = true,
}) async {
  String? string;
  TextEditingController controller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  await showAdaptiveDialog(
    context: mainContext,
    builder: (context) => AlertDialog.adaptive(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
      actions: [
        TextButton(
          onPressed: () {
            string = null;
            Navigator.pop(context);
          },
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
          ),
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
        TextButton(
          onPressed: () {
            if (!formKey.currentState!.validate()) {
              Vibration.vibrate();
              return;
            }
            string = controller.text;
            Navigator.pop(context);
          },
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
          ),
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.black, fontSize: 16),
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
                child: SizedBox(
                  width: 240,
                  child: Material(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                    child: TextFormField(
                      controller: controller,
                      maxLines: null,
                      validator: (value) {
                        if (!validate) {
                          return null;
                        }

                        if (value == null || value.isEmpty) {
                          return "This field is required";
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                          alignLabelWithHint: true,
                          hintText: title,
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 187, 187, 193),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          labelStyle: const TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(23, 41, 51, 1),
                          ),
                          fillColor: Colors.white,
                          filled: true
                          // filled: true,
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
  return string;
}
