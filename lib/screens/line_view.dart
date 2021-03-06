import 'dart:math';

import 'package:flutter/material.dart';
import 'package:noLine/services/firestore_line_fetcher.dart';
import 'package:noLine/widgets/line_view_container.dart';
import 'package:noLine/main.dart';
import 'package:noLine/models/line.dart';

class LineView extends StatefulWidget {
  final int lineId;

  LineView(this.lineId);

  @override
  _LineViewState createState() => _LineViewState();
}

class _LineViewState extends State<LineView> {
  final FirestoreLineFetcher firestoreLineFetcher = FirestoreLineFetcher();

  String qrCodeImageUrl(int lineId, int pixelsPerDimention) {
    String additionalSubstring = lineId == null ? "" : "%2F%23%2Fin-line%3Fid%3D${lineId}";
    
    // For example, https://noline-dbc7f.web.app/#/in-line?id=14
    return "https://chart.googleapis.com/chart?cht=qr&chl=https%3A%2F%2Fnoline-dbc7f.web.app${additionalSubstring}&chs=${pixelsPerDimention}x${pixelsPerDimention}&choe=UTF-8&chld=L|2";
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    double qrDimentions = min(screenSize.width * .35, screenSize.height * .35);

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
                width: qrDimentions,
                height: qrDimentions,
                child: Image.network(this.qrCodeImageUrl(widget.lineId, qrDimentions.toInt()))
            ),
            SizedBox(
              height: screenSize.height * .01,
            ),
            Text(
              "noline-dbc7f.web.app",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: screenSize.height * .02,
            ),
            Text(
              "Or text this phone number any message to join",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              "+1 2095632969",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline3,
            ),
          ],
        ),
      ),
    );
  }
}
