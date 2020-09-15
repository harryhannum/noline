import 'package:flutter/material.dart';
import 'package:noLine/services/firestore_line_fetcher.dart';
import 'package:noLine/widgets/line_view_container.dart';
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
              style: titleStyle,
            ),
            StreamBuilder(
                stream: firestoreLineFetcher
                    .getLineStreamFromFirestore(widget.lineId.toString()),
                builder: (context, snapshot) {
                  Line line = snapshot?.data ?? Line();
                  return LineViewContainer(line: line);
                }),
            Text(
              "Scan the QR code to join the line",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              width: screenSize.height / 10,
            ),
            Container(
                width: screenSize.height / 4,
                height: screenSize.height / 4,
                child: Image.asset('assets/images/qr.png'))
          ],
        ),
      ),
    );
  }
}
