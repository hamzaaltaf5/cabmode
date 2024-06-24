import 'package:cabmode/resources/auth_methods.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cabmode/resources/local_methods/utils.dart';

import 'add_driver_vehicle_info_screen.dart';

class AddDriverPersonalInfoScreen extends StatefulWidget {
  @override
  _AddDriverPersonalInfoScreenState createState() =>
      _AddDriverPersonalInfoScreenState();
}

class _AddDriverPersonalInfoScreenState
    extends State<AddDriverPersonalInfoScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery, 50);
    setState(() {
      _image = im;
    });
  }

  // void _proceedToVehicleInfo(){
  //   bool isValid;
  //   isValid = _formKey.currentState!.validate();
  //
  //   if(isValid){
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) =>
  //             AddDriverVehicleInfoScreen(
  //               name: _nameController.text,
  //               email: _emailController.text,
  //               phoneNumber:
  //               _phoneNumberController.hashCode,
  //               password: _passwordController.text,
  //               image: _image,
  //             ),
  //       ),
  //     );
  //   }
  // }

  //Register Driver
  void signUpDriver() async {
    bool isValid;
    isValid = _formKey.currentState!.validate();

    if (isValid) {
      setState(() {
        _isLoading = true;
      });

      final res = await AuthMethods().signUpDriver(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        phoneNumber: int.parse(_phoneNumberController.text),
        location: _locationController.text,
        profileImageFile: _image!,
        driverRating: 0.0,
      );

      setState(() {
        _isLoading = false;
      });

      if (res != 'success') {
        showSnackBar(context, res);
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddDriverVehicleInfoScreen(),
          ),
        );
      }
    }
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
                  'Add Personal Details',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 10.0.h,
                ),
                Row(
                  children: [
                    Expanded(child: Container()),
                    Stack(
                      children: [
                        _image != null
                            ? CircleAvatar(
                                backgroundImage: MemoryImage(_image!),
                                radius: 40.0,
                              )
                            : CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg'),
                                radius: 40.0,
                              ),
                        Positioned(
                          bottom: -10,
                          left: 40.0,
                          child: IconButton(
                            onPressed: selectImage,
                            icon: Icon(Icons.add_a_photo),
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                SizedBox(
                  height: 10.0.h,
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: _nameController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 4) {
                      return 'Please Enter at least 4 characters';
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
                    hintText: 'Name',
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email';
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
                    hintText: 'Email',
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _locationController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter a location';
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
                    hintText: 'Location',
                  ),
                ),
                SizedBox(
                  height: 10.0.h,
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: _phoneNumberController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 11) {
                      return 'Please enter a complete phone number';
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
                    prefixIcon: Icon(Icons.numbers),
                    hintText: 'Phone Number',
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 7) {
                      return 'Password must be at least 7 characters long';
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3.0,
                        color: Colors.indigo,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: Icon(Icons.password),
                    hintText: 'Password',
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
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text('Register'),
                        onPressed: signUpDriver,
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
