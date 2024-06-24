import 'package:cabmode/screens/driver_flow/completed_rides_screen.dart';
import 'package:cabmode/screens/driver_flow/scheduled_rides_screen.dart';
import 'package:cabmode/widgets/ride_detail_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/booking_detail_widget.dart';

class BookingDetailsScreen extends StatefulWidget {
  _BookingDetailsScreenState createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 20.0.h),
      child: Column(
        children: [
          SizedBox(
            height: 15.0.h,
          ),

          Row(
            children: [
              Card(
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Container(
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Text(
                'Booking Details',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Expanded(child: Container()),
            ],
          ),

          SizedBox(
            height: 10.0.h,
          ),

          //Card for tabbar
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            elevation: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: TabBar(
                indicator: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                controller: tabController,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(text: 'Scheduled'),
                  Tab(
                    text: 'Completed',
                  ),
                ],
              ),
            ),
          ),

          SizedBox(
            height: 10.0.h,
          ),

          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                ScheduledRidesScreen(),
                CompletedRidesScreen(),
              ],
            ),
          )
        ],
      ),
    ));
  }
}


// class BookingDetailsScreen extends StatelessWidget{
//   @override
//   Widget build(BuildContext context){
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//           appBar: AppBar(
//             title: Text('Booking Details', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black)),
//             centerTitle: true,
//             backgroundColor: Colors.transparent,
//             elevation: 0.0,
//           ),
//           body: ListView(
//             padding: EdgeInsets.all(10.0),
//             children: [
//
//               Container(
//                 height: 45.0.h,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//                 child: TabBar(
//                   indicator: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
//                     ),
//                     borderRadius: BorderRadius.circular(20.0),
//                   ),
//                   labelColor: Colors.white,
//                   unselectedLabelColor: Colors.black,
//                   tabs: [
//
//                     Tab(text: 'Upcoming',),
//                     Tab(text: 'Completed',),
//                     Tab(text: 'Cancelled',),
//
//                   ],
//                 ),
//               ),
//
//               Expanded(
//                 child: TabBarView(
//                   children: [
//
//                     BookingDetailsWidget(status: 'Upcoming'),
//                     BookingDetailsWidget(status: 'Completed',),
//                     BookingDetailsWidget(status: 'Cancelled'),
//
//                   ],
//                 ),
//               )
//
//             ],
//           ),
//       ),
//     );
//   }
// }