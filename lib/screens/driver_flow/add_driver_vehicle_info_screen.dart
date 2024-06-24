import 'package:cabmode/resources/auth_methods.dart';
import 'package:cabmode/resources/firestore_methods.dart';
import 'package:cabmode/screens/driver_flow/add_license_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../resources/local_methods/utils.dart';
import 'driver_homepage_screen.dart';

class AddDriverVehicleInfoScreen extends StatefulWidget {
  @override
  _AddDriverVehicleInfoScreenState createState() =>
      _AddDriverVehicleInfoScreenState();
}

class _AddDriverVehicleInfoScreenState
    extends State<AddDriverVehicleInfoScreen> {
  final TextEditingController _modelNameController = TextEditingController();
  final TextEditingController _numberPlateNoController =
      TextEditingController();
  final TextEditingController _vehicleTypeController = TextEditingController();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  final FirebaseAuth auth = FirebaseAuth.instance;



  uploadVehicleData() async {
    final User user = auth.currentUser!;
    final driverId = user.uid;

    setState(() {
      _isLoading = true;
    });

    final res = await FirestoreMethods().addVehicleDetails(
      driverId: driverId,
      vehicleType: _vehicleTypeController.text,
      modelName: _modelNameController.text,
      noPlateNumber: _numberPlateNoController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if(res != 'success'){
      showSnackBar(context, res);
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => AddLicenseScreen()));
    }

    // if(res == 'success'){
    //   Navigator.push(context, MaterialPageRoute(builder: (context) => AddLicenseScreen()));
    // } else {
    //   const SnackBar snackBar = SnackBar(content: Text('Data upload failed'));
    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.10,
              ),
              Text(
                'Add Vehicle Details',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: 10.0.h,
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: _vehicleTypeController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Car or Bike';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3.0,
                      color: Colors.indigo,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Car or Bike',
                ),
              ),
              SizedBox(
                height: 10.0.h,
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: _modelNameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Your Car Name';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3.0,
                      color: Colors.indigo,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Enter Model',
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _numberPlateNoController,
                validator: (value) {
                  if (value!.isEmpty || !value.contains('-')) {
                    return 'Please enter a valid number plate';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3.0,
                      color: Colors.indigo,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: Icon(Icons.email_outlined),
                  hintText: 'Write in ABC-123 format',
                ),
              ),
              SizedBox(
                height: 30.0.h,
              ),
              Row(
                children: [
                  Expanded(child: Container()),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black38)),
                      child: _isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Text('Register'),
                      onPressed: uploadVehicleData,
                    ),
                  ),
                  Expanded(child: Container()),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
