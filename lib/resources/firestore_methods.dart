import 'package:cabmode/models/set_location_model.dart';
import 'package:cabmode/models/set_ride_model.dart';
import 'package:cabmode/models/vehicle_model.dart';
import 'package:cabmode/resources/storage_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Set Location for Drivers to Choose from
  Future<String> SetLocation(
    String startLocation,
    String endLocation,
  ) async {
    String res = 'Some error occurred';
    try {
      //Using uuid package to generate a unique id
      String locationId = const Uuid().v1();
      SetLocationModel setLocation = SetLocationModel(
        locationId: locationId,
        startLocation: startLocation,
        endLocation: endLocation,
        driversOnLocation: [],
        usersOnLocation: [],
      );
      _firestore
          .collection('locations')
          .doc(locationId)
          .set(setLocation.toJson());
      res = 'success';
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

  Future<String> addVehicleDetails({
    required String driverId,
    required String vehicleType,
    required String modelName,
    required String noPlateNumber,
  }) async {
    String res = 'Some error occurred';

    try {
      String vehicleId = const Uuid().v1();
      VehicleModel vehicleInfo = VehicleModel(
        vid: vehicleId,
        driverId: driverId,
        vehicleType: vehicleType,
        modelName: modelName,
        noPlateNumber: noPlateNumber,
      );

      await _firestore.collection('vehicles').doc(vehicleId).set(
            vehicleInfo.toJson(),
          );

      res = 'success';
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

  Future<String> uploadLicense(Uint8List licenseImage) async {
    final User user = _auth.currentUser!;
    final driverId = user.uid;

    String res = 'Some error occurred';

    try {
      String licenseUrl =
          await StorageMethods().uploadImageToStorage('license', licenseImage);
      _firestore.collection('drivers').doc(driverId).set(
        {'licenseUrl': licenseUrl},
        SetOptions(merge: true),
      );

      res = 'success';
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

  Future<String> addCreateRide({
    required String rideId,
    required int farePerSeat,
    required int seatsAvailable,
    required String dateOfTravel,
    required String timeOfTravel,
    required String startAndEndLocation,
  }) async {
    String res = 'Some error occurred';

    try {
      final driverId = _auth.currentUser!.uid;
      //String rideId = const Uuid().v1();
      SetRideModel setRideInfo = SetRideModel(
        rideId: rideId,
        driverId: driverId,
        farePerSeat: farePerSeat,
        seatsAvailable: seatsAvailable,
        startAndEndLocation: startAndEndLocation,
        dateOfTravel: dateOfTravel,
        timeOfTravel: timeOfTravel,
        usersOnRide: [],
      );

      await _firestore.collection('setRide').doc(rideId).set(
            setRideInfo.toJson(),
          );

      res = 'success';
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

  Future<void> addUsersOnRide(
      String rideId, String driverId, List usersOnRide) async {
    try {
      if (usersOnRide.contains(driverId)) {
        await _firestore.collection('setRide').doc(rideId).update({
          'usersOnRide': FieldValue.arrayRemove([driverId]),
        });
      } else {
        await _firestore.collection('setRide').doc(rideId).update({
          'usersOnRide': FieldValue.arrayUnion([driverId]),
        });
      }
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> addRiderToAvailableLocationList(
      String rideId, String driverId, List driversOnLocation) async {
    try {
      if (driversOnLocation.contains(driverId)) {
        await _firestore.collection('locations').doc(rideId).update({
          'driversOnLocation': FieldValue.arrayRemove([driverId]),
        });
      } else {
        await _firestore.collection('locations').doc(rideId).update({
          'driversOnLocation': FieldValue.arrayUnion([driverId]),
        });
      }
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> addUserToAvailableLocationList(
      String rideId, String uid, List driversOnLocation) async {
    try {
      if (driversOnLocation.contains(uid)) {
        await _firestore.collection('locations').doc(rideId).update({
          'driversOnLocation': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('locations').doc(rideId).update({
          'driversOnLocation': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> deleteRide(String rideId) async {
    try {
      await _firestore.collection('setRide').doc(rideId).delete();
      print('${rideId} deleted');
    } catch (error) {
      print(error.toString());
    }
  }
}
