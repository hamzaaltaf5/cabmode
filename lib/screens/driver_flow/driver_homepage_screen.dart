import 'package:cabmode/resources/auth_methods.dart';
import 'package:cabmode/resources/local_methods/utils.dart';
import 'package:cabmode/screens/driver_flow/available_locations_screen.dart';
import 'package:cabmode/widgets/app_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/new_ride_request_widget.dart';
import 'booking_details.dart';
import 'earning_details_screen.dart';

class DriverHomePageScreen extends StatefulWidget {
  const DriverHomePageScreen({Key? key}) : super(key: key);

  @override
  _DriverHomePageScreenState createState() => _DriverHomePageScreenState();
}

class _DriverHomePageScreenState extends State<DriverHomePageScreen> {
  bool _isLoading = false;
  var driverData = {};
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int totalRides = 0;

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
      setState(() {});

      var rideSnap = await FirebaseFirestore.instance
          .collection('setRide')
          .where('driverId', isEqualTo: _auth.currentUser!.uid)
          .get();

      totalRides = rideSnap.docs.length;
    } catch (error) {
      showSnackBar(context, error.toString());
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: [
            SizedBox(
              height: 20.0.h,
            ),

            //Row for Profile image, name, location, and notification bell
            Row(
              children: [
                driverData['profileImageUrl'] == null
                    ? CircleAvatar(
                        radius: 25.0.r,
                        backgroundImage:
                            AssetImage('assets/images/orange user.png'),
                      )
                    : CircleAvatar(
                        radius: 25.0.r,
                        backgroundImage:
                            NetworkImage(driverData['profileImageUrl']),
                      ),
                SizedBox(
                  width: 5.0.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, ${driverData['name']}! ',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    driverData['location'] == null
                        ? Text('no location added')
                        : Text(
                            driverData['location'],
                          ),
                  ],
                ),
                Expanded(
                  child: Container(),
                ),
                Card(
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        //shape: BoxShape.circle,
                        borderRadius: BorderRadius.circular(30.0)),
                    child: IconButton(
                      icon: Icon(Icons.notifications_none_outlined),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.0.h),

            //Create New Ride Button
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AvailableLocationsScreen()));
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                height: 30.0.h,
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Create a Ride',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 10.0.h,
            ),

            //Row for Overall Earning and Today's booking
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EarningDetailsScreen()));
                  },
                  child: Card(
                    elevation: 10.0,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.44,
                      height: 100.0.h,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '320 Rs',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: Colors.black,
                                    fontSize: 25.0.sp,
                                  ),
                            ),
                            SizedBox(
                              height: 5.0.h,
                            ),
                            Text(
                              'Overall Earning',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                //Booking Details
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BookingDetailsScreen()));
                  },
                  child: Card(
                    elevation: 10.0,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.44,
                      height: 100.0.h,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              totalRides.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      color: Colors.black, fontSize: 25.sp),
                            ),
                            SizedBox(
                              height: 5.0.h,
                            ),
                            Text(
                              'Total bookings',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),

            SizedBox(
              height: 10.0,
            ),

            Text(
              'New Request',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                  ),
            ),

            SizedBox(
              height: 10.0.h,
            ),

            //List for New Request
            ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: 1,
              itemBuilder: (context, int index) {
                return NewRideRequestWidget(
                  customerName: 'Babar',
                  minutesAge: '23',
                  fareOffered: '230',
                  customerRating: 3.2,
                  cusImage: 'assets/images/orange user.png',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
