import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recapp/src/core/global.dart';
import 'package:recapp/src/features/auth/presentation/screens/welcome_screen.dart';
import 'package:recapp/src/features/home/presentation/screens/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        navigatorKey: navigatorKey,
        theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF4d8d6e),
            primary: const Color(0xFF4d8d6e),
            background: const Color(0xFFF5F5F5),
          ),
          useMaterial3: false,
        ),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return const HomeScreen();
            }
            return const WelcomeScreen();
          },
        ),
      ),
    );
  }
}
