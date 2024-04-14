import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recapp/src/core/auth.dart';
import 'package:recapp/src/core/context_extension.dart';
import 'package:recapp/src/core/popups.dart';
import 'package:recapp/src/core/string_picker.dart';
import 'package:recapp/src/features/about_us/presentation/screens/about_us_screen.dart';
import 'package:recapp/src/features/auth/presentation/screens/auth_screen.dart';
import 'package:recapp/src/features/coupons/presentation/screens/coupons_screen.dart';
import 'package:recapp/src/features/gallery/presentation/screens/gallery_screen.dart';
import 'package:recapp/src/features/profile/presentation/screens/profile_screen.dart';
import 'package:vibration/vibration.dart';

class DrawerWidget extends ConsumerWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = context.mediaQuery.size;
    return Drawer(
      child: Column(
        children: [
          Container(
            height: context.mediaQuery.viewPadding.top,
            color: context.theme.primaryColor,
          ),
          Container(
            height: size.height * .09,
            color: context.theme.primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('users').doc(user!.id).snapshots(),
                      builder: (context, snapshot) {
                        String username = snapshot.data?['username'] ?? user?.username ?? 'An Error Occured';
                        return Row(
                          children: [
                            Text(
                              username,
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                final str = await stringPicker(title: 'New Username', validate: true);
                                if (str == null) {
                                  Vibration.vibrate();
                                  return;
                                }
                                await FirebaseFirestore.instance.collection('users').doc(user!.id).update({'username': str});
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Scaffold.of(context).closeEndDrawer(),
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Scaffold.of(context).closeEndDrawer();
              context.push(const CouponsScreen());
            },
            child: SizedBox(
              height: size.height * .09,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(
                      FontAwesomeIcons.ticket,
                      color: context.theme.primaryColor,
                      size: 36,
                    ),
                  ),
                  SizedBox(
                    width: size.width * .05,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Text(
                        'Coupons',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            thickness: 4,
            height: 4,
          ),
          InkWell(
            onTap: () {
              Scaffold.of(context).closeEndDrawer();
              context.push(const ProfileScreen());
            },
            child: SizedBox(
              height: size.height * .09,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(
                      Icons.table_chart,
                      color: context.theme.primaryColor,
                      size: 36,
                    ),
                  ),
                  SizedBox(
                    width: size.width * .05,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Text(
                        'EXP / Chart',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            thickness: 4,
            height: 4,
          ),
          InkWell(
            onTap: () {
              Scaffold.of(context).closeEndDrawer();
              context.push(const GalleryScreen());
            },
            child: SizedBox(
              height: size.height * .09,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(
                      Icons.photo_album,
                      color: context.theme.primaryColor,
                      size: 36,
                    ),
                  ),
                  SizedBox(
                    width: size.width * .05,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Text(
                        'Gallery',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            thickness: 4,
            height: 4,
          ),
          InkWell(
            onTap: () {
              Scaffold.of(context).closeEndDrawer();
              context.push(const AboutUsScreen());
            },
            child: SizedBox(
              height: size.height * .09,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(
                      Icons.info,
                      color: context.theme.primaryColor,
                      size: 36,
                    ),
                  ),
                  SizedBox(
                    width: size.width * .05,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Text(
                        'About Us',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            thickness: 4,
            height: 4,
          ),
          const Expanded(
            child: SizedBox(),
          ),
          // const Divider(
          //   thickness: 4,
          //   height: 4,
          // ),

          InkWell(
            onTap: () async {
              final res = await Popup.showPopUpYesNo('Are you sure you want to logout');
              if (!res) {
                Vibration.vibrate();
                return;
              }
              user = null;
              await FirebaseAuth.instance.signOut();
              context.pushReplacement(const AuthScreen());

              //TODO LOG OUT LOGIC
            },
            child: Container(
              height: size.height * .09,
              color: const Color(0xFFF7ECEC),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(
                      Icons.exit_to_app,
                      color: Color(0xFFAF4040),
                      size: 36,
                    ),
                  ),
                  SizedBox(
                    width: size.width * .05,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Text(
                        'Logout',
                        style: GoogleFonts.roboto(
                          color: const Color(0xFFAF4040),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: context.mediaQuery.viewPadding.bottom,
          ),
        ],
      ),
    );
  }
}
