import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

class LineNumberForm extends StatefulWidget {
  final void Function(int lineId) onSubmit;

  LineNumberForm(this.onSubmit);

  @override
  _LineNumberFormState createState() => _LineNumberFormState();
}

class _LineNumberFormState extends State<LineNumberForm> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final FocusNode _pinPutFocusNode = FocusNode();
    final TextEditingController _pinPutController = TextEditingController();

    final BoxDecoration pinPutDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: Colors.black45,
      ),
    );

    bool isNumeric(String s) {
      if (s == null) {
        return false;
      }
      return double.parse(s, (e) => null) != null;
    }

    return Form(
      child: Column(
        children: [
          Container(
            width: screenSize.height * 0.5,
            child: PinPut(
              fieldsCount: 4,
              eachFieldHeight: screenSize.height * 0.07,
              eachFieldWidth: screenSize.height * 0.06,
              textStyle: Theme.of(context)
                  .textTheme
                  .headline4
                  .merge(TextStyle(color: Colors.black87)),
              onSubmit: (String pin) {},
              focusNode: _pinPutFocusNode,
              autofocus: true,
              controller: _pinPutController,
              submittedFieldDecoration: pinPutDecoration.copyWith(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Colors.black12)),
              selectedFieldDecoration: pinPutDecoration,
              followingFieldDecoration: pinPutDecoration.copyWith(
                border: Border.all(
                  color: Colors.black54,
                ),
              ),
              validator: (string) {
                return (isNumeric(string) && int.parse(string) > 999)
                    ? null
                    : "Please enter a valid code";
              },
            ),
          ),
          SizedBox(
            height: screenSize.height / 30,
          ),
          Container(
            width: screenSize.height * 0.6,
            height: screenSize.height * 0.08,
            child: RaisedButton(
                color: Colors.white.withOpacity(0.20),
                onPressed: () {
                  if (isNumeric(_pinPutController.text)) {
                    widget.onSubmit(int.parse(_pinPutController.text));
                  }
                },
                child: Container(
                  width: screenSize.width / 2,
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
          ),
        ],
      ),
    );
  }
}
