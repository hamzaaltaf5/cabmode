import 'package:cloud_firestore/cloud_firestore.dart';


class DriverModel{
  String? driverId;
  String? name;
  String? email;
  String? password;
  String? location;
  int? phoneNumber;
  String? profileImageUrl;
  double? driverRating;

  DriverModel({this.driverId, this.name, this.email, this.password, this.location, this.phoneNumber, this.profileImageUrl, this.driverRating,});

  Map<String, dynamic> toJson() => {
    "driverId": driverId,
    "name": name,
    "email": email,
    "password": password,
    "location": location,
    "phoneNumber": phoneNumber,
    "profileImageUrl": profileImageUrl,
    "driverRating": driverRating,
  };

  static DriverModel fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;

    return DriverModel(
      driverId: snapshot['driverId'],
      name: snapshot['name'],
      email: snapshot['email'],
      password: snapshot['password'],
      location: snapshot['location'],
      phoneNumber: snapshot['phoneNumber'],
      profileImageUrl: snapshot['profileImageUrl'],
      driverRating: snapshot['driverRating'],
    );
  }
}