import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noLine/services/firestore_adapter.dart';

class RequestNumber extends StatefulWidget {
  final screenWidth;
  final screenHeight;
  final textController;
  final lineId;
  final userId;

  final firestoreAdapter = FirestoreAdapter();
  static bool numberRequested = false;

  RequestNumber(this.screenWidth, this.screenHeight, this.textController,
      this.lineId, this.userId);

  @override
  _RequestNumberState createState() => _RequestNumberState();
}

class _RequestNumberState extends State<RequestNumber> {
  void handleSubmit() {
    print(widget.textController.text);
    print(RequestNumber.numberRequested);

    widget.firestoreAdapter.updateDocument('smsWatchers', widget.userId, {
      'lineId': widget.lineId,
      'phoneNumber': widget.textController.text,
      'userId': widget.userId
    });

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
