import 'package:flutter/material.dart';
import 'package:noLine/firestore_adapter.dart';
import 'package:noLine/firestore_line_fetcher.dart';
import 'package:noLine/line_view_container.dart';
import 'package:noLine/main.dart';
import 'package:noLine/models/line.dart';

class LineManagement extends StatefulWidget {
  final lineId;

  LineManagement(this.lineId, {Key key}) : super(key: key);

  @override
  _LineManagementState createState() => _LineManagementState();
}

class _LineManagementState extends State<LineManagement> {
  final FirestoreLineFetcher firestoreLineFetcher = FirestoreLineFetcher();
  final FirestoreAdapter firestoreAdapter = FirestoreAdapter();

  void advanceLine(Line line) {
    setState(() {
      firestoreAdapter.updateDocument(widget.lineId, "line_data",
          {"currentPlaceInLine": (line.currentPlaceInLine + 1)},
          merge: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final TextStyle subTitleStyle =
        TextStyle(fontSize: screenSize.height / 20, fontFamily: "OpenSans");

    return Scaffold(
      appBar: MyAppBar(context),
      body: Center(
          child: Column(
        children: [
          StreamBuilder(
              stream: firestoreLineFetcher
                  .getLineStreamFromFirestore(widget.lineId),
              builder: (context, snapshot) {
                Line line = snapshot?.data ?? Line();

                return Column(
                  children: [
                    Text("Line Management"),
                    Text(
                      "Line ${widget.lineId}",
                      style: subTitleStyle,
                    ),
                    LineViewContainer(
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
                          ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/line-view',
                            arguments: widget.lineId);
                      },
                      child: FittedBox(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: screenSize.width / 100),
                          child: Text(
                            "View line",
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
