import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../resources/local_methods/utils.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawer createState() => _AppDrawer();
}

class _AppDrawer extends State<AppDrawer> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var driverData = {};
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final User user = _auth.currentUser!;
      final driverId = user.uid;

      var userSnap = await FirebaseFirestore.instance
          .collection('drivers')
          .doc(driverId)
          .get();
      driverData = userSnap.data()!;
    } catch (error) {
      showSnackBar(context, error.toString());
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(driverData['profileImageUrl']),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      driverData['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      driverData['location'],
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Booking History'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.add_road,
            ),
            title: Text(
              'Book Now',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {},
          ),
          Expanded(
            child: Container(),
          ),
          Divider(
            color: Colors.black,
          ),
          Column(
            children: [
              ListTile(
                leading: Icon(Icons.drive_eta_rounded),
                title: Text(
                  'Driver mode',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text(
                  'Logout',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  _auth.signOut();
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {},
              )
            ],
          )
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
