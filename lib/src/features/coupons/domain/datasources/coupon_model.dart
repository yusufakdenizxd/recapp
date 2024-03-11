import 'package:cloud_firestore/cloud_firestore.dart';

class CouponModel {
  String id;
  double coinAmount;
  String title;
  String percentage;
  CouponModel({
    required this.id,
    required this.coinAmount,
    required this.title,
    required this.percentage,
  });

  Map<String, dynamic> toFirebase() {
    return <String, dynamic>{
      'coinAmount': coinAmount,
      'title': title,
      'percentage': percentage,
    };
  }

  factory CouponModel.fromQuery(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return CouponModel(
      id: doc.id,
      coinAmount: double.parse(doc['coinAmount'].toString()),
      title: doc['title'],
      percentage: doc['percentage'],
    );
  }
  factory CouponModel.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    return CouponModel(
      id: doc.id,
      coinAmount: double.parse(doc['coinAmount'].toString()),
      title: doc['title'],
      percentage: doc['percentage'],
    );
  }
}
