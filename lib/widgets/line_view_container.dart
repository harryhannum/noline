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

    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                      "Current Place In Line:",
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .merge(TextStyle(color: Colors.black87)),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "${widget.line.currentPlaceInLine ?? "-"}",
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .merge(TextStyle(color: Colors.black87)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: screenSize.height / 20,
            height: 1,
          ),
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
                      "Last Place In Line:",
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .merge(TextStyle(color: Colors.black87)),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "${widget.line.lastPlaceInLine ?? "-"}",
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .merge(TextStyle(color: Colors.black87)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        width: screenSize.height / 40,
        height: 1,
      ),
    ]);
  }
}
