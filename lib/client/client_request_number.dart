import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noLine/firestore_adapter.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class RequestNumber extends StatefulWidget {
  final screenWidth;
  final screenHeight;
  final textController;
  final lineId;
  final userId;

  final firestoreAdapter = FirestoreAdapter();

  RequestNumber(this.screenWidth, this.screenHeight, this.textController,
      this.lineId, this.userId);

  @override
  _RequestNumberState createState() => _RequestNumberState();
}

class _RequestNumberState extends State<RequestNumber> {
  PhoneNumber number = PhoneNumber(isoCode: 'IL');
  bool numberValid = false;
  bool numberSubmitted = false;

  void handleSubmit() {
    print(
        "phone: " + number.phoneNumber + ", valid: " + numberValid.toString());

    widget.firestoreAdapter.updateDocument('smsWatchers', widget.userId, {
      'lineId': widget.lineId,
      'phoneNumber': widget.textController.text,
      'userId': widget.userId
    });

    setState(() {
      numberSubmitted = true;
      numberValid =
          true; // number validator isn't working currently, set it there when it's working
    });
  }

  @override
  Widget build(BuildContext context) {
    return (numberSubmitted && numberValid)
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
                width: widget.screenWidth * .5,
                height: widget.screenHeight * .08,
                child: InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {
                    this.number = number;
                  },
                  selectorTextStyle: TextStyle(color: Colors.black),
                  initialValue: number,
                  textFieldController: widget.textController,
                  inputBorder: OutlineInputBorder(),
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
              Visibility(
                visible: numberSubmitted && !numberValid,
                child: Text(
                  'Invalid phone number! Try again',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: widget.screenHeight * .03,
                      fontFamily: 'LinLibertine'),
                ),
              ),
            ],
          );
  }
}
