import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

class LineManagement extends StatefulWidget {
  LineManagement(AppBar appBar, {Key key}) : super(key: key) {
    this.appBar = appBar;
  }

  AppBar appBar;

  @override
  _LineManagementState createState() => _LineManagementState();
}

class _LineManagementState extends State<LineManagement> {
  final FocusNode _pinPutFocusNode = FocusNode();
  final TextEditingController _pinPutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final TextStyle titleStyle = TextStyle(
        fontSize: screenSize.height / 10,
        fontWeight: FontWeight.bold,
        fontFamily: "OpenSans");
    final TextStyle subTitleStyle =
        TextStyle(fontSize: screenSize.height / 20, fontFamily: "OpenSans");
    final BoxDecoration pinPutDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: Colors.black.withOpacity(.5),
      ),
    );

    return Scaffold(
      appBar: widget.appBar,
      body: Center(
        child: Column(
          children: [
            Text(
              "Line Management",
              style: titleStyle,
            ),
            Text(
              "Enter existing line code",
              style: subTitleStyle,
            ),
            SizedBox(
              height: screenSize.height / 20,
            ),
            Form(
              child: Column(
                children: [
                  Container(
                    width: screenSize.height * 0.8,
                    child: PinPut(
                      fieldsCount: 5,
                      eachFieldHeight: 40.0,
                      onSubmit: (String pin) {},
                      focusNode: _pinPutFocusNode,
                      controller: _pinPutController,
                      submittedFieldDecoration: pinPutDecoration.copyWith(
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                              color: Theme.of(context).primaryColor)),
                      selectedFieldDecoration: pinPutDecoration,
                      followingFieldDecoration: pinPutDecoration.copyWith(
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height / 20,
                  ),
                  Container(
                    width: screenSize.height * 0.8,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      onPressed: () {},
                      child: FittedBox(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: screenSize.width / 100),
                          child: Text(
                            "SUBMIT",
                            style: subTitleStyle
                                .merge(TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: screenSize.height / 20,
            ),
            Text(
              "OR",
              style: subTitleStyle,
            ),
            SizedBox(
              height: screenSize.height / 20,
            ),
            Container(
              width: screenSize.height * 0.8,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                onPressed: () {},
                child: FittedBox(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: screenSize.width / 100),
                    child: Text(
                      "create a new line",
                      style:
                          subTitleStyle.merge(TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                color: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
