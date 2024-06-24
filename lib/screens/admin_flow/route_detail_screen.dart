import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RouteDetailScreen extends StatefulWidget {
  final String? documentId;
  final String? startLocation;
  final String? endLocation;
  final userOnLocation;
  final driversOnLocation;

  RouteDetailScreen({
    this.documentId,
    this.startLocation,
    this.endLocation,
    this.userOnLocation,
    this.driversOnLocation,
  });

  _RouteDetailScreenState createState() => _RouteDetailScreenState();
}

class _RouteDetailScreenState extends State<RouteDetailScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('${widget.startLocation} to ${widget.endLocation}'),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text('Drivers'),
              ),
              Tab(
                child: Text('Users'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('location').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return snapshot.data!.docs[index]
                                    .data()['driversOnLocation'] ==
                                null
                            ? Center(
                                child:
                                    Text('No drivers active on this location'),
                              )
                            : ListTile();
                      },
                    );
                  }
                }
                return Container(child: Text('ama '),);
              },
            ),
            Center(
              child: Text('Users'),
            ),
          ],
        ),
      ),
    );
  }
}
