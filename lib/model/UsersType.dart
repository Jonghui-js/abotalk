class UsersType {
  dynamic a;
  dynamic b;
  dynamic ab;
  dynamic o;

  UsersType({this.a, this.b, this.ab, this.o});

  factory UsersType.fromJson(Map<String, dynamic> parsedJson) {
    return UsersType(
      a: parsedJson['a'],
      b: parsedJson['b'],
      ab: parsedJson['ab'],
      o: parsedJson['o'],
    );
  }
}
