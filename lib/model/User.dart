class User {
  String id;
  String username;
  String blood;
  String email;

  User({this.id, this.username, this.blood, this.email});

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
      id: data['id'],
      username: data['username'],
      blood: data['blood'],
      email: data['email'],
    );
  }
}
