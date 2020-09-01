class Comment {
  String id;
  String username;
  String usertype;
  String text;

  Comment({this.id, this.username, this.usertype, this.text});

  factory Comment.fromJson(Map<String, dynamic> data) {
    return Comment(
        id: data['id'],
        username: data['username'],
        text: data['text'],
        usertype: data['usertype']);
  }
}
