import 'package:buffit_beta/models/album.dart';
import 'package:buffit_beta/models/application_user.dart';
import 'package:buffit_beta/models/category.dart';
import 'package:buffit_beta/models/course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Course>> fetchCourses() {
    return _db
        .collection('Courses')
        .orderBy("difficulty")
        .snapshots()
        .map((query) => query.docs)
        .map((snapshot) =>
            snapshot.map((doc) => Course.fromFirestore(doc.data())).toList());
  }

  Stream<List<Category>> fetchCategories(courseId) {
    var categories = _db
        .collection('Courses')
        .doc(courseId)
        .collection('Category')
        .snapshots()
        .map((query) => query.docs)
        .map((snapshot) =>
            snapshot.map((doc) => Category.fromFirestore(doc.data())).toList());

    return categories;
  }

  Future<Course> fetchCourse(courseId) {
    return _db
        .collection('Courses')
        .doc(courseId)
        .get()
        .then((snapshot) => Course.fromFirestore(snapshot.data()));
  }

  Future<Album> fetchPost(postId) {
    return _db
        .collection('IG_Posts')
        .doc(postId)
        .get()
        .then((snapshot) => Album.fromFirestore(snapshot.data()));
  }

  Future<ApplicationUser> fetchUser(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .get()
        .then((snapshot) => ApplicationUser.fromFirestore(snapshot.data()));
  }

  Stream<List<Album>> fetchPosts() {
    return _db
        .collection('IG_Posts')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((val) => val.docs)
        .map((snapshot) =>
            snapshot.map((doc) => Album.fromFirestore(doc.data())).toList());
  }

  Stream<List<Album>> fetchNewPosts() {
    return _db
        .collection('IG_Posts')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((val) => val.docs)
        .map((snapshot) => snapshot
            .map((doc) => Album.fromFirestore(doc.data()))
            .take(4)
            .toList());
  }
}
