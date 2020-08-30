import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class UserTypeStatistics extends StatefulWidget {
  @override
  _UserTypeStatisticsState createState() => _UserTypeStatisticsState();
}

class _UserTypeStatisticsState extends State<UserTypeStatistics> {
  List<charts.Series<Task, String>> _seriesPieData;

  var piedata = [
    new Task('Work', 35.8, Color(0xff3366cc)),
    new Task('Eat', 8.3, Color(0xff990099)),
    new Task('Commute', 10.8, Color(0xff109618)),
    new Task('TV', 15.6, Color(0xfffdbe19)),
  ];

  @override
  void initState() {
    super.initState();
    _seriesPieData = List<charts.Series<Task, String>>();

    _seriesPieData.add(
      charts.Series(
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskvalue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        id: 'Air Pollution',
        data: piedata,
        labelAccessorFn: (Task row, _) => '${row.taskvalue}',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                LineAwesomeIcons.pie_chart,
                size: 30,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'ABO Talker 현황',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Container(
              height: 150,
              child: Center(
                child: Text('ss'),
              ))
        ],
      ),
    );
  }
}

class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}
