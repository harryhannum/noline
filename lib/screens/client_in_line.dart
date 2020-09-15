import 'package:flutter/material.dart';
import 'package:noLine/main.dart';
import '../widgets/client_request_number.dart';
import 'package:noLine/services/firestore_adapter.dart';
import 'package:noLine/services/firestore_line_fetcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noLine/models/line.dart';
import 'package:noLine/utils/cookie_manager.dart';

class InLine extends StatefulWidget {
  final int lineId;

  InLine(this.lineId);

  @override
  _InLineState createState() => _InLineState();
}

class _InLineState extends State<InLine> {
  final textController = TextEditingController();
  final firestoreAdapter = FirestoreAdapter();
  final firestoreLineFetcher = FirestoreLineFetcher();

  String userId = "";

  int currentPositionInLine = 0;
  int userPositionInLine = 0;

  @override
  void initState() {
    super.initState();
    login(widget.lineId).whenComplete(() {
      setState(() {});
    });
  }

  Future<bool> login(int lineId) async {
    DocumentSnapshot lineData =
        await firestoreAdapter.getDocument(lineId.toString(), "line_data");
    int lastPlaceInLine = ++lineData.data()["lastPlaceInLine"];

    this.userId = CookieManager.getCookie("userId");

    //If User Doesn't Have A Cookie We Create A New Document And Save The Document Id As The User Id
    if (this.userId == "") {
      DocumentReference newUserDocument = await firestoreAdapter
          .addDocument(lineId.toString(), {"placeInLine": lastPlaceInLine});
      CookieManager.addToCookie("userId", newUserDocument.id);
      this.userId = newUserDocument.id;
    }
    //If The User Has An Id We Check If He's In Line
    //If True We Continue
    //If Not We Add Him In Last Place
    else {
      DocumentSnapshot userData =
          await firestoreAdapter.getDocument(lineId.toString(), this.userId);
      if (userData.exists) {
        return true;
      }

      await firestoreAdapter.updateDocument(
          lineId.toString(), this.userId, {"placeInLine": lastPlaceInLine});
    }

    await firestoreAdapter.updateDocument(
        lineId.toString(), "line_data", {"lastPlaceInLine": lastPlaceInLine},
        merge: true);

    return true;
  }

  @override
  Widget build(BuildContext context) {
    print(context);
    final Size screenSize = MediaQuery.of(context).size;
    final TextStyle titleStyle =
        TextStyle(fontSize: screenSize.height * .08, fontFamily: 'OpenSans');
    final TextStyle contentStyle =
        TextStyle(fontSize: screenSize.height * .04, fontFamily: "OpenSans");

    return Scaffold(
      appBar: MyAppBar(context),
      body: Center(
        child: Column(children: [
          SizedBox(height: screenSize.height * .04),
          Text('You are in line #${widget.lineId}!',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  .merge(TextStyle(color: Colors.black54))),
          SizedBox(height: screenSize.height * .06),
          SizedBox(
            width: screenSize.height / 2.5,
            height: screenSize.height / 4.5,
            child: Container(
              padding: EdgeInsets.all(screenSize.height / 50),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 2.0),
                    blurRadius: 3.0,
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Center(
                child: Column(
                  children: [
                    StreamBuilder(
                        stream: firestoreLineFetcher.getLineStreamFromFirestore(
                            widget.lineId.toString()),
                        builder: (context, snapshot) {
                          Line line = snapshot?.data ?? Line();
                          bool isLoading =
                              line.usersInLine == null || this.userId == "";

                          int myPlaceInLine = isLoading
                              ? -1
                              : (line.usersInLine
                                      .where((user) => user.id == this.userId)
                                      .first
                                      .placeInLine -
                                  line.currentPlaceInLine);

                          return (myPlaceInLine == -1)
                              ? Text(
                                  "Loading...",
                                  style: contentStyle,
                                  textAlign: TextAlign.center,
                                )
                              : (myPlaceInLine <= 0)
                                  ? Text(
                                      "You're Up!",
                                      style: contentStyle,
                                      textAlign: TextAlign.center,
                                    )
                                  : Column(
                                      children: [
                                        Text(
                                          "Your position:",
                                          style: contentStyle,
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          myPlaceInLine.toString(),
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                        ),
                                      ],
                                    );
                        }),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: screenSize.height * .03),
          StreamBuilder(
              stream: firestoreLineFetcher
                  .getLineStreamFromFirestore(widget.lineId.toString()),
              builder: (context, snapshot) {
                Line line = snapshot?.data ?? Line();
                bool isLoading = line.usersInLine == null || this.userId == "";
                int minutesLeft = ((line.usersInLine
                                .where((user) => user.id == this.userId)
                                .first
                                .placeInLine -
                            line.currentPlaceInLine) *
                        3.14)
                    .floor();

                if (minutesLeft < 0) minutesLeft = 0;
                return Text(
                  'Estimated wait time: ' +
                      (isLoading ? '' : (minutesLeft.toString() + " minutes")),
                  textAlign: TextAlign.center,
                  style: contentStyle,
                );
              }),
          SizedBox(height: screenSize.height * .03),
          RequestNumber(screenSize.width, screenSize.height, textController,
              widget.lineId, this.userId),
        ]),
      ),
    );
  }
}
