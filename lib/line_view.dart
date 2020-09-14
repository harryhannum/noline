import 'package:flutter/material.dart';
import 'package:noLine/models/line.dart';

class LineView extends StatefulWidget {
  final Line line;

  LineView({Key key, this.line}) : super(key: key);

  @override
  _LineViewState createState() => _LineViewState();
}

class _LineViewState extends State<LineView> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    final TextStyle subTitleStyle =
        TextStyle(fontSize: screenSize.height / 20, fontFamily: "OpenSans");

    return Column(children: [
      Text(
        "Line ${widget.line.lineId}",
        style: subTitleStyle,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: screenSize.height / 3,
            height: screenSize.height / 3,
            child: Center(
              child: Column(
                children: [
                  Text(
                    "Current Place In Line:",
                    style: subTitleStyle,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "#${widget.line.currentPlaceInLine}",
                    style: subTitleStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: screenSize.height / 20,
          ),
          SizedBox(
            width: screenSize.height / 3,
            height: screenSize.height / 3,
            child: Center(
              child: Column(
                children: [
                  Text(
                    "Last Place In Line:",
                    style: subTitleStyle,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "#${widget.line.lastPlaceInLine}",
                    style: subTitleStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    ]);
  }
}
