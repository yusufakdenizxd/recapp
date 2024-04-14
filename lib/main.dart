import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:recapp/app.dart';
import 'package:recapp/firebase_options.dart';
import 'package:recapp/src/core/auth.dart';
import 'package:recapp/src/core/local_notifications.dart';
import 'package:recapp/src/features/auth/domain/models/user_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalNotification.instance.setup();

  LocationPermission permission;

  //Lokasyon bilgisi için gerekli izinlerin alınması
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
  //Dikey kullanıma kilitleme
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  //Firebase kurulumu
  if (Firebase.apps.isEmpty) {
    try {
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    } catch (e, _) {
      debugPrint('$e $_');
    }
  }
  try {
    //Giriş yapmış bir kullanıcı var ise onun verisini çekimi
    if (FirebaseAuth.instance.currentUser != null) {
      user = UserModel.fromDocument(await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get());
    }
  } catch (e) {
    await FirebaseAuth.instance.signOut();
  }
  //Uygulamayı Başlatma
  runApp(const App());
}
