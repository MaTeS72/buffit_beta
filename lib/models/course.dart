class Course {
  final String uid;
  final String title;
  final String subtitle;
  final int difficulty;
  final int progress;
  final String added;

  Course(
      {this.uid,
      this.added,
      this.difficulty,
      this.progress,
      this.subtitle,
      this.title});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'added': added,
      'difficulty': difficulty,
      'progress': progress,
      'subtitle': subtitle,
      'title': title
    };
  }

  Course.fromFirestore(Map<String, dynamic> firestore)
      : uid = firestore['uid'],
        added = firestore['added'],
        difficulty = firestore['difficulty'],
        progress = firestore['progress'],
        title = firestore['title'],
        subtitle = firestore['subtitle'];
}
