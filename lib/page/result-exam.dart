import 'package:flutter/material.dart';
import 'package:hello_older/model/score.dart';
import 'package:hello_older/util/preference-setting.dart';
import 'package:hello_older/util/uidata.dart';
import 'package:hello_older/widget/username-widget.dart';
import 'package:styled_text/styled_text.dart';

class ResultExamPage extends StatefulWidget {
  static String tag = 'result-exam-page';
  ResultExamPage({Key key}) : super(key: key);

  @override
  _ResultExamPageState createState() => _ResultExamPageState();
}

class _ResultExamPageState extends State<ResultExamPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _name = '';
  Score _score;
  int _pretestScore;
  bool _isPostTested;
  bool _firstTime;

  @override
  void initState() {
    super.initState();
    initialIsFirstTimeExam();
    initialIsPostTested();
  }

  initialIsFirstTimeExam() {
    bool isFirstTime = PreferenceSettings.getFirstTime();
    setState(() {
      _firstTime = isFirstTime;
    });
  }

  initialIsPostTested() {
    bool isPostTested = PreferenceSettings.getPostTested();
    setState(() {
      _isPostTested = isPostTested;
    });
  }

  initialScore() {
    _score = ModalRoute.of(context).settings.arguments;

    int pretestScore = PreferenceSettings.getPretestScore();
    setState(() {
      _pretestScore = pretestScore;
    });
  }

  onSaveScoreFn() {
    if (_score.topicScore == 'แบบทดสอบก่อนเรียน') {
      _score.saveScoreFn(_score.score);
    } else {
      _score.saveScoreFn();
    }
  }

  @override
  Widget build(BuildContext context) {
    initialScore();

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UsernameWidget(_scaffoldKey),
              Flexible(
                flex: 2,
                child: Container(
                  child: Image.asset(
                    'assets/images/result-exam.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Flexible(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    children: [
                      Text(
                        'ผลสรุป',
                        style:
                            TextStyle(color: UiData.themeColor, fontSize: 30.0),
                      ),
                      Divider(
                        height: 20.0,
                      ),
                      Text(
                        'คุณ$_name',
                        style: TextStyle(fontSize: 25.0),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'ทำแบบทดสอบได้ ${_score.score} คะแนน',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Visibility(
                        visible: _firstTime != null &&
                            !_firstTime &&
                            _isPostTested != null &&
                            !_isPostTested,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.0,
                            ),
                            StyledText(
                              text:
                                  'สรุปคะแนน<underline>ก่อนเรียน</underline> คุณทำได้ $_pretestScore คะแนน',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black87,
                                fontFamily: UiData.fontFamily,
                              ),
                              styles: UiData.styleText,
                            ),
                            StyledText(
                              text:
                                  'สรุปคะแนน<underline>หลังเรียน</underline> คุณทำได้ ${_score.score} คะแนน',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black87,
                                fontFamily: UiData.fontFamily,
                              ),
                              styles: UiData.styleText,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            _pretestScore != null
                                ? StyledText(
                                    text: _score.score == _pretestScore
                                        ? 'คะแนนของคุณ<underline><blue>ไม่เปลี่ยนแปลง</blue></underline>จากก่อนเรียน'
                                        : _score.score > _pretestScore
                                            ? 'คะแนนของคุณ<underline><green>เพิ่มขึ้น</green></underline>จากก่อนเรียน <green>${_score.score - _pretestScore}</green> คะแนน'
                                            : 'คะแนนของคุณ<underline><red>ลดลง</red></underline>จากก่อนเรียน <red>${_pretestScore - _score.score}</red> คะแนน',
                                    textAlign: TextAlign.center,
                                    newLineAsBreaks: true,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black87,
                                      fontFamily: UiData.fontFamily,
                                    ),
                                    styles: UiData.styleText,
                                  )
                                : SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  child: FlatButton.icon(
                    shape: StadiumBorder(
                      side: BorderSide(
                        color: UiData.themeColor,
                        width: 2,
                      ),
                    ),
                    color: UiData.themeColor,
                    icon: Icon(
                      Icons.home,
                      color: Colors.white,
                      size: 25,
                    ),
                    label: Text(
                      'กลับหน้าหลัก',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                    onPressed: () => {
                      onSaveScoreFn(),
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        UiData.homeTag,
                        ModalRoute.withName(UiData.homeTag),
                      ),
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
