import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChooseFlowScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Text('Choose Flow'),
              SizedBox(height: 40.0.h,),

              Text('Are you a?'),
              SizedBox(height: 10.0.h),
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  height: 30.0.h,
                  width: MediaQuery.of(context).size.width * 0.75,
                  decoration: BoxDecoration(
                    border: Border.all()
                  ),
                  child: Center(
                    child: Text('Driver'),
                  ),
                ),
              ),
              SizedBox(height: 10.0,),
              GestureDetector(
                child: Container(
                  height: 30.0.h,
                  width: MediaQuery.of(context).size.width * 0.75,
                  decoration: BoxDecoration(
                      border: Border.all()
                  ),
                  child: Center(
                    child: Text('Customer'),
                  ),
                ),
              ),
            ],
          ),
          ),
    );
  }
}