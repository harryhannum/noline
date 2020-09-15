import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noLine/services/firestore_adapter.dart';
import 'package:noLine/main.dart';
import 'package:noLine/widgets/line_number_form.dart';

class ManagerLogin extends StatefulWidget {
  ManagerLogin({Key key}) : super(key: key);

  @override
  _ManagerLoginState createState() => _ManagerLoginState();
}

class _ManagerLoginState extends State<ManagerLogin> {
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
                  .merge(TextStyle(color: Colors.black54)),
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
            LineNumberForm((int lineId) {
              Navigator.pushNamed(context, '/line-mangement',
                  arguments: lineId);
            }),
            Container(
              margin: EdgeInsets.all(screenSize.height / 100),
              child: Text(
                "OR",
                style: subTitleStyle,
              ),
            ),
            Container(
              width: screenSize.height * 0.65,
              child: RaisedButton(
                  color: Colors.white.withOpacity(0.20),
                  onPressed: () async {
                    int lineId = await createNewLinePressed();
                    Navigator.pushNamed(context, '/line-mangement',
                        arguments: lineId);
                  },
                  child: Container(
                    width: screenSize.width / 2,
                    height: screenSize.height / 15,
                    child: FittedBox(
                        child: Text(
                      'create a new line',
                      style:
                          Theme.of(context).textTheme.headline1.merge(TextStyle(
                                color: Colors.black87,
                              )),
                    )),
                  )),
            ),
            SizedBox(
              height: screenSize.height / 40,
            ),
            Container(
              height: screenSize.height / 3.2,
              child: Image.asset("assets/images/line_manager.jpg"),
            ),
          ],
        ),
      ),
    );
  }
}
