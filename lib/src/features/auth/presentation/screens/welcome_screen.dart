import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recapp/src/core/context_extension.dart';
import 'package:recapp/src/features/auth/presentation/screens/auth_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width,
                height: 1,
              ),
              SizedBox(
                height: size.height * .5,
              ),
              //Get Started Butonu ve basıldığında kendi sayfasına yönlendirmesi
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => context
                      .pushReplacement(const AuthScreen(initialIndex: 1)),
                  child: Container(
                    width: size.width * .7,
                    height: size.height * .07,
                    decoration: BoxDecoration(
                      color: context.theme.primaryColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(48),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Get Started',
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //Login Butonu ve basıldığında kendi sayfasına yönlendirmesi
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => context
                      .pushReplacement(const AuthScreen(initialIndex: 0)),
                  child: Container(
                    width: size.width * .7,
                    height: size.height * .07,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: context.theme.primaryColor,
                        width: 1.8,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(48),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Login',
                        style: GoogleFonts.roboto(
                          color: context.theme.primaryColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          //Üstteki fotoğrafın widgetı
          Positioned(
            top: -size.height * .15,
            left: -size.width * .1,
            child: Image.asset(
              'assets/png/welcome.png',
              height: size.height * .7,
            ),
          ),
        ],
      ),
    );
  }
}
