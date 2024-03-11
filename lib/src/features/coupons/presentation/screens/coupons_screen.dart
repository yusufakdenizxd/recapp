import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recapp/src/core/auth.dart';
import 'package:recapp/src/core/context_extension.dart';
import 'package:recapp/src/core/formats.dart';
import 'package:recapp/src/features/coupons/domain/datasources/coupon_model.dart';
import 'package:recapp/src/features/coupons/presentation/screens/purchase_history.dart';
import 'package:recapp/src/features/coupons/presentation/widgets/coupon_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class CouponsScreen extends StatefulWidget {
  const CouponsScreen({super.key});

  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  final coupons = <CouponModel>[
    CouponModel(
      id: '',
      coinAmount: 200,
      title: 'Amazon',
      percentage: '20% Off',
    ),
    CouponModel(
      id: '',
      coinAmount: 1500,
      title: 'Amazon',
      percentage: '30% Off',
    ),
    CouponModel(
      id: '',
      coinAmount: 2500,
      title: 'Youtube Premium',
      percentage: '%10 Off',
    ),
    CouponModel(
      id: '',
      coinAmount: 2000,
      title: 'Netflix',
      percentage: '35\$ Credit',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.primaryColor,
        leadingWidth: size.width * .7,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width * .05,
            ),
            Container(
              height: size.height * .04,
              width: size.width * .01,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'Coupons',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(
                Icons.close,
                size: 40,
              ),
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              height: size.height * .1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'My Balance:',
                      style: GoogleFonts.roboto(
                        color: const Color(0xFF292929),
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 32),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Icon(
                            Icons.wallet,
                            color: context.theme.primaryColor,
                            size: 24,
                          ),
                        ),
                        StreamBuilder(
                          stream: FirebaseFirestore.instance.collection('users').doc(user!.id).snapshots(),
                          builder: (context, snapshot) {
                            num _ = snapshot.data?['coin'] ?? 0;
                            return Text(
                              _.numeric,
                              style: GoogleFonts.roboto(
                                color: const Color(0xFF292929),
                                fontSize: 24,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * .01,
            ),
            GestureDetector(
              onTap: () => context.push(const PurchaseHistory()),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                height: size.height * .07,
                width: size.width,
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Purchase History',
                        style: GoogleFonts.roboto(
                          color: const Color(0xFF515151),
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_right,
                      color: context.theme.primaryColor,
                      size: 36,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * .01,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: coupons.length,
              itemBuilder: (context, index) => CouponWidget(coupons[index]),
            ),
          ],
        ),
      ),
    );
  }
}
