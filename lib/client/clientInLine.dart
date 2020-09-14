import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RequestNumber extends StatefulWidget {
  final screenWidth;
  final screenHeight;
  final textController;

  static bool numberRequested = false;

  RequestNumber(this.screenWidth, this.screenHeight, this.textController);

  @override
  _RequestNumberState createState() => _RequestNumberState();
}

class _RequestNumberState extends State<RequestNumber> {
  void handleSubmit() {
    print(widget.textController.text);
    print(RequestNumber.numberRequested);

    setState(() {
      RequestNumber.numberRequested = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RequestNumber.numberRequested
        ? Container()
        : Column(
            children: [
              Text(
                'Leave a phone number and we will call you \nwhen its close to your turn: ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: widget.screenHeight * .03,
                    fontFamily: 'LinLibertine'),
              ),
              Container(
                width: widget.screenWidth * .25,
                height: widget.screenHeight * .08,
                child: TextField(
                  controller: widget.textController,
                  style: TextStyle(fontFamily: 'LinLibertine'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              FlatButton(
                color: Colors.blueGrey[600],
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.blueGrey,
                onPressed: () {
                  handleSubmit();
                },
                child: Text(
                  "Submit",
                  style: TextStyle(fontSize: 20.0, fontFamily: 'LinLibertine'),
                ),
              ),
            ],
          );
  }
}

class InLine extends StatefulWidget {
  @override
  _InLineState createState() => _InLineState();
}

class _InLineState extends State<InLine> {
  final textController = TextEditingController();

  String getPosition() {
    print("Trying to get position");
    return '<your_position>';
  }

  String getWaitTime() {
    print("Trying to get wait time");
    return '<wait_time>';
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Column(children: [
          SizedBox(height: screenHeight * .04),
          Text(
            'You are in the line!',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: screenHeight * .09,
                fontFamily: 'LinLibertine'),
          ),
          SizedBox(height: screenHeight * .06),
          Text(
            'Your position:',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: screenHeight * .06,
                fontFamily: 'LinLibertine'),
          ),
          Text(
            getPosition(),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: screenHeight * .04,
                fontFamily: 'LinLibertine'),
          ),
          SizedBox(height: screenHeight * .03),
          Text(
            'Estimated wait time: ' + getWaitTime(),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: screenHeight * .03,
                fontFamily: 'LinLibertine'),
          ),
          SizedBox(height: screenHeight * .03),
          RequestNumber(screenWidth, screenHeight, textController)
        ]),
      ),
    );
  }
}
