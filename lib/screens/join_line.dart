import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noLine/widgets/line_number_form.dart';
import 'package:noLine/services/firestore_adapter.dart';
import 'package:noLine/main.dart';

class JoinLine extends StatefulWidget {
  @override
  _JoinLineState createState() => _JoinLineState();
}

class _JoinLineState extends State<JoinLine> {
  final textController = TextEditingController();
  final firestoreAdapter = FirestoreAdapter();

  String errorText = "";
  String userId;

  Future<bool> handleSubmit(int lineId) async {
    QuerySnapshot lineCollection =
        await firestoreAdapter.getCollection(lineId.toString());

    //Line Doesn't Exist
    if (lineCollection.size == 0) {
      setState(() {
        errorText = "Requested line doesn't exist";
      });
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final TextStyle titleStyle =
        TextStyle(fontSize: screenSize.height * 0.09, fontFamily: 'OpenSans');
    final TextStyle subTitleStyle =
        TextStyle(fontSize: screenSize.height * 0.02, fontFamily: "OpenSans");
    final TextStyle errorTextStyle = TextStyle(
        fontSize: screenSize.height * 0.03,
        fontFamily: "OpenSans",
        color: Colors.red);

    return Scaffold(
        appBar: MyAppBar(context),
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: screenSize.height * 0.05),
              Text(
                "Enter line code",
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    .merge(TextStyle(color: Colors.black54)),
              ),
              SizedBox(height: screenSize.height * 0.05),
              LineNumberForm((int lineId) async {
                if (await handleSubmit(lineId)) {
                  Navigator.pushNamed(context, '/in-line',
                      arguments: {'lineId': lineId});
                }
              }),
              SizedBox(height: screenSize.height * 0.05),
              Text("Or scan the QR code from your line manager",
                  style: subTitleStyle, textAlign: TextAlign.center),
              Text(errorText, style: errorTextStyle),
              Container(
                height: screenSize.height / 3.2,
                child: Image.asset("assets/images/qr_scan.jpg"),
              ),
            ],
          ),
        ));
  }
}
