class Album {
  final String uid;
  final String timestamp;
  final List<dynamic> images;

  Album({this.images, this.uid, this.timestamp});

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'images': images, 'timestamp': timestamp};
  }

  Album.fromFirestore(Map<String, dynamic> firestore)
      : uid = firestore['uid'],
        timestamp = firestore['timestamp'],
        images = firestore['images'];
}
