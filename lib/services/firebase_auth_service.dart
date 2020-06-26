import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

@immutable
class User {
  const User({@required this.uid});
  final String uid;
}

class FirebaseAuthService {
  //create an instance of FirebaseAuth Object
  final _firebaseAuth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) {
    //check if user is null, if not return simplified instance of Firebase user (User)
    return user == null ? null : User(uid: user.uid);
  }

  Stream<User> get onAuthStateChanged {
    //Return a Stream of User 
    //Stream snapshot can later be used to determine if user is signed in
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  Future<User> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  Future<User> signInWithEmailandPassword(String email, String password) async{
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  Future<User> createUserWithEmailAndPassword(String email, String password) async{
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
