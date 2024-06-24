import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewRideRequestWidget extends StatelessWidget {
  String? cusImage;
  String? customerName;
  String? minutesAge;
  double? customerRating;
  String? fareOffered;

  NewRideRequestWidget({
    this.cusImage,
    this.customerName,
    this.customerRating,
    this.minutesAge,
    this.fareOffered,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 5.0.h,
      ),
      child: Container(
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
                backgroundImage: AssetImage(cusImage!),
                backgroundColor: Colors.transparent,
              ),
              title: Text(
                customerName!,
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
                    width: 4.0.w,
                  ),
                  Text(
                    '${minutesAge!} mins ago',
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
                    customerRating.toString(),
                    style: TextStyle(
                      fontSize: 15.0.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              trailing: Text(
                '${fareOffered} Rs',
                style: TextStyle(
                  fontSize: 20.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Divider(),

            //Row for seats requested
            Row(
              children: [
                Text('Requested for Seats:'),
                SizedBox(
                  width: 10.0.w,
                ),
                Container(
                  height: 20.0.h,
                  width: 10.0.w,
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                  ),
                )
              ],
            ),

            Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.40,
                  height: 35.0.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(
                        color: Colors.red,
                      )),
                  child: Center(
                    child: Text(
                      'Decline',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0.w,
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Text('Under Process')));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.40,
                    height: 35.0.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        gradient: LinearGradient(
                          colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary,],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )
                    ),
                    child: Center(
                      child: Text(
                        'Accept',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
