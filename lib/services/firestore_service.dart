import 'dart:io';
import 'package:buffit_beta/models/Video.dart';
import 'package:buffit_beta/models/application_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Video>> getVideos() {
    return _db.collection('videos').snapshots().map((snapshot) => snapshot.docs
        .map((document) => Video.fromJson(document.data()))
        .toList());
  }

  Future<ApplicationUser> fetchUser(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .get()
        .then((snapshot) => ApplicationUser.fromFirestore(snapshot.data()));
  }
}
