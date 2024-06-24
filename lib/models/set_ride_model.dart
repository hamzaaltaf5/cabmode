import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SetRideModel {
  String? rideId;
  String? driverId;
  String? startAndEndLocation;
  String? dateOfTravel;
  String? timeOfTravel;
  int? farePerSeat;
  int? seatsAvailable;
  final usersOnRide;

  SetRideModel({
    this.rideId,
    this.driverId,
    this.startAndEndLocation,
    this.dateOfTravel,
    this.timeOfTravel,
    this.farePerSeat,
    this.seatsAvailable,
    this.usersOnRide,
  });

  Map<String, dynamic> toJson() => {
        "rideId": rideId,
        "driverId": driverId,
        "startAndEndLocation": startAndEndLocation,
        "dateOfTravel": dateOfTravel,
        "farePerSeat": farePerSeat,
        "timeOfTravel": timeOfTravel,
        "seatsAvailable": seatsAvailable,
        "usersOnRide": usersOnRide,
      };

  static SetRideModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return SetRideModel(
      rideId: snapshot['rideId'],
      driverId: snapshot['driverId'],
      startAndEndLocation: snapshot['startAndEndLocation'],
      dateOfTravel: snapshot['dateOfTravel'],
      timeOfTravel: snapshot['timeOfTravel'],
      farePerSeat: snapshot['farePerSeat'],
      seatsAvailable: snapshot['seatsAvailable'],
      usersOnRide: snapshot['usersOnRide'],
    );
  }
}
