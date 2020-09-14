import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noLine/firestore_adapter.dart';
import 'package:noLine/models/line.dart';
import 'package:noLine/models/user.dart';

class LineManagement extends StatefulWidget {
  LineManagement({Key key}) : super(key: key) {}

  @override
  _LineManagementState createState() => _LineManagementState();
}

class _LineManagementState extends State<LineManagement> {
  final FirestoreAdapter firestoreAdapter = FirestoreAdapter();
  final lineID = "line";

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final TextStyle titleStyle = TextStyle(
        fontSize: screenSize.height / 10,
        fontWeight: FontWeight.bold,
        fontFamily: "OpenSans");
    final TextStyle subTitleStyle =
        TextStyle(fontSize: screenSize.height / 20, fontFamily: "OpenSans");
    final BoxDecoration pinPutDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: Colors.black.withOpacity(.5),
      ),
    );

    return Scaffold(
      appBar: MyAppBar(context),
      body: Center(
          child: StreamBuilder(
              stream: firestoreAdapter.getCollectionStream(lineID),
              builder: (context, snapshot) {
                Line line = Line();
                line.lineId = lineID;

                for (DocumentSnapshot document in snapshot.data) {
                  if (document.id == "line_data") {
                    line.currentPlaceInLine =
                        document.data()["currentPlaceInLine"];
                  }

                  User user = User();
                  user.id = document.id;
                  user.placeInLine = document.data()["placeInLine"];

                  line.usersInLine.add(user);
                }

                return Column(
                  children: [
                    Text(
                      "Line Management",
                      style: titleStyle,
                    ),
                    Text(
                      "Line ${line.lineId}",
                      style: subTitleStyle,
                    ),
                    Text(
                      "Current Place In Line ${line.currentPlaceInLine}",
                      style: subTitleStyle,
                    ),
                    SizedBox(
                      height: screenSize.height / 20,
                    ),
                  ],
                );
              })),
    );
  }
}
