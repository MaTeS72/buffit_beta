class ApplicationUser {
  final String uid;
  final String email;
  final String photoURL;
  final String displayName;

  ApplicationUser({
    this.uid,
    this.email,
    this.photoURL,
    this.displayName,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'photoURL': photoURL,
      'displayname': displayName,
    };
  }

  ApplicationUser.fromFirestore(Map<String, dynamic> firestore)
      : uid = firestore['uid'],
        email = firestore['email'],
        photoURL = firestore['photoURL'],
        displayName = firestore['displayName'];

// 'uid': uid,
//         'email': user.email,
//         'photoURL': user.photoURL,
//         'displayName': user.displayName,
//         'lastSeen':
}
