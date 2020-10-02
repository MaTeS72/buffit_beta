import 'package:buffit_beta/models/Video.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Video>> getVideos() {
    return _db.collection('videos').snapshots().map((snapshot) => snapshot.docs
        .map((document) => Video.fromJson(document.data()))
        .toList());
  }
}
