import 'package:flutter/material.dart';
import 'package:noLine/main.dart';
import '../widgets/client_request_number.dart';
import 'package:noLine/services/firestore_adapter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InLine extends StatefulWidget {
  final int lineId;
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
    updateStats();
  }

  Future<void> updateStats() async {
    await getPosition();
    await getWaitTime();

    setState(() {});
  }

  Future<void> getCurrentPositionInLine() async {
    DocumentSnapshot documentSnapshot =
        await firestoreAdapter.getDocument(widget.lineId.toString(), 'line_data');
    this.currentPositionInLine = documentSnapshot.data()['currentPlaceInLine'];

    debugPrint("lineId: " +
        widget.lineId.toString() +
        ", currentPositionInLine: " +
        this.currentPositionInLine.toString());
  }

  Future<void> getUserPositionInLine() async {
    DocumentSnapshot documentSnapshot =
        await firestoreAdapter.getDocument(widget.lineId.toString(), widget.userId);
    this.userPositionInLine = documentSnapshot.data()['placeInLine'];

    debugPrint("lineId: " +
        widget.lineId.toString() +
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
    final Size screenSize = MediaQuery.of(context).size;
    final TextStyle titleStyle =
        TextStyle(fontSize: screenSize.height * 0.09, fontFamily: 'OpenSans');
    final TextStyle subTitleStyle =
        TextStyle(fontSize: screenSize.height * 0.06, fontFamily: "OpenSans");
    final TextStyle errorTextStyle = TextStyle(
        fontSize: screenSize.height * 0.05,
        fontFamily: "OpenSans",
        color: Colors.red);

    return Scaffold(
      appBar: MyAppBar(context),
      body: Center(
        child: Column(children: [
          SizedBox(height: screenSize.height * 0.04),
          Text(
            'You are in the line!',
            textAlign: TextAlign.center,
            style: titleStyle
          ),
          SizedBox(height: screenSize.height * .06),
          Text(
            'Your position:',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: screenSize.height * .06,
                fontFamily: 'LinLibertine'),
          ),
          Text(
            _positionInLine,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: screenSize.height * .04,
                fontFamily: 'LinLibertine'),
          ),
          SizedBox(height: screenSize.height * .03),
          Text(
            'Estimated wait time: ' + _waitTime,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: screenSize.height * .03,
                fontFamily: 'LinLibertine'),
          ),
          SizedBox(height: screenSize.height * .03),
          RequestNumber(screenSize.width, screenSize.height, textController,
              widget.lineId, widget.userId)
        ]),
      ),
    );
  }
}
