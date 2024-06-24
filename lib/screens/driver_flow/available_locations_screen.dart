import 'package:cabmode/screens/driver_flow/set_ride_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvailableLocationsScreen extends StatefulWidget {
  const AvailableLocationsScreen({Key? key}) : super(key: key);

  @override
  _AvailableLocationsScreenState createState() =>
      _AvailableLocationsScreenState();
}

class _AvailableLocationsScreenState extends State<AvailableLocationsScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Available Locations'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('locations').snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  String startToEndLocation = '${snapshot.data!.docs[index].data()['startLocation']} to ${snapshot.data!.docs[index].data()['endLocation']}';
                  String locationId = snapshot.data!.docs[index].data()['locationId'];
                  return Card(
                    child: ListTile(
                      title: Text(startToEndLocation),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SetRideScreen(startToEndLocation: startToEndLocation, locationByIndex: index, locationId: locationId),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ));
  }
}
