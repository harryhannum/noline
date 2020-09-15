import 'package:flutter/material.dart';
import 'package:noLine/services/firestore_adapter.dart';
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
      'lineId': widget.lineId.toString(),
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
    final Size screenSize = MediaQuery.of(context).size;

    final TextStyle subTitleStyle =
        TextStyle(fontSize: screenSize.height * .05, fontFamily: "OpenSans");

    return (numberSubmitted && numberValid)
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
                width: widget.screenHeight * 0.55,
                height: widget.screenHeight * .08,
                child: InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {
                    this.number = number;
                  },
                  countries: ['IL', 'US', 'IT', 'FR', 'SP', 'UA'],
                  selectorTextStyle: TextStyle(color: Colors.black),
                  initialValue: number,
                  textFieldController: widget.textController,
                  inputBorder: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: screenSize.height / 20,
              ),
              RaisedButton(
                  color: Colors.white.withOpacity(0.20),
                  onPressed: () {
                    handleSubmit();
                  },
                  child: Container(
                    width: screenSize.height / 2,
                    height: screenSize.height / 15,
                    child: FittedBox(
                        child: Text(
                      "submit",
                      style:
                          Theme.of(context).textTheme.headline1.merge(TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w300,
                              )),
                    )),
                  )),
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
