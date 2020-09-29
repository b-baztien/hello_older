import 'package:flutter/material.dart';
import 'package:hello_older/model/score.dart';
import 'package:hello_older/util/custom-form-dialog.dart';
import 'package:hello_older/util/uidata.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ObjectivePage extends StatefulWidget {
  static String tag = 'objective-page';
  ObjectivePage({Key key}) : super(key: key);

  @override
  _ObjectivePageState createState() => _ObjectivePageState();
}

class _ObjectivePageState extends State<ObjectivePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _name;
  bool _isFirstTime;

  @override
  void initState() {
    super.initState();
    initialData();
  }

  initialData() async {
    String name = await UiData.getUserName();
    bool isFirstTime = await UiData.isFirstTimeExam();
    setState(() {
      _name = name;
      _isFirstTime = isFirstTime;
    });
  }

  Future<void> createAlertDialog(BuildContext context) async {
    _name = await showDialog(
      context: context,
      builder: (BuildContext context) => CustomFormDialog(
        titleIcon: Icons.person_add,
        title: "กรุณากรอกชื่อของคุณ",
        labelText: 'ชื่อของคุณ',
        buttonText: "ตกลง",
      ),
    );

    if (_name != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(UiData.nameKey, _name);
      goToPreTest();
    }
  }

  goToPreTest() {
    Score _score = new Score(
      topicScore: 'แบบทดสอบก่อนเรียน',
      score: 0,
      saveScoreFn: (int score) async {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setInt(UiData.preTestScoreKey, score);
        sharedPreferences.setBool(UiData.postTestedKey, false);
      },
    );

    Navigator.pushNamedAndRemoveUntil(
        context, UiData.examTag, ModalRoute.withName(UiData.examTag),
        arguments: _score);
  }

  Future<void> editNameDilog(BuildContext context) async {
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
                              onPressed: () => editNameDilog(context)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Image.asset(
                        'assets/images/objective.png',
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
                            'จุดประสงค์การเรียนรู้',
                            style: TextStyle(
                                color: UiData.themeColor, fontSize: 25.0),
                          ),
                          Divider(
                            height: 20.0,
                          ),
                          Expanded(
                            child: ListView(
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '\tเพื่อให้วัยกลางคน มีความพร้อมด้านจิตใจเพื่อเตรียมเข้าสู่วัยชรา โดยมีจิตวิทยาเชิงบวก มองโลกในแง่ดี มีความหวัง แม้ว่าต้องเผชิญกับปัญหาอุปสรรคหรือสถานการณ์ที่ไม่พึงประสงค์ก็สามารถปรับตัวและดำเนินชีวิตได้อย่างมีความสุข',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
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
                        _name == null || _isFirstTime ? Icons.done : Icons.home,
                        color: Colors.white,
                        size: 25,
                      ),
                      label: Text(
                        _name == null || _isFirstTime
                            ? 'เข้าใจแล้ว'
                            : 'กลับหน้าหลัก',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                      onPressed: () => {
                        if (_name == null)
                          {
                            createAlertDialog(context),
                          }
                        else if (_isFirstTime)
                          {
                            goToPreTest(),
                          }
                        else
                          {
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst),
                          }
                      },
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
