import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noLine/firestore_adapter.dart';
import 'package:noLine/main.dart';
import 'package:noLine/models/line.dart';
import 'package:noLine/models/user.dart';

class LineView extends StatefulWidget {
  LineView(int lineID) {
    this.lineID = lineID;
  }

  int lineID;

  @override
  _LineViewState createState() => _LineViewState();
}

class _LineViewState extends State<LineView> {
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
              "Line #${widget.lineID}",
              style: titleStyle,
            ),
            // Raz's widget here
            SizedBox(
              height: screenSize.height / 5,
            ),
            
            Container(
              child: Image.asset('assets/images/qr.png')
            )
          ],
        ),
      ),
    );
  }
}
