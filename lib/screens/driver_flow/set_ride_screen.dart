import 'dart:core';

import 'package:cabmode/resources/firestore_methods.dart';
import 'package:cabmode/resources/local_methods/utils.dart';
import 'package:cabmode/screens/driver_flow/driver_homepage_screen.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class SetRideScreen extends StatefulWidget {
  String? startToEndLocation;
  int? locationByIndex;
  String? locationId;

  SetRideScreen({
    this.startToEndLocation,
    this.locationByIndex,
    this.locationId,
  });

  @override
  _SetRideScreenState createState() => _SetRideScreenState();
}

class _SetRideScreenState extends State<SetRideScreen> {
  final TextEditingController _farePerSeatController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late var dateOfTravelController = TextEditingController();
  String dateChanged = '';
  String validateDate = '';
  String savedDate = '';
  String timeChanged = '';
  String validateTime = '';
  String saveTime = '';
  String timeOfTravel = '';
  int seatsAvailable = 1;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isLoading = false;
  var driverData = {};
  dynamic vehicleType;
  var driversOnLocation;
  var locationSnap;

  String rideId = const Uuid().v1();

  updateDriverOnLocation() async {
    User user = _auth.currentUser!;
    final driverId = user.uid;

    locationSnap =
        await _firestore.collection('locations').doc(widget.locationId).get();
    driversOnLocation = locationSnap.data()!['driversOnLocation'];

    FirestoreMethods()
        .addRiderToAvailableLocationList(rideId, driverId, driversOnLocation);
  }

  @override
  void initState() {
    initializeDateFormatting();
    Intl.defaultLocale = 'en_US';
    // TODO: implement initState
    super.initState();
  }

  uploadSetRideData() async {
    setState(() {
      _isLoading = true;
    });

    final res = await FirestoreMethods().addCreateRide(
      rideId: rideId,
      farePerSeat: int.parse(_farePerSeatController.text),
      seatsAvailable: seatsAvailable,
      dateOfTravel: dateOfTravelController.text,
      timeOfTravel: timeChanged,
      startAndEndLocation: widget.startToEndLocation.toString(),
    );
    updateDriverOnLocation();
    // setState(() {
    //   _isLoading = false;
    // });

    if (res != 'success') {
      setState(() {
        _isLoading = false;
      });
      print('THE RESPONSE IS: $res');
      showSnackBar(context, res);
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(context, 'Ride Created');
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => DriverHomePageScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Ride'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Location : ',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        width: 5.0.w,
                      ),
                      Text(widget.startToEndLocation.toString(),
                          style: Theme.of(context).textTheme.titleLarge),
                    ],
                  ),
                  Divider(),
                  Text(
                    'Enter Fare Per Seat',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.0.h,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _farePerSeatController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter a Fare';
                      }
                    },
                    decoration: InputDecoration(
                        label: Text('E.g. 110rs'),
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 20.0.h),
                  Text(
                    'Choose Available Seats',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.0.h,
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary,],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: NumberPicker(
                      value: seatsAvailable,
                      minValue: 1,
                      maxValue: 4,
                      step: 1,
                      itemHeight: 70,
                      axis: Axis.vertical,
                      onChanged: (value) {
                        setState(() {
                          seatsAvailable = value;
                        });
                      },
                      textStyle: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.white),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0.h,
                  ),


                  DateTimePicker(
                    type: DateTimePickerType.date,
                    controller: dateOfTravelController,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                    icon: Icon(Icons.event),
                    dateLabelText: 'Date Of Travel',
                    locale: Locale('en', 'US'),
                    onChanged: (value) {
                      setState(() {
                        dateChanged = value;
                      });
                    },
                    validator: (value) {
                      setState(() {
                        validateDate = value ?? '';
                      });
                    },
                    onSaved: (value) {
                      setState(() {
                        savedDate = value ?? '';
                      });
                    },
                  ),

                  DateTimePicker(
                    type: DateTimePickerType.time,
                    initialValue: '',
                    icon: Icon(Icons.access_time),
                    timeLabelText: 'Set Travel Time',
                    use24HourFormat: false,
                    locale: Locale('en', 'US'),
                    onChanged: (value) {
                      setState(() {
                        timeChanged = value;
                      });
                    },
                    validator: (value) {
                      setState(() {
                        validateTime = value ?? '';
                      });
                    },
                    onSaved: (value) {
                      setState(() {
                        saveTime = value ?? '';
                      });
                    },
                  ),

                  SizedBox(
                    height: 20.0.h,
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      height: 40.0.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary,],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: _isLoading ? Center(child: CircularProgressIndicator(),): Center(
                        child: GestureDetector(
                          onTap: uploadSetRideData,
                          child: Text('Proceed', style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),),
                        ),
                      )
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
