import 'package:flutter/material.dart';
import 'client_request_number.dart';
import 'package:noLine/firestore_adapter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InLine extends StatefulWidget {
  final String lineId;
  final String userId;

  InLine(this.lineId, this.userId);

  @override
  _InLineState createState() => _InLineState();
}

class _InLineState extends State<InLine> {
  final textController = TextEditingController();
  final firestoreAdapter = FirestoreAdapter();

  String _positionInLine = "";
  String _waitTime = "";

  int currentPositionInLine = 0;
  int userPositionInLine = 0;

  @override
  void initState() {
    super.initState();

    setState(() async {
      await getPosition();
      await getWaitTime();
    });
  }

  Future<void> getCurrentPositionInLine() async {
    DocumentSnapshot documentSnapshot =
        await firestoreAdapter.getDocument(widget.lineId, 'line_data');
    this.currentPositionInLine = documentSnapshot.data()['currentPlaceInLine'];

    print("lineId: " +
        widget.lineId +
        "currentPositionInLine: " +
        this.currentPositionInLine.toString());
  }

  Future<void> getUserPositionInLine() async {
    DocumentSnapshot documentSnapshot =
        await firestoreAdapter.getDocument(widget.lineId, widget.userId);
    this.userPositionInLine = documentSnapshot.data()['placeInLine'];

    print("lineId: " +
        widget.lineId +
        "userId: " +
        widget.userId +
        "userPlaceInLine: " +
        this.currentPositionInLine.toString());
  }

  Future<void> getPosition() async {
    await getCurrentPositionInLine();
    await getUserPositionInLine();

    _positionInLine =
        (this.userPositionInLine - this.currentPositionInLine).toString();
  }

  Future<void> getWaitTime() async {
    await getCurrentPositionInLine();
    await getUserPositionInLine();

    _waitTime = ((this.userPositionInLine - this.currentPositionInLine) * 3.14)
        .floor()
        .toString();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Column(children: [
          SizedBox(height: screenHeight * .04),
          Text(
            'You are in the line!',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: screenHeight * .09,
                fontFamily: 'LinLibertine'),
          ),
          SizedBox(height: screenHeight * .06),
          Text(
            'Your position:',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: screenHeight * .06,
                fontFamily: 'LinLibertine'),
          ),
          Text(
            _positionInLine,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: screenHeight * .04,
                fontFamily: 'LinLibertine'),
          ),
          SizedBox(height: screenHeight * .03),
          Text(
            'Estimated wait time: ' + _waitTime,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: screenHeight * .03,
                fontFamily: 'LinLibertine'),
          ),
          SizedBox(height: screenHeight * .03),
          RequestNumber(screenWidth, screenHeight, textController)
        ]),
      ),
    );
  }
}
