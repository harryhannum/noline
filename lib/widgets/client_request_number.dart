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
    final Size screenSize = MediaQuery.of(context).size;

    final TextStyle subTitleStyle =
        TextStyle(fontSize: screenSize.height * .05, fontFamily: "OpenSans");

    return RequestNumber.numberRequested
        ? Container()
        : Column(
            children: [
              Text(
                'Leave a phone number and we will call you \nwhen its close to your turn: ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: widget.screenHeight * .02,
                    fontFamily: 'OpenSans'),
              ),
              Container(
                width: widget.screenWidth * .25,
                height: widget.screenHeight * .08,
                child: TextField(
                  controller: widget.textController,
                  style: TextStyle(fontFamily: 'OpenSans'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              Container(
            width: screenSize.height * 0.7,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              onPressed: () {
                handleSubmit();
              },
              child: FittedBox(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: screenSize.width / 100),
                  child: Text(
                    "submit",
                    style: subTitleStyle.merge(TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              color: Theme.of(context).primaryColor,
            ),
          )
            ],
          );
  }
}
