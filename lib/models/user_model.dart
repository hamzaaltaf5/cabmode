import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? name;
  String? email;
  String? password;
  int? phoneNumber;
  double? userRating;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.password,
    this.phoneNumber,
    this.userRating,
  });

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "name": name,
    "email": email,
    "password": password,
    "phoneNumber": phoneNumber,
    "userRating": userRating,
  };

  static UserModel fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      uid: snapshot['uid'],
      name: snapshot['name'],
      email: snapshot['email'],
      password: snapshot['password'],
      phoneNumber: snapshot['phoneNumber'],
      userRating: snapshot['userRating'],
    );
  }
}
