import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recapp/src/core/auth.dart';
import 'package:recapp/src/core/context_extension.dart';
import 'package:recapp/src/features/coupons/domain/datasources/coupon_model.dart';
import 'package:recapp/src/features/coupons/presentation/widgets/purchase_coupon_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class PurchaseHistory extends StatelessWidget {
  const PurchaseHistory({super.key});

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
                'Purchase History',
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
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user!.id)
                  .collection('purchasedCoupons')
                  .withConverter<CouponModel>(
                    fromFirestore: (snapshot, options) => CouponModel.fromDoc(snapshot),
                    toFirestore: (value, options) => value.toFirebase(),
                  )
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data == null || snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) => PurchaseCouponWidget(snapshot.data!.docs[index].data()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
