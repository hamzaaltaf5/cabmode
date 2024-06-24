import 'dart:typed_data';

import 'package:cabmode/resources/firestore_methods.dart';
import 'package:cabmode/resources/storage_methods.dart';
import 'package:cabmode/screens/driver_flow/driver_homepage_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../resources/local_methods/utils.dart';

class AddLicenseScreen extends StatefulWidget {
  const AddLicenseScreen({Key? key}) : super(key: key);

  @override
  _AddLicenseScreenState createState() => _AddLicenseScreenState();
}

class _AddLicenseScreenState extends State<AddLicenseScreen> {
  Uint8List? _licenseImage;
  bool _isLoading = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery, 50);
    setState(() {
      _licenseImage = im;
    });
  }

  void uploadLicense() async {

    setState(() {
      _isLoading = true;
    });

    if(_licenseImage == null){
      showSnackBar(context, 'Please enter your license');
    } else {
      String res = await FirestoreMethods().uploadLicense(_licenseImage!);

      if(res == 'success'){
        showSnackBar(context, 'Successfully Registered');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DriverHomePageScreen()));
      } else {
        showSnackBar(context, res);
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add License'),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  height: 200.0.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(border: Border.all()),
                  child: _licenseImage == null
                      ? Center(
                          child: TextButton(
                              onPressed: selectImage,
                              child: Text('Add License')),
                        )
                      : Image.memory(
                          _licenseImage!,
                        ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ElevatedButton(
                  onPressed: uploadLicense,
                  child: _isLoading? Center(
                    child: CircularProgressIndicator(color: Colors.white,),
                  ): Center(
                    child: Text('Upload'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
