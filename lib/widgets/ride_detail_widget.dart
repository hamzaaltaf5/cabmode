import 'package:cabmode/resources/firestore_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class RideDetailsWidget extends StatelessWidget {
  String status;
  final snap;
  Color? statusColor;
  DateTime now = DateTime.now();

  RideDetailsWidget({
    required this.status,
    this.statusColor,
    this.snap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Date and Status
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              snap['dateOfTravel'],
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Expanded(child: Container()),
            Text(
              status,
              style: TextStyle(color: statusColor),
            )
          ],
        ),

        SizedBox(
          height: 5.0.h,
        ),

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
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 70.0.h,
                      width: 70.0.h,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Time of Travel',
                              style: Theme.of(context).textTheme.titleSmall,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 5.0.h),
                            Text(
                              snap['timeOfTravel'],
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                    VerticalDivider(),
                    SizedBox(
                      height: 70.0.h,
                      width: 90.0.h,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Seats Available',
                              style: Theme.of(context).textTheme.titleSmall,
                              softWrap: true,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 5.0.h),
                            Text(
                              snap['seatsAvailable'].toString(),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                    VerticalDivider(),
                    SizedBox(
                      height: 70.0.h,
                      width: 90.0.h,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Fare Per Seat',
                              style: Theme.of(context).textTheme.titleSmall,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 5.0.h),
                            Text(
                              '${snap['farePerSeat'].toString()}rs',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ListTile(
              //   leading: CircleAvatar(
              //     radius: 20.0.r,
              //     backgroundImage: NetworkImage(
              //         'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fHBvcnRyYWl0fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=1000&q=60'),
              //   ),
              //   title: Text(
              //     'Babar',
              //     style: Theme.of(context).textTheme.titleMedium,
              //   ),
              //   subtitle: Row(
              //     children: [
              //       Icon(
              //         Icons.access_time,
              //         color: Colors.redAccent,
              //         size: 15.0,
              //       ),
              //       SizedBox(
              //         width: 5.0.w,
              //       ),
              //       Text(
              //         '15 mins ago',
              //         style: TextStyle(
              //           fontSize: 13.0.sp,
              //           color: Colors.grey,
              //         ),
              //       ),
              //       SizedBox(
              //         width: 10.0.w,
              //       ),
              //       Icon(
              //         Icons.star,
              //         color: Colors.yellow.shade700,
              //         size: 15.0,
              //       ),
              //       SizedBox(
              //         width: 5.0.w,
              //       ),
              //       Text(
              //         '2.3',
              //         style: TextStyle(
              //           fontSize: 15.0.sp,
              //           color: Colors.grey,
              //         ),
              //       ),
              //     ],
              //   ),
              //   trailing: Text(
              //     '400 Rs',
              //     style: TextStyle(
              //       fontSize: 20.0.sp,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),

              // Divider(),
              //
              // //My current location row
              // Row(
              //   children: [
              //     Container(
              //       height: 20.0,
              //       width: 20.0,
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.all(Radius.circular(30.0)),
              //           border: Border.all(
              //             width: 5.0,
              //             color: Colors.black,
              //           )),
              //     ),
              //     SizedBox(
              //       width: 15.0.w,
              //     ),
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           'My start location',
              //           style: Theme.of(context)
              //               .textTheme
              //               .titleSmall!
              //               .copyWith(fontSize: 10.0),
              //         ),
              //         Text(
              //           'Dublin',
              //           style: Theme.of(context)
              //               .textTheme
              //               .titleMedium!
              //               .copyWith(fontSize: 15.0),
              //         ),
              //       ],
              //     ),
              //     Expanded(
              //       flex: 2,
              //       child: Container(),
              //     ),
              //     Text(
              //       '10:10AM',
              //       style: Theme.of(context).textTheme.titleSmall,
              //     ),
              //   ],
              // ),

              Divider(),

              //Row for drop off location
              Row(
                children: [
                  Icon(
                    Icons.location_pin,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Travel Location',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontSize: 10.0),
                      ),
                      Text(
                        snap['startAndEndLocation'],
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
                  IconButton(
                    onPressed: () async {
                      FirestoreMethods().deleteRide(snap['rideId']);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ride Deleted')));
                    },
                    icon: Icon(
                      Icons.delete,
                    ),
                    color: Colors.red,
                  )
                ],
              ),
            ],
          ),
        ),

        SizedBox(
          height: 20.0.h,
        ),
      ],
    );
  }
}
