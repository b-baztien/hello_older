import 'package:flutter/material.dart';
import 'package:hello_older/model/score.dart';
import 'package:hello_older/util/custom-form-dialog.dart';
import 'package:hello_older/util/uidata.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:styled_text/styled_text.dart';

class ExamPage extends StatefulWidget {
  static String tag = 'exam-page';

  ExamPage({Key key}) : super(key: key);

  @override
  _ExamPageState createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _name;
  bool _firstTime;
  Score _score;

  @override
  void initState() {
    super.initState();
    initialData();
  }

  initialData() async {
    String name = await UiData.getUserName();
    bool isFirstTime = await UiData.isFirstTimeExam();
    setState(() {
      _firstTime = isFirstTime;
      _name = name;
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
      await initialData();

      _scaffoldKey.currentState.hideCurrentSnackBar();

      _scaffoldKey.currentState.showSnackBar(
        UiData.successSnackBar('แก้ไขชื่อสำเร็จแล้ว'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _score = ModalRoute.of(context).settings.arguments;

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
          child: Stack(
            children: [
              Column(
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
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Image.asset(
                        'assets/images/exam.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        children: [
                          Text(
                            _score.topicScore,
                            style: TextStyle(
                                color: UiData.themeColor, fontSize: 25.0),
                          ),
                          Divider(
                            height: 25.0,
                          ),
                          Expanded(
                            child: ListView(
                              children: [
                                Text(
                                  'คำชี้แจง',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.red),
                                ),
                                Divider(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  child: StyledText(
                                    text:
                                        '<bullet-stroke>\u2022</bullet-stroke> แบบทดสอบเป็นปรนัยทั้งหมด 10 ข้อ',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: UiData.fontFamily,
                                      color: Colors.black87,
                                    ),
                                    styles: UiData.styleText,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  child: StyledText(
                                    text:
                                        '<bullet-stroke>\u2022</bullet-stroke> ให้เลือกกดคำตอบที่ถูกที่สุดเพียงคำตอบเดียว',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: UiData.fontFamily,
                                      color: Colors.black87,
                                    ),
                                    styles: UiData.styleText,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  child: StyledText(
                                    text:
                                        '<bullet-stroke>\u2022</bullet-stroke> เมื่อทำคำตอบครบทุกข้อ โปรแกรมจะสรุปคะแนนให้',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: UiData.fontFamily,
                                      color: Colors.black87,
                                    ),
                                    styles: UiData.styleText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Visibility(
                          visible: _firstTime != null && !_firstTime,
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
                                'กลับสู่หน้าหลัก',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                              onPressed: () => {
                                Navigator.of(context)
                                    .popUntil((route) => route.isFirst),
                              },
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: FlatButton.icon(
                            shape: StadiumBorder(
                              side: BorderSide(
                                color: Colors.green,
                                width: 2,
                              ),
                            ),
                            color: Colors.green,
                            icon: Icon(
                              Icons.done,
                              color: Colors.white,
                              size: 25,
                            ),
                            label: Text(
                              'เริ่มการทดสอบ',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            ),
                            onPressed: () => {
                              Navigator.pushNamed(
                                context,
                                UiData.takeExamTag,
                                arguments: _score,
                              ),
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
