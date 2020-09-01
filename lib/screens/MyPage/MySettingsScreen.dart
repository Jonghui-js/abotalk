import 'package:abotalk/model/Post.dart';
import 'package:abotalk/services/network_handler.dart';
import 'package:flutter/material.dart';

class MySettingsScreen extends StatefulWidget {
  @override
  _MySettingsScreenState createState() => _MySettingsScreenState();
}

class _MySettingsScreenState extends State<MySettingsScreen> {
  final List<QandA> data = qandaList;
  NetworkHandler networkHandler = NetworkHandler();
  List<Post> postsList = [];
  bool circular = false;

  /* Future<Null> _loadSetting() async {
    await networkHandler.updateUser('/posts/updateuser', body);
  } */

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_loadSetting();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                const ListTile(
                  leading: Icon(Icons.info),
                  title: Text('버전1.0.0'),
                ),
                const Divider(
                  color: Colors.black,
                  height: 3,
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) => QandA(
                    questionText: data[index].questionText,
                    answerText: data[index].answerText,
                  ),
                  itemCount: data.length,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final List<QandA> qandaList = [
  QandA(
      questionText: '꼭 그대로 따라해야하나요?',
      answerText:
          '일종의 가이드라인이라고 생각하면 됩니다. 자신에게 맞는 확언문을 작성할 수 있도록 기능이 업데이트될 예정이니 잠시만 기다려주세요.'),
  QandA(
      questionText: '하루에 얼마나 주기적으로 해야하나요?',
      answerText:
          '하고 싶을 때마다, 해야겠다는 생각이 들때마다 하면 됩니다. 이것이 하나의 의무가되어 강박을 낳지 않도록 주의하세요. 그러나 확실한것은, 이미 한번 시작한 이상 우리의 잠재의식에 확실히 전달될 때까지 꾸준히 해야한다는 것입니다. 그것이 하루에 한번일지라도 말입니다. '),
  QandA(
      questionText: '어떻게 하면 더 빠르게 성취할 수 있을까요?',
      answerText:
          '더 나은 효과를 얻기 위한 최고의 방침은 없습니다. 확언을 하겠다는 작은 결심만으로도 충분합니다. 처음에는 조금 헤매도 됩니다. 더 빠르고 확실하게 결과를 얻겠다는 마음은 집착을 부르고 저항을 낳습니다. 그냥 시작하세요. 곧 스스로가 스스로에게 맞는 방향을 찾게 될 것입니다. '),
  QandA(
      questionText: '현실과 다른 말들을 내뱉는게 부끄럽고 자기합리화처럼 느껴져요',
      answerText:
          '현재 내 상황은 그렇지 않은데 반대되는 말들을 말하는게 자기합리화처럼 느껴질 수 있습니다. 누가봐도 불행한데 나는 행복하다는 말을 하라고? 하지만 현재의 상황을 부정적인 상황이라고 인지하고 있다면 우리가 바라는 긍정적인 상황 또한 어딘가에 확실하게 존재합니다. 확언하고 명상하며 잠재의식에게 그 존재를 일깨우는 것이 이 과정의 핵심입니다. 하지만 반감이 들어도 애써 이겨내려 하지는 마세요. 무언가를 하지 않으려하면 할수록 더 하게 되어 부정적인 감정이 더 심해질 수 있습니다. 대신에 관찰자의 시선으로 그 생각을 바라보세요. \'아 지금 내가 이걸 부정적으로 생각하고 있구나. 그렇구나.\'하고 넘어가세요. 계속 확언하세요. 반복되면 습관이 되고 습관은 행동이 되며 행동은 현실이 될 것입니다.'),
  QandA(
      questionText: '오류는 어떻게 신고하나요?',
      answerText: '개발자 문의하기를 클릭하시고 문의 사항을 남겨주시면 적극적으로 반영하여 업데이트할 예정입니다. '),
];

class QandA extends StatelessWidget {
  final String questionText;
  final String answerText;

  QandA({this.answerText, this.questionText});
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        questionText,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: Icon(Icons.help_center_outlined),
      children: [
        Container(
          margin: EdgeInsets.all(20),
          height: 100,
          child: SingleChildScrollView(
            child: Container(
              child: Text(
                answerText,
                style: TextStyle(fontSize: 15, letterSpacing: .8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
