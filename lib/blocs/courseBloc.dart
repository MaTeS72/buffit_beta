import 'package:buffit_beta/models/album.dart';
import 'package:buffit_beta/models/category.dart';
import 'package:buffit_beta/models/course.dart';
import 'package:buffit_beta/services/firestore_service.dart';
import 'package:buffit_beta/services/instagram_posts_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class CourseBloc {
  final db = FirestoreService();
  final postService = InstagramService();
  FirebaseFirestore _db = FirebaseFirestore.instance;

  final _igStream = BehaviorSubject<List<Album>>();
  
  dispose() {
    _igStream.close();
  }

  Stream<List<Album>> get igStream => _igStream.stream;

  Stream<List<Course>> getCourseList() => db.fetchCourses();
  Future<Course> fetchCourse(String courseId) => db.fetchCourse(courseId);

  Stream<List<Category>> fetchCategory(courseId) =>
      db.fetchCategories(courseId);

   fetchIgPosts() {
    postService.getAlbums().then((val) async {
      print(val);

      List<Album> albums = new List<Album>();
      for (var item in val) {
        List<dynamic> pole = new List<dynamic>();
        String timestamp;
        for (var img_id in item.images) {
          await http
              .get(
                  'https://graph.instagram.com/$img_id?fields=media_url,timestamp&access_token=IGQVJVb1ktQzN3c04xa0w1bEtqc2Jydy1xcFFZAenJHTHlYbUFiSWZASVUY4ZAmJEeGZAZAMk82LTFXalBFUGJrOFg0RTdBS1VyUkNMbmZA3S1J6NVh5WXJid0NwWFY3NUZAjYTNiTDRROUdxeUtwVWpJRE90aQZDZD')
              .then((value) {
            var jsonResponse = convert.jsonDecode(value.body);
            timestamp = jsonResponse['timestamp'];
            pole.add(jsonResponse['media_url']);
          });
        }
        var uuid = Uuid().v4();
        Album album = new Album(images: pole, timestamp: timestamp, uid: uuid);

        albums.add(album);

        _db
            .collection('IG_Posts')
            .doc(uuid)
            .set(album.toMap())
            .catchError((e) => print(e));
      }
      print(albums);

      _igStream.sink.add(albums);
    });
  }

}
