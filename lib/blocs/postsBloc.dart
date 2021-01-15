import 'package:buffit_beta/models/album.dart';
import 'package:buffit_beta/services/firestore_service.dart';
import 'package:buffit_beta/services/instagram_posts_service.dart';
import 'package:rxdart/rxdart.dart';

class PostsBloc {
  final firestoreService = FirestoreService();

  Stream<List<Album>> postStream() => firestoreService.fetchPosts();
  Future<Album> fetchpost(postId) => firestoreService.fetchPost(postId);
  Stream<List<Album>> fetchNewPosts() => firestoreService.fetchNewPosts();

  dispose() {}
}
