import 'package:flutter/material.dart';
import 'package:noLine/services/firestore_adapter.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class RequestNumber extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final TextEditingController textController;
  final int lineId;
  final String userId;

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
                'Leave a phone number and we will call you when its close to your turn: ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: widget.screenHeight * .02,
                    fontFamily: 'OpenSans'),
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
                      padding: EdgeInsets.symmetric(
                          vertical: screenSize.width / 100),
                      child: Text(
                        "submit",
                        style:
                            subTitleStyle.merge(TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
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
