class Post {
  String id;
  String username;
  String title;
  String content;
  String usertype;

  Post({this.id, this.username, this.title, this.content, this.usertype});

  factory Post.fromJson(Map<String, dynamic> data) {
    return Post(
        id: data['id'],
        username: data['username'],
        title: data['title'],
        content: data['content'],
        usertype: data['usertype']);
  }
}
