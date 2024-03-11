import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recapp/src/core/global.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> photoPicker({
  required String title,
  List<int> alternatives = const [0, 1],
}) async {
  File? file;
  final picker = ImagePicker();
  await showModalBottomSheet(
    context: mainContext,
    builder: (context) {
      return Container(
        color: Colors.grey.shade200,
        height: 200,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22, fontFamily: 'Nanum', color: Colors.black),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  if (alternatives.contains(0))
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.add_a_photo_rounded,
                                size: 32,
                                color: Colors.grey,
                              ),
                              onPressed: () async {
                                XFile? newFile = await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
                                if (newFile == null) {
                                  return;
                                }
                                file = File(newFile.path);
                                Navigator.pop(context);
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Kamera',
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  if (alternatives.contains(1))
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.photo_library,
                                size: 32,
                                color: Colors.grey,
                              ),
                              onPressed: () async {
                                XFile? newFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
                                if (newFile == null) {
                                  return;
                                }
                                file = File(newFile.path);
                                Navigator.pop(context);
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Galeri',
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
  return file;
}
