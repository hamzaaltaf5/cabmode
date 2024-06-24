import 'package:cabmode/screens/choose_flow_screen.dart';
import 'package:cabmode/screens/admin_flow/admin_homepage_screen.dart';
import 'package:cabmode/screens/driver_flow/driver_homepage_screen.dart';
import 'package:cabmode/screens/sign_in_screen.dart';
import 'package:cabmode/screens/signup_screen.dart';
import 'package:cabmode/screens/users_flow/user_homepage_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        title: 'Cabmode',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          canvasColor: Colors.grey.shade200,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Color(0xff319964),
            secondary: Color(0xff133a26),
          ),
          textTheme: ThemeData.light().textTheme.copyWith(
                //titlelarge will be used for all the pages headings
                titleLarge: GoogleFonts.poppins(
                  fontSize: 20.0.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
                //title small will be used for Names, Places,
                titleMedium:
                    GoogleFonts.poppins(fontSize: 20.0.sp, color: Colors.black),
                titleSmall:
                    GoogleFonts.poppins(fontSize: 13.0.sp, color: Colors.grey),
                bodyMedium: GoogleFonts.poppins(
                  fontSize: 12.0.sp,
                ),
              ),
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const DriverHomePageScreen();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data == null) {
              return SigninScreen();
            }
            return Container();
          },
        ),
      ),
    );
  }
}
