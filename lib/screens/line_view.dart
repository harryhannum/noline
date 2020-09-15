import 'dart:math';

import 'package:flutter/material.dart';
import 'package:noLine/firestore_line_fetcher.dart';
import 'package:noLine/line_view_container.dart';
import 'package:noLine/main.dart';
import 'package:noLine/models/line.dart';

class LineView extends StatefulWidget {
  final String lineId; // lol

  LineView(this.lineId);

  @override
  _LineViewState createState() => _LineViewState();
}

class _LineViewState extends State<LineView> {
  final FirestoreLineFetcher firestoreLineFetcher = FirestoreLineFetcher();
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final TextStyle titleStyle = TextStyle(
        fontSize: screenSize.height / 10,
        fontWeight: FontWeight.bold,
        fontFamily: "OpenSans");

    return Scaffold(
      appBar: MyAppBar(context),
      body: Center(
        child: Column(
          children: [
            Text(
              "Line #${widget.lineId}",
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  .merge(TextStyle(color: Colors.black54)),
            ),
            StreamBuilder(
                stream: firestoreLineFetcher
                    .getLineStreamFromFirestore(widget.lineId.toString()),
                builder: (context, snapshot) {
                  Line line = snapshot?.data ?? Line();
                  return LineViewContainer(line: line);
                }),
            SizedBox(
              height: screenSize.height / 20,
            ),
            Text(
              "Scan the QR code to join the line",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: screenSize.height / 30,
            ),
            Container(
                width: min(screenSize.width / 3, screenSize.height / 3.5),
                height: min(screenSize.width / 3, screenSize.height / 3.5),
                child: Image.asset('assets/images/qr.png')),
            SizedBox(
              height: screenSize.height / 30,
            ),
            Text(
              "Or text this phone number any message to join",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              "+1 7207306218",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline3,
            ),
          ],
        ),
      ),
    );
  }
}
