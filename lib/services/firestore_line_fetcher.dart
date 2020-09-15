import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noLine/services/firestore_adapter.dart';
import 'package:noLine/models/line.dart';
import 'package:noLine/models/user.dart';

class FirestoreLineFetcher {
  FirestoreAdapter firestoreAdapter = FirestoreAdapter();

  Stream<Line> getLineStreamFromFirestore(String lineId) {
    return firestoreAdapter.getCollectionStream(lineId).map((snapshot) {
      Line line = Line();
      line.usersInLine = [];
      line.lineId = lineId;

      for (DocumentSnapshot document in snapshot?.docs ?? []) {
        if (document.id == "line_data") {
          line.currentPlaceInLine = document.data()["currentPlaceInLine"];
          line.lastPlaceInLine = document.data()["lastPlaceInLine"];
          continue;
        }

        User user = User();
        user.id = document.id;
        user.placeInLine = document.data()["placeInLine"];

        line.usersInLine.add(user);
      }

      return line;
    });
  }
}
