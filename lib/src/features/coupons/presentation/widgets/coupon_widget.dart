import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recapp/src/core/auth.dart';
import 'package:recapp/src/core/context_extension.dart';
import 'package:recapp/src/core/formats.dart';
import 'package:recapp/src/core/popups.dart';
import 'package:recapp/src/core/snackbar.dart';
import 'package:recapp/src/features/auth/domain/models/user_model.dart';
import 'package:recapp/src/features/coupons/domain/datasources/coupon_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vibration/vibration.dart';

class CouponWidget extends StatelessWidget {
  const CouponWidget(this.coupon, {super.key});
  final CouponModel coupon;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF2F2F2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: size.width * .05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      coupon.title,
                      style: GoogleFonts.roboto(
                        color: const Color(0xFF292929),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.theme.primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        coupon.percentage,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomPaint(
                  painter: _Painter(),
                  child: SizedBox(
                    height: size.height * .07,
                    width: size.width * .44,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Icon(
                              Icons.wallet,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          Text(
                            coupon.coinAmount.numeric,
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * .02),
                Row(
                  children: [
                    // Text(
                    //   'Purchase',
                    //   style: GoogleFonts.roboto(
                    //     color: const Color(0xFF464646),
                    //     fontSize: 16,
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () async {
                          final a = UserModel.fromDocument(await FirebaseFirestore.instance.collection('users').doc(user!.id).get());
                          if (a.coin < coupon.coinAmount) {
                            Vibration.vibrate();
                            Snackbar.showError('You dont have enough coin');
                            return;
                          }
                          final res = await Popup.showPopUpYesNo('Are you sure you want to purchase coupon');
                          if (!res) {
                            Vibration.vibrate();
                            return;
                          }
                          Popup.showLoadingScreen();
                          await FirebaseFirestore.instance.collection('users').doc(user!.id).collection('purchasedCoupons').add(coupon.toFirebase());
                          await FirebaseFirestore.instance.collection('users').doc(user!.id).get().then((value) async {
                            await value.reference.update({'coin': double.parse(value['coin'].toString()) - coupon.coinAmount});
                          });
                          context.pop();
                          Snackbar.show('Purchased coupon successfully');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: context.theme.primaryColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Purchase',
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(width: size.width * .09),
                    // const Icon(
                    //   Icons.arrow_right,
                    //   color: Color(0xFF464646),
                    // ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4d8d6e)
      ..style = PaintingStyle.fill;

    final path = Path();

    path.moveTo(0, 0);

    path.quadraticBezierTo(size.width / 2, size.height * 2, size.width * 1.4, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_Painter oldDelegate) => false;
}
