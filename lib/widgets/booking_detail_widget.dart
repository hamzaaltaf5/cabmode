import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class BookingDetailsWidget extends StatelessWidget{
  String status;
  Color? statusColor;
  DateTime now = DateTime.now();
  BookingDetailsWidget({required this.status, this.statusColor});
  @override
  Widget build(BuildContext context){
    return Column(
      children: [

        //Date and Status
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Text(DateFormat.yMMMEd().format(now).toString(),style: Theme.of(context).textTheme.titleMedium, ),
            Expanded(child: Container()),
            Text(status, style: TextStyle(color: statusColor),)

          ],
        ),

        SizedBox(height: 5.0.h,),

        //Container for main information
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 10.0.h,
            horizontal: 10.0.w,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 20.0.r,
                  backgroundImage:
                  NetworkImage('https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fHBvcnRyYWl0fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=1000&q=60'),
                ),
                title: Text(
                  'Babar',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: Colors.redAccent,
                      size: 15.0,
                    ),
                    SizedBox(
                      width: 5.0.w,
                    ),
                    Text(
                      '15 mins ago',
                      style: TextStyle(
                        fontSize: 13.0.sp,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: 10.0.w,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow.shade700,
                      size: 15.0,
                    ),
                    SizedBox(
                      width: 5.0.w,
                    ),
                    Text(
                      '2.3',
                      style: TextStyle(
                        fontSize: 15.0.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                trailing: Text(
                  '400 Rs',
                  style: TextStyle(
                    fontSize: 20.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Divider(),

              //My current location row
              Row(
                children: [
                  Container(
                    height: 20.0,
                    width: 20.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        border: Border.all(
                          width: 5.0,
                          color: Colors.black,
                        )),
                  ),
                  SizedBox(
                    width: 15.0.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My start location',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontSize: 10.0),
                      ),
                      Text(
                        'Dublin',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 15.0),
                      ),
                    ],
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                  Text(
                    '10:10AM',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),

              Divider(),

              //Row for drop off location
              Row(
                children: [
                  Icon(
                    Icons.location_pin,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Drop off',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontSize: 10.0),
                      ),
                      Text(
                        'Diaboro',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 15.0),
                      ),
                    ],
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                  Text(
                    '10:10AM',
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              ),


            ],
          ),
        ),

        SizedBox(height: 20.0.h,),

      ],
    );
  }
}