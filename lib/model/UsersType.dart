class UsersType {
  dynamic a;
  dynamic b;
  dynamic ab;
  dynamic o;

  UsersType({this.a, this.b, this.ab, this.o});

  factory UsersType.fromJson(Map<String, dynamic> data) {
    return UsersType(
      a: data['a'],
      b: data['b'],
      ab: data['ab'],
      o: data['o'],
    );
  }
}
