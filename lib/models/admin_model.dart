import 'package:cloud_firestore/cloud_firestore.dart';

class AdminModel {
  final String? id;
  final String? name;
  final String? email;
  final String? password;

  AdminModel({
    this.id,
    this.name,
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "password": password,
  };

  static AdminModel fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;

    return AdminModel(
      id: snapshot['id'],
      name: snapshot['name'],
      email: snapshot['email'],
      password: snapshot['password'],
    );
  }
}
