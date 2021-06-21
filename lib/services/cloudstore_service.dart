import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_order_up/models/user.dart';

class UserDatabase {
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  Future<void> addUser(User user) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return users
        .add({
          'full_name': user.fullName,
          'provider': user.provider,
          'email': user.email,
          'uid': user.uid,
          'photoUrl': user.photoUrl
        })
        .then((value) => print("User Added - $value"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<User> getUser(String uid) async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .limit(1)
        .get();

    var user = User();

    querySnapshot.docs.forEach((value) {
      user.email = value['email'];
      user.fullName = value['full_name'];
      user.provider = value['provider'];
      user.uid = value['uid'];
      user.photoUrl = value['photoUrl'];
    });

    return user;
  }
}
