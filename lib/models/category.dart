class Category {
  final String uid;
  final String title;
  final String image;

  Category({this.uid, this.image, this.title});

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'image': image, 'title': title};
  }

  Category.fromFirestore(Map<String, dynamic> firestore)
      : uid = firestore['uid'],
        title = firestore['title'],
        image = firestore['image'];
}
