import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noLine/services/firestore_adapter.dart';
import 'package:noLine/main.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:noLine/widgets/line_number_form.dart';

class ManagerLogin extends StatefulWidget {
  ManagerLogin({Key key}) : super(key: key);

  @override
  _ManagerLoginState createState() => _ManagerLoginState();
}

class _ManagerLoginState extends State<ManagerLogin> {
  final FocusNode _pinPutFocusNode = FocusNode();
  final TextEditingController _pinPutController = TextEditingController();
  final FirestoreAdapter firestoreAdapter = FirestoreAdapter();
  Future<int> createNewLinePressed() async {
    Random random = new Random();

    int randomLineId = random.nextInt(10000);

    QuerySnapshot lineSnapshot =
        await firestoreAdapter.getCollection(randomLineId.toString());
    while (lineSnapshot.docs.length != 0) {
      lineSnapshot =
          await firestoreAdapter.getCollection(randomLineId.toString());
      randomLineId = random.nextInt(10000);
    }

    firestoreAdapter.updateDocument(randomLineId.toString(), "line_data",
        {"currentPlaceInLine": 0, "lastPlaceInLine": 0});

    return randomLineId;
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final TextStyle subTitleStyle =
        TextStyle(fontSize: screenSize.height / 20, fontFamily: "OpenSans");
    final BoxDecoration pinPutDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: Colors.black45,
      ),
    );

    return Scaffold(
      appBar: MyAppBar(context),
      body: Center(
        child: Column(
          children: [
            Text(
              "Line Manager",
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  .merge(TextStyle(color: Colors.black87)),
            ),
            Text(
              "Enter existing line code",
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .merge(TextStyle(color: Colors.black87)),
            ),
            SizedBox(
              height: screenSize.height / 20,
            ),
            LineNumberForm((int lineID) {
              Navigator.pushNamed(context, '/line-mangement',
                  arguments: lineID.toString());
            }),
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
              width: screenSize.height * 0.7,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                onPressed: () async {
                  int lineId = await createNewLinePressed();
                  Navigator.pushNamed(context, '/line-mangement',
                      arguments: lineId.toString());
                },
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
