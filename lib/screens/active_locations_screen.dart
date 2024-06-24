import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ActiveLocationsScreen extends StatefulWidget {
  const ActiveLocationsScreen({Key? key}) : super(key: key);

  @override
  _ActiveLocationsScreenState createState() => _ActiveLocationsScreenState();
}

class _ActiveLocationsScreenState extends State<ActiveLocationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('locations').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemBuilder: (context, index){
              return ListTile(
                title: Text(snapshot.data!.docs[index].toString()),
              );
            },
          );
        },
      )
    );
  }
}
