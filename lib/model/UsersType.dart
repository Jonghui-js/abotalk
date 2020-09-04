class UsersType {
  double a;
  double b;
  double ab;
  double o;

  UsersType({this.a, this.b, this.ab, this.o});

  factory UsersType.fromJson(Map<String, dynamic> data) {
    return UsersType(
      a: double.parse(data['a']),
      b: double.parse(data['b']),
      ab: double.parse(data['ab']),
      o: double.parse(data['o']),
    );
  }
}
