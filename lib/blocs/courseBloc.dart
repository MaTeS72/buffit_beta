import 'package:buffit_beta/models/course.dart';
import 'package:buffit_beta/services/firestore_service.dart';
import 'package:rxdart/rxdart.dart';

class CourseBloc {
  final db = FirestoreService();

  Stream<List<Course>> getCourseList() => db.fetchCourses();
}
