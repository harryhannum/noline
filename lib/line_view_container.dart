import 'package:flutter/material.dart';
import 'package:noLine/models/line.dart';

class LineViewContainer extends StatefulWidget {
  final Line line;

  LineViewContainer({Key key, this.line}) : super(key: key);

  @override
  _LineViewContainerState createState() => _LineViewContainerState();
}

class _LineViewContainerState extends State<LineViewContainer> {
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
