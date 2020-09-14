import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreAdapter {
  Future updateDocument(
      String collectionPath, String documentPath, Map<String, dynamic> data,
      {bool merge = false}) async {
    return await _getFirestoreCollectionReference(collectionPath)
        .doc(documentPath)
        .set(data, SetOptions(merge: merge));
  }

  Future<QuerySnapshot> getCollection(String collectionPath) async {
    return await _getFirestoreCollectionReference(collectionPath)
        .get();
  }

  Future<DocumentSnapshot> getDocument(
      String collectionPath, String documentPath) async {
    return await _getFirestoreCollectionReference(collectionPath)
        .doc(documentPath)
        .get();
  }

  Future<DocumentReference> addDocument(String collectionPath, Map<String, dynamic> data) async
  {
    return await _getFirestoreCollectionReference(collectionPath)
        .add(data);
  }

  Stream<QuerySnapshot> getTopItemsCollectionStream(
      String collectionPath, String value, int limit) {
    return _getFirestoreCollectionReference(collectionPath)
        .orderBy(value)
        .limit(limit)
        .snapshots();
  }

  Stream<QuerySnapshot> getCollectionStream(String collectionPath) {
    return _getFirestoreCollectionReference(collectionPath).snapshots();
  }

  Stream<DocumentSnapshot> getDocumentStream(
      String collectionPath, String documentPath) {
    return _getFirestoreCollectionReference(collectionPath)
        .doc(documentPath)
        .snapshots();
  }

  Map<String, CollectionReference> _firestoreIntanceMap = Map();

  CollectionReference _getFirestoreCollectionReference(String collectionPath) {
    if (!_firestoreIntanceMap.containsKey(collectionPath)) {
      _firestoreIntanceMap[collectionPath] =
          FirebaseFirestore.instance.collection(collectionPath);
    }

    return _firestoreIntanceMap[collectionPath];
  }
}
