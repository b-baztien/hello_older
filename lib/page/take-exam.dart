import 'package:flutter/material.dart';
import 'package:hello_older/model/score.dart';
import 'package:hello_older/model/take-exam.dart';
import 'package:hello_older/util/custom-form-dialog.dart';
import 'package:hello_older/util/uidata.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:styled_text/styled_text.dart';

class TakeExamPage extends StatefulWidget {
  static String tag = 'take-exam-page';

  TakeExamPage({Key key}) : super(key: key);

  @override
  _TakeExamPageState createState() => _TakeExamPageState();
}

class _TakeExamPageState extends State<TakeExamPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _name;
  int _choiceNo;
  TakeExam takeExam;
  List<String> _listAnswer;
  Score _score;

  @override
  void initState() {
    _name = '';
    _choiceNo = 1;
    takeExam = new TakeExam(isRandomChoice: false);
    _listAnswer = new List.generate(10, (index) => '');
    initialUserName();
    super.initState();
  }

  initialUserName() async {
    String name = await UiData.getUserName();
    setState(() {
      _name = name;
    });
  }

  initialScoreName() async {
    _score = ModalRoute.of(context).settings.arguments;
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

  @override
  Widget build(BuildContext context) {
    initialScoreName();

    return Scaffold(
      key: _scaffoldKey,
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
                          onPressed: () => createAlertDialog(context)),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Text(
                  'ข้อที่ $_choiceNo',
                  style: TextStyle(color: UiData.themeColor, fontSize: 30.0),
                ),
              ),
              Flexible(
                flex: 10,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    children: [
                      StyledText(
                        text: takeExam.listQuestion[_choiceNo - 1].question,
                        style: TextStyle(
                            fontFamily: UiData.fontFamily,
                            color: Colors.black87,
                            fontWeight: FontWeight.w100,
                            fontSize: 18.0),
                        styles: UiData.styleText,
                      ),
                      Divider(
                        height: 25.0,
                      ),
                      SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                              takeExam.listQuestion[_choiceNo - 1].listChoice
                                  .map(
                                    (data) => RadioListTile(
                                        title: Text(data),
                                        value: data,
                                        groupValue: _listAnswer[_choiceNo - 1],
                                        onChanged: (value) {
                                          setState(() {
                                            _listAnswer[_choiceNo - 1] = value;
                                          });
                                        }),
                                  )
                                  .toList(),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        flex: 15,
                        child: FlatButton(
                          padding: EdgeInsets.all(12),
                          shape: StadiumBorder(
                            side: BorderSide(
                              color: _choiceNo != 1
                                  ? Color(0xffC70039)
                                  : Colors.grey,
                              width: 2,
                            ),
                          ),
                          disabledColor: Colors.grey,
                          disabledTextColor: Colors.blueGrey,
                          textColor: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(
                                Icons.chevron_left,
                              ),
                              Text(
                                'ข้อก่อนหน้า',
                              ),
                            ],
                          ),
                          color: Color(0xffC70039),
                          onPressed: _choiceNo != 1
                              ? () {
                                  setState(() {
                                    _choiceNo--;
                                  });
                                }
                              : null,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          width: 1,
                        ),
                      ),
                      Expanded(
                        flex: 15,
                        child: FlatButton(
                          padding: EdgeInsets.all(12),
                          shape: StadiumBorder(
                            side: BorderSide(
                              color: Color(0xff27AE60),
                              width: 2,
                            ),
                          ),
                          disabledColor: Colors.grey,
                          disabledTextColor: Colors.blueGrey,
                          textColor: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                _choiceNo != takeExam.listQuestion.length
                                    ? 'ข้อถัดไป'
                                    : 'ส่งคำตอบ',
                              ),
                              Icon(
                                _choiceNo != takeExam.listQuestion.length
                                    ? Icons.chevron_right
                                    : Icons.done,
                              ),
                            ],
                          ),
                          color: Color(0xff27AE60),
                          onPressed: _choiceNo != takeExam.listQuestion.length
                              ? () {
                                  setState(() {
                                    _choiceNo++;
                                  });
                                }
                              : () async {
                                  bool isAnsAll = true;
                                  _listAnswer.forEach(
                                    (element) {
                                      if (element.isEmpty) {
                                        isAnsAll = false;
                                        return;
                                      }
                                    },
                                  );

                                  if (isAnsAll) {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setBool(UiData.firstTimeKey, false);

                                    _score.score =
                                        takeExam.calculateScore(_listAnswer);

                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      UiData.resultExamTag,
                                      ModalRoute.withName(UiData.resultExamTag),
                                      arguments: _score,
                                    );
                                  } else {
                                    _scaffoldKey.currentState
                                        .hideCurrentSnackBar();
                                    _scaffoldKey.currentState.showSnackBar(
                                      UiData.dangerSnackBar(
                                          'กรุณาทำบททดสอบให้ครบทุกข้อ'),
                                    );
                                  }
                                },
                        ),
                      ),
                    ],
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
