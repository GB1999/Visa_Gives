import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

import 'package:visa_gives/models/nonprofit.dart';

class FirebaseDatabaseService {
  FirebaseDatabaseService({@required this.uid}) : assert(uid != null);
  //create intance of FirebaseDatabase for later REST calls
  final dataBaseRef = FirebaseDatabase.instance.reference();
  final String uid;

  // // Sets the avatar download url
  // Future<void> setAvatarReference(AvatarReference avatarReference) async {
  //   final path = FirestorePath.avatar(uid);
  //   final reference = Firestore.instance.document(path);
  //   await reference.setData(avatarReference.toMap());
  // }

  // // Reads the current avatar download url
  // Stream<AvatarReference> avatarReferenceStream() {
  //   final path = FirestorePath.avatar(uid);
  //   final reference = Firestore.instance.document(path);
  //   final snapshots = reference.snapshots();
  //   return snapshots.map((snapshot) => AvatarReference.fromMap(snapshot.data));
  // }

  Future<void> fetchNonprofits(){
    final nonprofitsData = dataBaseRef.child('Charity').once();
    print(nonprofitsData);
  }
}
