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
    final TextStyle boxTitlesStyle = Theme.of(context)
        .textTheme
        .headline5
        .merge(TextStyle(color: Colors.black87));
    final TextStyle numbersStyle = Theme.of(context).textTheme.headline3.merge(
        TextStyle(color: Colors.black87, fontSize: screenSize.height * .04));

    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: screenSize.height * .2,
            height: screenSize.height * .2,
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
                    Container(
                      height: screenSize.height * .07,
                      child: FittedBox(
                        child: Text("Current Place In Line:",
                            style: boxTitlesStyle, textAlign: TextAlign.center),
                      ),
                    ),
                    Text(
                      "${widget.line.currentPlaceInLine ?? "-"}",
                      style: numbersStyle,
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
            width: screenSize.height * .2,
            height: screenSize.height * .2,
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
                    Container(
                      height: screenSize.height * .07,
                      child: FittedBox(
                        child: Text("Last Place In Line:",
                            style: boxTitlesStyle, textAlign: TextAlign.center),
                      ),
                    ),
                    Text(
                      "${widget.line.lastPlaceInLine ?? "-"}",
                      style: numbersStyle,
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
