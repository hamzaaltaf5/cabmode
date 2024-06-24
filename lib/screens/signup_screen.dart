import 'package:cabmode/screens/driver_flow/add_driver_personal_info_screen.dart';
import 'package:cabmode/screens/users_flow/user_signup_screen.dart';
import 'package:flutter/material.dart';
import '../screens/sign_in_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                'Welcome to',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                ),
              ),
              Text(
                'Cabmode!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                    fontFamily: 'times new roman',
                    color: Colors.indigo),
              ),

              SizedBox(
                height: 25.0,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  TextButton(
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.grey),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SigninScreen()));
                    },
                  ),
                ],
              ),

              SizedBox(height: 10.0,),

              GestureDetector(
                child: Container(
                  color: Colors.blue,
                  child: ListTile(
                    leading: SizedBox(
                      width: 50.0.w,
                      child: Icon(
                        Icons.title,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      'Sign up as Customer',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UserSignUpScreen()));
                },
              ),

              SizedBox(height: 10.0,),

              GestureDetector(
                child: Container(
                  color: Colors.redAccent,
                  child: ListTile(
                    leading: SizedBox(
                      width: 50.0,
                      child: Icon(
                        Icons.car_rental,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      'Sign up as driver',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddDriverPersonalInfoScreen()));
                },
              ),

              SizedBox(height: 20.0,),

              Container(
                child: Image(
                  image: AssetImage('assets/images/cab_booking1.jpg'),
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }
}
