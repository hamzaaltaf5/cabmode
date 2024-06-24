import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VehicleModel {
  String? vid;
  String? driverId;
  String? vehicleType;
  String? modelName;
  String? noPlateNumber;

  VehicleModel(
      {this.vid, this.driverId, this.vehicleType, this.modelName, this.noPlateNumber,});

  Map<String, dynamic> toJson() => {
    "vid": vid,
    "driverId": driverId,
    "vehicleType": vehicleType,
    "modelName": modelName,
    "noPlateNumber": noPlateNumber,
  };

  static VehicleModel fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;

    return VehicleModel(
      vid: snapshot['vid'],
      driverId: snapshot['driverId'],
      vehicleType: snapshot['vehicleType'],
      modelName: snapshot['modelName'],
      noPlateNumber: snapshot['noPlateNumber'],
    );
  }
}