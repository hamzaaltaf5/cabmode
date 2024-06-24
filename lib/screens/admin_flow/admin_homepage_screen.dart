import 'package:cabmode/resources/auth_methods.dart';
import 'package:cabmode/screens/admin_flow/create_new_routes_screen.dart';
import '../admin_flow/creating_new_routes_screen.dart';
import 'package:flutter/material.dart';

class AdminPageScreen extends StatefulWidget {
  String? email;

  AdminPageScreen({
    this.email,
  });

  @override
  _AdminPageScreenState createState() => _AdminPageScreenState();
}

class _AdminPageScreenState extends State<AdminPageScreen> {
  signOut() {
    AuthMethods().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CreateNewRoutesScreen()));
          },
              icon: Icon(Icons.add_location_alt)),
          IconButton(onPressed: signOut, icon: Icon(Icons.logout)),
        ],
      ),
      body: Center(
        child: Text('Admin HomePage'),
      ),
    );
  }
}
