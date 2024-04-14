import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recapp/src/core/auth.dart' as a;
import 'package:recapp/src/core/context_extension.dart';
import 'package:recapp/src/core/popups.dart';
import 'package:recapp/src/core/snackbar.dart';
import 'package:recapp/src/features/auth/domain/models/user_model.dart';
import 'package:recapp/src/features/home/presentation/screens/home_screen.dart';
import 'package:vibration/vibration.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordCheckController = TextEditingController();

  bool obsecurePassword1 = true;
  bool obsecurePassword2 = true;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * .1,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .09),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Become a part of the future',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 18.0,
                      bottom: 8.0,
                    ),
                    child: Container(
                      height: size.height * .07,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == '' || value == null) {
                            return "This Field is Required";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: const Icon(
                            Icons.mail_outline,
                            color: Color(0xFF707070),
                            size: 28,
                          ),
                          label: Text(
                            'E-Mail',
                            style: GoogleFonts.roboto(
                              color: const Color(0xFF707070),
                              fontSize: 20,
                            ),
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(6),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15.0,
                      bottom: 8.0,
                    ),
                    child: Container(
                      height: size.height * .07,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: StatefulBuilder(
                        builder: (context, __) {
                          return TextFormField(
                            obscureText: obsecurePassword1,
                            controller: passwordController,
                            validator: (value) {
                              if (value == '' || value == null) {
                                return "This Field is Required";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: const Icon(
                                Icons.lock_outline,
                                color: Color(0xFF707070),
                                size: 28,
                              ),
                              label: Text(
                                'Password',
                                style: GoogleFonts.roboto(
                                  color: const Color(0xFF707070),
                                  fontSize: 20,
                                ),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  obsecurePassword1 = !obsecurePassword1;
                                  __(() {});
                                },
                                child: Icon(
                                  obsecurePassword1 ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                  color: const Color(0xFF707070),
                                  size: 28,
                                ),
                              ),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(6),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15.0,
                      bottom: 8.0,
                    ),
                    child: Container(
                      height: size.height * .07,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: StatefulBuilder(
                        builder: (context, __) {
                          return TextFormField(
                            validator: (value) {
                              if (value == '' || value == null) {
                                return "This Field is Required";
                              }
                              if (value != passwordController.text) {
                                return "All Password Should Be Same";
                              }
                              return null;
                            },
                            obscureText: obsecurePassword2,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: const Icon(
                                Icons.lock_outline,
                                color: Color(0xFF707070),
                                size: 28,
                              ),
                              label: Text(
                                'Repeat Password',
                                style: GoogleFonts.roboto(
                                  color: const Color(0xFF707070),
                                  fontSize: 20,
                                ),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  obsecurePassword2 = !obsecurePassword2;
                                  __(() {});
                                },
                                child: Icon(
                                  obsecurePassword2 ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                  color: const Color(0xFF707070),
                                  size: 28,
                                ),
                              ),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(6),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 38.0),
                    child: GestureDetector(
                      onTap: () async {
                        if (formKey.currentState?.validate() != true) {
                          Vibration.vibrate();
                          return;
                        }
                        Popup.showLoadingScreen();
                        try {
                          final res = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                          final user = UserModel(
                            id: res.user!.uid,
                            coin: 0,
                            username: emailController.text.split('@')[0],
                            email: emailController.text,
                            password: passwordController.text,
                            xp: 0,
                          );
                          await FirebaseFirestore.instance.collection('users').doc(res.user!.uid).set(user.toFirestore());
                          a.user = user;
                        } on FirebaseAuthException catch (e) {
                          context.pop();
                          Snackbar.showError(e.message ?? "An Error Occured");
                          return;
                        }
                        context.pop();
                        context.pushReplacement(const HomeScreen());
                      },
                      child: Center(
                        child: Container(
                          width: size.width * .7,
                          height: size.height * .055,
                          decoration: BoxDecoration(
                            color: context.theme.primaryColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(48),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Join the Community',
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'By creating an account, you agree to RecApp ',
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                            text: 'Terms of use ',
                            style: GoogleFonts.roboto(
                              color: const Color(0xFF4d8d6e),
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                            text: 'and ',
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                            text: 'Privacy policy.',
                            style: GoogleFonts.roboto(
                              color: const Color(0xFF4d8d6e),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
