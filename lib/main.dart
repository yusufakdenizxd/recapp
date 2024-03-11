import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:recapp/app.dart';
import 'package:recapp/src/core/auth.dart';
import 'package:recapp/src/features/auth/domain/models/user_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocationPermission permission;

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  if (Firebase.apps.isEmpty) {
    try {
      await Firebase.initializeApp();
    } catch (e, _) {
      debugPrint('$e $_');
    }
  }
  try {
    if (FirebaseAuth.instance.currentUser != null) {
      user = UserModel.fromDocument(await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get());
    }
  } catch (e) {
    await FirebaseAuth.instance.signOut();
  }

  runApp(const App());
}
