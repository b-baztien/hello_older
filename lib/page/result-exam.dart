import 'package:flutter/material.dart';
import 'package:hello_older/model/score.dart';
import 'package:hello_older/util/custom-form-dialog.dart';
import 'package:hello_older/util/uidata.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    initialUserName();
    initialIsFirstTimeExam();
    initialIsPostTested();
  }

  initialUserName() async {
    String name = await UiData.getUserName();
    setState(() {
      _name = name;
    });
  }

  initialIsFirstTimeExam() async {
    bool isFirstTime = await UiData.isFirstTimeExam();
    setState(() {
      _firstTime = isFirstTime;
    });
  }

  initialIsPostTested() async {
    bool isPostTested = await UiData.isPostTested();
    setState(() {
      _isPostTested = isPostTested;
    });
  }

  initialScore() async {
    _score = ModalRoute.of(context).settings.arguments;

    int pretestScore = await UiData.getPretestScore();
    setState(() {
      _pretestScore = pretestScore;
    });
  }

  Future<void> createAlertDialog(BuildContext context) async {
    String newName;
    newName = await showDialog(
      context: context,
      builder: (BuildContext context) => CustomFormDialog(
        titleIcon: Icons.face,
        title: "แก้ไขชื่อของคุณ",
        labelText: 'ชื่อของคุณ',
        buttonText: "ตกลง",
        initInput: _name,
      ),
    );

    if (newName != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(UiData.nameKey, newName);
      await initialUserName();

      _scaffoldKey.currentState.hideCurrentSnackBar();

      _scaffoldKey.currentState.showSnackBar(
        UiData.successSnackBar('แก้ไขชื่อสำเร็จแล้ว'),
      );
    }
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
              Visibility(
                visible: _name != null && _name.isNotEmpty,
                child: Align(
                  heightFactor: 1.0,
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'สวัสดี คุณ$_name',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black87,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        color: Colors.black87,
                        splashRadius: 20.0,
                        onPressed: () => createAlertDialog(context),
                      ),
                    ],
                  ),
                ),
              ),
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
