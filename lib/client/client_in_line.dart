import 'package:flutter/material.dart';
import 'client_request_number.dart';
import 'package:noLine/firestore_adapter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noLine/models/line.dart';
import 'package:noLine/firestore_line_fetcher.dart';

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
  final firestoreLineFetcher = FirestoreLineFetcher();

  String _positionInLine = "";
  String _waitTime = "";

  int currentPositionInLine = 0;
  int userPositionInLine = 0;

  @override
  void initState() {
    super.initState();
    updateStats();
    firestoreLineFetcher.getLineStreamFromFirestore(widget.lineId);
  }

  Future<void> updateStats() async {
    await getPosition();
    await getWaitTime();

    setState(() {});
  }

  Future<void> getCurrentPositionInLine() async {
    DocumentSnapshot documentSnapshot =
        await firestoreAdapter.getDocument(widget.lineId, 'line_data');
    this.currentPositionInLine = documentSnapshot.data()['currentPlaceInLine'];

    debugPrint("lineId: " +
        widget.lineId +
        ", currentPositionInLine: " +
        this.currentPositionInLine.toString());
  }

  Future<void> getUserPositionInLine() async {
    DocumentSnapshot documentSnapshot =
        await firestoreAdapter.getDocument(widget.lineId, widget.userId);
    this.userPositionInLine = documentSnapshot.data()['placeInLine'];

    debugPrint("lineId: " +
        widget.lineId +
        ", userId: " +
        widget.userId +
        ", userPlaceInLine: " +
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
          StreamBuilder(
              stream: firestoreLineFetcher
                  .getLineStreamFromFirestore(widget.lineId.toString()),
              builder: (context, snapshot) {
                Line line = snapshot?.data ?? Line();
                return Text(
                  (line.usersInLine
                              .where((user) => user.id == widget.userId)
                              .first
                              .placeInLine -
                          line.currentPlaceInLine)
                      .toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: screenHeight * .04,
                      fontFamily: 'LinLibertine'),
                );
              }),
          SizedBox(height: screenHeight * .03),
          StreamBuilder(
              stream: firestoreLineFetcher
                  .getLineStreamFromFirestore(widget.lineId.toString()),
              builder: (context, snapshot) {
                Line line = snapshot?.data ?? Line();
                return Text(
                  'Estimated wait time: ' +
                      ((line.usersInLine
                                      .where((user) => user.id == widget.userId)
                                      .first
                                      .placeInLine -
                                  line.currentPlaceInLine) *
                              3.14)
                          .floor()
                          .toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: screenHeight * .03,
                      fontFamily: 'LinLibertine'),
                );
              }),
          SizedBox(height: screenHeight * .03),
          RequestNumber(screenWidth, screenHeight, textController,
              widget.lineId, widget.userId)
        ]),
      ),
    );
  }
}
