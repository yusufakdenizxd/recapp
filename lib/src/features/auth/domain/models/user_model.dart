import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recapp/src/core/formats.dart';

class UserModel {
  String id;
  String username;
  String email;
  String password;
  double xp;
  double coin;

  UserModel({
    this.id = '',
    required this.coin,
    required this.username,
    required this.email,
    required this.password,
    required this.xp,
  });

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'xp': xp,
      'coin': coin,
      'username': username,
    };
  }

  double get percentage {
    if (level == 1) {
      return xp / 500;
    }
    if (level == 2) {
      return xp / 2000;
    }
    if (level == 3) {
      return xp / 10000;
    }
    throw UnimplementedError();
  }

  String get xpTitle {
    if (level == 1) {
      return '${xp.numeric} / 500';
    }
    if (level == 2) {
      return '${xp.numeric} / 2000';
    }
    if (level == 3) {
      return '${xp.numeric} / 10000';
    }
    throw UnimplementedError();
  }

  double get level {
    if (xp < 500) {
      return 1;
    }
    if (xp < 200) {
      return 2;
    }
    return 3;
  }

  factory UserModel.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    return UserModel(
      id: doc.id,
      email: doc['email'],
      password: doc['password'],
      username: doc['username'],
      xp: double.parse(doc['xp'].toString()),
      coin: double.parse(doc['coin'].toString()),
    );
  }

  factory UserModel.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return UserModel(
      id: doc.id,
      email: doc['email'],
      password: doc['password'],
      username: doc['username'],
      xp: double.parse(doc['xp'].toString()),
      coin: double.parse(doc['coin'].toString()),
    );
  }
}
