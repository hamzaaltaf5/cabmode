import 'package:cloud_firestore/cloud_firestore.dart';

class SetLocationModel {
  String? locId;
  String? locationId;
  String? startLocation;
  String? endLocation;
  final driversOnLocation;
  final usersOnLocation;

  SetLocationModel({
    this.locId,
    this.locationId,
    this.startLocation,
    this.endLocation,
    this.driversOnLocation,
    this.usersOnLocation,
  });

  Map<String, dynamic> toJson() => {
    'locId': locId,
    'locationId': locationId,
    'startLocation': startLocation,
    'endLocation': endLocation,
    'driversOnLocation': driversOnLocation,
    'userOnLocation': usersOnLocation,
  };

  static SetLocationModel fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;

    return SetLocationModel(
      locId: snapshot['locId'],
      locationId: snapshot['locationId'],
      startLocation: snapshot['startLocation'],
      endLocation: snapshot['endLocation'],
      driversOnLocation: snapshot['driversOnLocation'],
      usersOnLocation: snapshot['userOnLocation'],
    );
  }
}
