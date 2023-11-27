import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String phone;
  final String uid;
  final String photoUrl;
  final String username;

  final List followers;
  final List following;

  const User(
      {required this.username,
      required this.uid,
      required this.photoUrl,
      required this.phone,
      required this.followers,
      required this.following});

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot["username"],
      uid: snapshot["uid"],
      phone: snapshot["phone"],
      photoUrl: snapshot["photoUrl"],
      followers: snapshot["followers"],
      following: snapshot["following"],
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "phone": phone,
        "photoUrl": photoUrl,
        "followers": followers,
        "following": following,
      };
}
