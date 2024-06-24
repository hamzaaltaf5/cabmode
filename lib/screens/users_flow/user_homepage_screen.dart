import 'package:cabmode/resources/auth_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserHomePageScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  signOutUser(){
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [

          IconButton(onPressed: signOutUser, icon: Icon(Icons.logout))

        ],
      ),
      body: Center(
        child: Text('User HomePage'),
      ),
    );
  }
}
