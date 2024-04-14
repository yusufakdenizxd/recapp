import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recapp/src/core/auth.dart';
import 'package:recapp/src/core/context_extension.dart';
import 'package:recapp/src/core/popups.dart';
import 'package:recapp/src/core/snackbar.dart';
import 'package:recapp/src/features/auth/domain/models/user_model.dart';
import 'package:recapp/src/features/home/presentation/screens/home_screen.dart';
import 'package:vibration/vibration.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obsecurePassword = true;
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
                    'Login your account',
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
                            controller: passwordController,
                            validator: (value) {
                              if (value == '' || value == null) {
                                return "This Field is Required";
                              }
                              return null;
                            },
                            obscureText: obsecurePassword,
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
                                  obsecurePassword = !obsecurePassword;
                                  __(() {});
                                },
                                child: Icon(
                                  obsecurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
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
                  GestureDetector(
                    onTap: () async {
                      if (emailController.text == '') {
                        Vibration.vibrate();
                        Snackbar.showError('Email is required');
                        return;
                      }
                      try {
                        await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);

                        Snackbar.show('Please check your inbox');
                      } on FirebaseAuthException catch (e) {
                        Snackbar.showError(e.message ?? "An Error Occured");
                        return;
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(
                        top: 18.0,
                      ),
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Color(0xFF707070),
                        ),
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
                          await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                          user = UserModel.fromDocument(await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get());
                        } on FirebaseAuthException catch (e) {
                          context.pop();
                          Snackbar.showError(e.message ?? "An Error Occured");
                          return;
                        }
                        context.pop();
                        context.push(const HomeScreen());
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
                              'Login',
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
