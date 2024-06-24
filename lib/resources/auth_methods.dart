import 'dart:ui';

import 'package:cabmode/models/user_model.dart';

import '../models/admin_model.dart';
import 'package:cabmode/resources/storage_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../models/driver_model.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Admin SignUp Authentication
  Future<String> signUpAdmin({
    required String name,
    required String email,
    required String password,
  }) async {
    String res = 'Some error occurred';
    try {
      if (name.isNotEmpty || email.isNotEmpty || password.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);

        //Adding admin to the database
        AdminModel admin = AdminModel(
          id: cred.user!.uid,
          name: name,
          email: email,
          password: password,
        );

        await _firestore
            .collection('admins')
            .doc(cred.user!.uid)
            .set(admin.toJson());
        res = 'success';
      }
    } catch (error) {
      res = (error.toString());
    }
    return res;
  }

  //SignIn admin
  Future<String> signInAdmin(
      {required String email, required String password}) async {
    String res = 'Some error occured';

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'Please enter all the fields';
      }
    } catch (error) {
      res = (error.toString());
    }
    return res;
  }


  //SignUp Driver
  // Future<String> signUpDriver({
  //   required String email,
  //   required String password,
  //   required String name,
  //   required int phoneNumber,
  //   required String location,
  //   required Uint8List imageFile,
  // }) async {
  //   String res = 'Some error occurred';
  //   try {
  //     if (email.isNotEmpty || password.isNotEmpty) {
  //       //Register User
  //       UserCredential cred = await _auth.createUserWithEmailAndPassword(
  //         email: email,
  //         password: password,
  //       );
  //       print(cred.user!.uid);
  //
  //       String profileImageUrl = await StorageMethods()
  //           .uploadImageToStorage('profilePicture', imageFile);
  //
  //       //Add User to the database
  //       Driver user = Driver(
  //         driverId: cred.user!.uid,
  //         name: name,
  //         email: email,
  //         password: password,
  //         phoneNumber: phoneNumber,
  //         profileImageUrl: profileImageUrl,
  //       );
  //
  //       await _firestore
  //           .collection('drivers')
  //           .doc(cred.user!.uid)
  //           .set(user.toJson());
  //       res = "success";
  //     }
  //   } catch (err) {
  //     res = err.toString();
  //   }
  //   return res;
  // }

  Future<String> signUpDriver({
    required String name,
    required String email,
    required String password,
    required String location,
    required int phoneNumber,
    required Uint8List profileImageFile,
    required double driverRating,
  }) async {
    String res = 'Some error occurred';

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);

        String profileImageUrl = await StorageMethods().uploadImageToStorage('profileImages', profileImageFile);

        DriverModel driver = DriverModel(
          driverId: cred.user!.uid,
          name: name,
          email: email,
          password: password,
          location: location,
          phoneNumber: phoneNumber,
          driverRating: driverRating,
          profileImageUrl: profileImageUrl,
        );

        await _firestore
            .collection('drivers')
            .doc(cred.user!.uid)
            .set(driver.toJson());

        res = 'success';
      }
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

  Future<String> loginDriver({
    required String email,
    required String password,
  }) async {
    String res = 'Some error occurred';

    try {
      if (email.toString().isNotEmpty || password.toString().isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'Please enter all the fields';
      }
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

  //SignUp User
  Future<String> signUpUser({
    required String name,
    required String email,
    required String password,
    required int phoneNumber,
  }) async {
    String res = 'Some error occurred';
    try {
      if (email.toString().isNotEmpty || password.toString().isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        print(cred.user!.uid);

        UserModel user = UserModel(
          uid: cred.user!.uid,
          name: name,
          email: email.toString(),
          password: password,
          phoneNumber: phoneNumber,
        );

        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
        res = 'success';
      }
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

  //SignOut
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
