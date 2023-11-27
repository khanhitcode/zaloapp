import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zalo_app/models/user.dart' as model;
import 'package:zalo_app/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get user details
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    var currentUser2 = currentUser;
    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser2.uid).get();

    return model.User.fromSnap(documentSnapshot);
  }

  // Signing Up User

  Future<String> signUpUser({
    required String phone,
    required String password,
    required String username,
    required Uint8List file,
  }) async {
    String res = "Some error Occurred";
    try {
      if (phone.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||

          // ignore: unnecessary_null_comparison
          file != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: phone,
          password: password,
        );

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          photoUrl: photoUrl,
          phone: phone,
          followers: [],
          following: [],
        );

        // adding user in our database
        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toJson());

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // logging in user
  Future<String> loginUser({
    required String phone,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (phone.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: phone,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
