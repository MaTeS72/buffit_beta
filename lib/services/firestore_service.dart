import 'package:buffit_beta/models/application_user.dart';
import 'package:buffit_beta/models/course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Course>> fetchCourses() {
    return _db.collection('courses').snapshots().map((query) => query.docs).map(
        (snapshot) =>
            snapshot.map((doc) => Course.fromFirestore(doc.data())).toList());
  }

  Future<ApplicationUser> fetchUser(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .get()
        .then((snapshot) => ApplicationUser.fromFirestore(snapshot.data()));
  }
}
