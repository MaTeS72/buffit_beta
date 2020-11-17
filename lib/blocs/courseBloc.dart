import 'package:buffit_beta/models/category.dart';
import 'package:buffit_beta/models/course.dart';
import 'package:buffit_beta/services/firestore_service.dart';
import 'package:buffit_beta/services/instagram_posts_service.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class CourseBloc {
  final db = FirestoreService();
  final postService = InstagramService();

  final _igStream = BehaviorSubject<List<String>>();

  dispose() {
    _igStream.close();
  }

  Stream<List<String>> get igStream => _igStream.stream;

  Stream<List<Course>> getCourseList() => db.fetchCourses();
  Future<Course> fetchCourse(String courseId) => db.fetchCourse(courseId);

  Stream<List<Category>> fetchCategory(courseId) =>
      db.fetchCategories(courseId);

  fetchIgPosts() {
    postService.getAlbums().then((val) async {
      print(val);
      List<String> pole = List<String>();
      for (var item in val) {
        await http
            .get(
                'https://graph.instagram.com/$item?fields=media_url&access_token=IGQVJWZAW1OU01LSkNNeG5DeWpuT0lHZAmViaDF5NkVBSl8weGZAPSkVWcGNKcHdTVURHSnNBTTdlSmpJWjUwT3pVdnF6VlZAXRUdaRlh4a2NndjNDWnc4NEJJMDhxVzhaYUNrZAWtzb0FfYXl1cHVwVFF3OAZDZD')
            .then((value) {
          var jsonResponse = convert.jsonDecode(value.body);
          pole.add(jsonResponse['media_url']);
        }).then((value) => _igStream.sink.add(pole));
      }
    });
  }
}
