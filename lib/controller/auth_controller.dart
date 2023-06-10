import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/user_model.dart';

class AuthController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  bool get success => false;

  Future<UserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential = await auth
          .signInWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;
      if (user != null) {
        final DocumentSnapshot snapshot =
            await usersCollection.doc(user.uid).get();

        final UserModel currentUser = UserModel(
            name: snapshot['name'], email: user.email ?? '', uId: user.uid);
        return currentUser;
      }
    } catch (e) {
      print('error signing in : $e');
    }

    return null;
  }

  Future<UserModel?> registerWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      //bakal masuk ke auth di web
      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;

      if (user != null) {
        //newuser dari
        final UserModel newUser =
            //dapet dari auth web, name dari textfrom
            UserModel(name: name, email: user.email ?? '', uId: user.uid);

        //crete a document in the users collection with the user's UID as the document ID
        await usersCollection.doc(newUser.uId).set(newUser.toMap());

        return newUser;
      }
    } catch (e) {}
  }

  UserModel? getCurrentUser() {
    final User? user = auth.currentUser;
    if (user != null) {
      return UserModel.fromFirebaseUser(user);
    }
    return null;
  }

//buat sign out aja
  Future<void> signOut() async {
    await auth.signOut();
  }
}
