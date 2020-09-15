import 'package:flutter/material.dart';
import 'package:noLine/firestore_adapter.dart';
import 'package:noLine/firestore_line_fetcher.dart';
import 'package:noLine/line_view_container.dart';
import 'package:noLine/main.dart';
import 'package:noLine/models/line.dart';

class LineManagement extends StatefulWidget {
  final lineId;

  LineManagement({this.lineId = "0000", Key key}) : super(key: key);

  @override
  _LineManagementState createState() => _LineManagementState();
}

class _LineManagementState extends State<LineManagement> {
  final FirestoreLineFetcher firestoreLineFetcher = FirestoreLineFetcher();
  final FirestoreAdapter firestoreAdapter = FirestoreAdapter();
  Stream<Line> lineStream;
  void advanceLine(Line line) {
    setState(() {
      firestoreAdapter.updateDocument(widget.lineId, "line_data",
          {"currentPlaceInLine": (line.currentPlaceInLine + 1)},
          merge: true);
    });
  }

  @override
  void initState() {
    lineStream = firestoreLineFetcher.getLineStreamFromFirestore(widget.lineId);

    super.initState();
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
              stream: lineStream,
              builder: (context, snapshot) {
                Line line = snapshot?.data ?? Line();

                return Column(
                  children: [
                    Text(
                      "Line Management",
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .merge(TextStyle(color: Colors.black54)),
                    ),
                    Text("Line ${widget.lineId ?? " Not Recognized"}",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .merge(TextStyle(color: Colors.black87))),
                    SizedBox(
                      height: screenSize.height / 40,
                    ),
                    LineViewContainer(
                      line: line,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: screenSize.height / 45),
                      width: screenSize.height / 1.5,
                      height: screenSize.height / 3.5,
                      child: Image.asset("assets/images/line.png"),
                    ),
                    Container(
                      width: screenSize.height * 0.7,
                      child: MaterialButton(
                          color: Colors.white.withOpacity(0.20),
                          onPressed: () {
                            if (((line?.currentPlaceInLine) ?? 0) >=
                                ((line?.lastPlaceInLine) ?? 0)) {
                              return;
                            }
                            advanceLine(line);
                          },
                          child: Container(
                            width: screenSize.width / 2,
                            height: screenSize.height / 15,
                            child: FittedBox(
                                child: Text(
                              'NEXT PLEASE',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .merge(TextStyle(color: Colors.black87)),
                            )),
                          )),
                    ),
                    SizedBox(
                      height: screenSize.height / 40,
                    ),
                    Container(
                      width: screenSize.height * 0.7,
                      child: RaisedButton(
                          color: Colors.white.withOpacity(0.20),
                          onPressed: () {
                            Navigator.pushNamed(context, '/line-view',
                                arguments: widget.lineId);
                          },
                          child: Container(
                            width: screenSize.width / 2,
                            height: screenSize.height / 15,
                            child: FittedBox(
                                child: Text(
                              'View the line to your customers',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .merge(TextStyle(color: Colors.black87)),
                            )),
                          )),
                    ),
                  ],
                );
              }),
        ],
      )),
    );
  }
}
