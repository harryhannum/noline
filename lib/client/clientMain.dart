import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noLine/NoLineTextField.dart';
import 'package:noLine/firestore_adapter.dart';
import 'package:noLine/main.dart';

class JoinLine extends StatefulWidget {
  @override
  _JoinLineState createState() => _JoinLineState();
}

class _JoinLineState extends State<JoinLine> {

  final textController = TextEditingController();
  final firestoreAdapter = FirestoreAdapter();

  String text = "loading";

  void handleSubmit() async
  {
    String line_id = textController.text;
    QuerySnapshot a = await firestoreAdapter.getCollection(line_id);

    if (a.docs.length == 0)
    {
      setState(() {
        text = "fail";
      });
      return;
    }
    setState(() {
    text = "success";
    });
    
    firestoreAdapter.updateDocument(line_id, "myname", {"name" : "raz", "phone" : 545454});

  }

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: MyAppBar(context),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("Enter line code",
            style: TextStyle(
              fontSize: screenHeight * 0.09,
              fontFamily: 'LinLibertine'
              ),
            ),
            NoLineTextField(
              textController,
              screenWidth * 0.2,
              screenHeight * 0.08
            ),
            FlatButton(
              onPressed: handleSubmit,
              child: Text("Submit")),
            Text("Or scan the QR code from\n your line manager",
              textAlign: TextAlign.center),
            Text(text),
          ],
        ),
      )
    );
  }
}