import 'package:flutter/material.dart';
import 'package:noLine/main.dart';
import '../widgets/client_request_number.dart';
import 'package:noLine/services/firestore_adapter.dart';
import 'package:noLine/services/firestore_line_fetcher.dart';
import 'package:noLine/models/line.dart';

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
  final firestoreLineFetcher = FirestoreLineFetcher();

  int currentPositionInLine = 0;
  int userPositionInLine = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final TextStyle titleStyle =
        TextStyle(fontSize: screenSize.height * .08, fontFamily: 'OpenSans');
    final TextStyle contentStyle =
        TextStyle(fontSize: screenSize.height * .04, fontFamily: "OpenSans");

    return Scaffold(
      appBar: MyAppBar(context),
      body: Center(
        child: Column(children: [
          SizedBox(height: screenSize.height * .04),
          Text('You are in the line!',
              textAlign: TextAlign.center, style: titleStyle),
          SizedBox(height: screenSize.height * .06),
          SizedBox(
            width: screenSize.height / 3.5,
            height: screenSize.height / 4,
            child: Container(
              padding: EdgeInsets.all(screenSize.height / 50),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 2.0),
                    blurRadius: 3.0,
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      "Your position:",
                      style: contentStyle,
                      textAlign: TextAlign.center,
                    ),
                    StreamBuilder(
                        stream: firestoreLineFetcher.getLineStreamFromFirestore(
                            widget.lineId.toString()),
                        builder: (context, snapshot) {
                          Line line = snapshot?.data ?? Line();

                          return Text(
                            line.usersInLine == null
                                ? ''
                                : (line.usersInLine
                                            .where((user) =>
                                                user.id == widget.userId)
                                            .first
                                            .placeInLine -
                                        line.currentPlaceInLine)
                                    .toString(),
                            textAlign: TextAlign.center,
                            style: contentStyle,
                          );
                        }),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: screenSize.height * .03),
          StreamBuilder(
              stream: firestoreLineFetcher
                  .getLineStreamFromFirestore(widget.lineId.toString()),
              builder: (context, snapshot) {
                Line line = snapshot?.data ?? Line();
                return Text(
                  'Estimated wait time: ' +
                      (line.usersInLine == null
                          ? ''
                          : ((line.usersInLine
                                          .where((user) =>
                                              user.id == widget.userId)
                                          .first
                                          .placeInLine -
                                      line.currentPlaceInLine) *
                                  3.14)
                              .floor()
                              .toString()),
                  textAlign: TextAlign.center,
                  style: contentStyle,
                );
              }),
          SizedBox(height: screenSize.height * .03),
          RequestNumber(screenSize.width, screenSize.height, textController,
              widget.lineId, widget.userId)
        ]),
      ),
    );
  }
}
