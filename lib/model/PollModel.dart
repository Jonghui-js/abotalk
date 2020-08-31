import 'dart:convert';

List<PollModel> modelPollFromJson(String str) => List<PollModel>.from(
    json.decode(str).map((model) => PollModel.fromJson(model)));

class PollModel {
  String id;
  String user;
  String answer1;
  String answer2;
  String userPick;

  PollModel({this.answer1, this.answer2, this.id, this.userPick});

  factory PollModel.fromJson(Map<dynamic, dynamic> data) {
    return PollModel(
        answer1: data['answer1'],
        answer2: data['answer2'],
        id: data['_id'],
        userPick: data['userPick']);
  }
}
