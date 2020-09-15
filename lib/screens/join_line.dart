import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noLine/widgets/line_number_form.dart';
import 'package:noLine/services/firestore_adapter.dart';
import 'package:noLine/main.dart';
import 'package:noLine/utils/cookie_manager.dart';
import 'package:noLine/screens/client_in_line.dart';

class JoinLine extends StatefulWidget {
  @override
  _JoinLineState createState() => _JoinLineState();
}

class _JoinLineState extends State<JoinLine> {
  final textController = TextEditingController();
  final firestoreAdapter = FirestoreAdapter();

  String text = "";

  String userId;

  Future<bool> handleSubmit(int lineId) async {
    QuerySnapshot lineCollection = await firestoreAdapter.getCollection(lineId.toString());

    //Line Doesn't Exist
    if (lineCollection.size == 0) {
      setState(() {
        text = "Requested line doesn't exist";
      });
      return false;
    }

    DocumentSnapshot lineData =
        await firestoreAdapter.getDocument(lineId.toString(), "line_data");
    int lastPlaceInLine = ++lineData.data()["lastPlaceInLine"];

    userId = CookieManager.getCookie("userId");
    //If User Doesn't Have A Cookie We Create A New Document And Save The Document Id As The User Id
    if (userId == "") {
      DocumentReference newUserDocument = await firestoreAdapter
          .addDocument(lineId.toString(), {"placeInLine": lastPlaceInLine});
      CookieManager.addToCookie("userId", newUserDocument.id);
      userId = newUserDocument.id;
    }
    //If The User Has An Id We Check If He's In Line
    //If True We Continue
    //If Not We Add Him In Last Place
    else {
      DocumentSnapshot userData =
          await firestoreAdapter.getDocument(lineId.toString(), userId);
      if (userData.exists) {
        return true;
      }

      await firestoreAdapter
          .updateDocument(lineId.toString(), userId, {"placeInLine": lastPlaceInLine});
    }

    await firestoreAdapter.updateDocument(
        lineId.toString(), "line_data", {"lastPlaceInLine": lastPlaceInLine},
        merge: true);

    return true;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: MyAppBar(context),
        body: Center(
          child: Column(
            children: <Widget>[
              Text(
                "Enter line code",
                style: TextStyle(
                    fontSize: screenHeight * 0.09, fontFamily: 'LinLibertine'),
              ),
              LineNumberForm((int lineId) async {
                if (await handleSubmit(lineId)) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  InLine(lineId, userId)));
                    }
              }),
              Text("Or scan the QR code from\n your line manager",
                  textAlign: TextAlign.center),
              Text(text),
            ],
          ),
        ));
  }
}
