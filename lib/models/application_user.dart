class ApplicationUser {
  final String uid;
  final String email;
  final String name;
  final String lastName;
  final String profession;
  final String photoURL;
  final String displayName;

  ApplicationUser({
    this.name,
    this.lastName,
    this.profession,
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
      'name': name,
      'lastName': lastName,
      'displayname': displayName,
    };
  }

  ApplicationUser.fromFirestore(Map<String, dynamic> firestore)
      : uid = firestore['uid'],
        email = firestore['email'],
        name = firestore['name'],
        lastName = firestore['lastName'],
        profession = firestore['profession'],
        photoURL = firestore['photoURL'],
        displayName = firestore['displayName'];

// 'uid': uid,
//         'email': user.email,
//         'photoURL': user.photoURL,
//         'displayName': user.displayName,
//         'lastSeen':
}
