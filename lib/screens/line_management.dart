import 'package:flutter/material.dart';
import 'package:noLine/firestore_adapter.dart';
import 'package:noLine/firestore_line_fetcher.dart';
import 'package:noLine/line_view.dart';
import 'package:noLine/main.dart';
import 'package:noLine/models/line.dart';

class LineManagement extends StatefulWidget {
  LineManagement({Key key}) : super(key: key) {}

  @override
  _LineManagementState createState() => _LineManagementState();
}

class _LineManagementState extends State<LineManagement> {
  final FirestoreLineFetcher firestoreLineFetcher = FirestoreLineFetcher();
  final FirestoreAdapter firestoreAdapter = FirestoreAdapter();

  final lineID = "line";

  void advanceLine(Line line) {
    setState(() {
      firestoreAdapter.updateDocument(lineID, "line_data",
          {"currentPlaceInLine": (line.currentPlaceInLine + 1)},
          merge: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final TextStyle titleStyle = TextStyle(
        fontSize: screenSize.height / 10,
        fontWeight: FontWeight.bold,
        fontFamily: "OpenSans");
    final TextStyle subTitleStyle =
        TextStyle(fontSize: screenSize.height / 20, fontFamily: "OpenSans");

    return Scaffold(
      appBar: MyAppBar(context),
      body: Center(
          child: Column(
        children: [
          StreamBuilder(
              stream:
                  firestoreLineFetcher.getLineStreamFromFirestore(this.lineID),
              builder: (context, snapshot) {
                Line line = snapshot?.data ?? Line();

                return Column(
                  children: [
                    Text("Line Management"),
                    LineView(
                      line: line,
                    ),
                    ((line?.currentPlaceInLine) ?? 0) >=
                            ((line?.lastPlaceInLine) ?? 0)
                        ? Container()
                        : MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            onPressed: () {
                              advanceLine(line);
                            },
                            child: FittedBox(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: screenSize.width / 100),
                                child: Text(
                                  "NEXT PLEASE",
                                  style: subTitleStyle
                                      .merge(TextStyle(color: Colors.white)),
                                ),
                              ),
                            ),
                            color: Theme.of(context).primaryColor,
                          )
                  ],
                );
              }),
        ],
      )),
    );
  }
}
