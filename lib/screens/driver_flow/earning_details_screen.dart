import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EarningDetailsScreen extends StatefulWidget{
  _EarningDetailsScreenState createState() => _EarningDetailsScreenState();
}

class _EarningDetailsScreenState extends State<EarningDetailsScreen>{
  @override
  Widget build(BuildContext context){
    int totalMoneyEarned = 300;

    return Scaffold(
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: 20.0.h,),

                //Row for back arrow and Page title
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
                    Expanded(child: Container(),),
                    Text(
                      'Your earning',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Expanded(child: Container()),
                  ],
                ),

                SizedBox(height: 20.0.h,),

                //Row for total balance
                Row(
                  children: [

                    Text('Your balance', style: Theme.of(context).textTheme.titleSmall,),

                    Expanded(child: Container(),),

                    Text('${totalMoneyEarned}rs', style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: 25.0),),

                  ],
                ),

                Divider(),

                Text('Transaction History', style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),),

                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) => ListTile(
                    leading: CircleAvatar(),
                    title: Text('Name'),
                    subtitle: Row(
                      children: [

                        Text('Success', style: TextStyle(color: Colors.green),),

                        SizedBox(width: 10.0.w,),

                        Text('date and time'),


                      ],
                    ),
                    trailing: Text('20rs', style: Theme.of(context).textTheme.titleMedium,),
                  ),
                ),


              ],
            ),
          ),
        )
    );
  }
}