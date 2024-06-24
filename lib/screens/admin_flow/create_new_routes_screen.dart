import 'package:cabmode/resources/firestore_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../admin_flow/route_detail_screen.dart';

class CreateNewRoutesScreen extends StatefulWidget {
  const CreateNewRoutesScreen({Key? key}) : super(key: key);

  @override
  _CreateNewRoutesScreenState createState() => _CreateNewRoutesScreenState();
}

class _CreateNewRoutesScreenState extends State<CreateNewRoutesScreen> {
  final TextEditingController _startLocationController =
      TextEditingController();
  final TextEditingController _endLocationController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  showMyBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: (context),
      builder: (context) {
        return SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _startLocationController,
                  decoration: InputDecoration(
                    labelText: 'Add Start location',
                  ),
                ),
                TextField(
                  controller: _endLocationController,
                  decoration: InputDecoration(labelText: 'Add End Location'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: createNewLocation,
                  child: Text('Submit'),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  createNewLocation() {
    FirestoreMethods().SetLocation(
        _startLocationController.text, _endLocationController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Locations'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('locations').snapshots(),
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
                  return ListTile(
                    title: Text(
                        snapshot.data!.docs[index].data()['startLocation'] +
                            ' to ' +
                            snapshot.data!.docs[index].data()['endLocation']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RouteDetailScreen(
                            startLocation: snapshot.data!.docs[index]
                                .data()['startLocation'],
                            endLocation: snapshot.data!.docs[index]
                                .data()['endLocation'],
                            driversOnLocation: snapshot.data!.docs[index]
                                .data()['driversOnLocation'],
                            userOnLocation: snapshot.data!.docs[index]
                                .data()['userOnLocation'],
                            documentId: snapshot.data!.docs[index].data()['locationId'],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Some error occurred'),
              );
            }
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showMyBottomSheet,
        child: Icon(Icons.add_location),
      ),
    );
  }
}
