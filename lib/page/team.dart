import 'package:flutter/material.dart';
import 'package:hello_older/util/custom-form-dialog.dart';
import 'package:hello_older/util/uidata.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:styled_text/styled_text.dart';

class TeamPage extends StatefulWidget {
  static String tag = 'team-page';
  TeamPage({Key key}) : super(key: key);

  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _name;
  @override
  void initState() {
    super.initState();
    initialUserName();
  }

  initialUserName() async {
    String name = await UiData.getUserName();
    setState(() {
      _name = name;
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

      Navigator.pushNamedAndRemoveUntil(
          context, UiData.examTag, ModalRoute.withName(UiData.examTag),
          arguments: 'แบบทดสอบก่อนเรียน');
    }
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
      await initialUserName();

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
                        'assets/images/team.png',
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
                            'ผู้จัดทำ',
                            style: TextStyle(
                                color: UiData.themeColor, fontSize: 25.0),
                          ),
                          Divider(
                            height: 20.0,
                          ),
                          Expanded(
                            child: ListView(
                              padding: EdgeInsets.only(bottom: 10.0),
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    StyledText(
                                      newLineAsBreaks: true,
                                      text: 'ผู้ช่วยศาสตราจารย์ ดร. อัมเรศ เนตาสิทธิ์ และคณะ\n\n' +
                                          'เป็นส่วนหนึ่งในงานวิจัยเรื่อง “การส่งเสริมจิตวิทยาเชิงบวกสำหรับวัยกลางคน เพื่อเตรียมความพร้อมเข้าสู่วัยชรายุค 4.0”\n\n' +
                                          'งานวิจัยนี้ได้รับทุนอุดหนุนจากงบรายได้ ปีงบประมาณ 2563 คณะครุศาสตร์ มหาวิทยาลัยราชภัฏลำปาง',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black87,
                                        fontFamily: UiData.fontFamily,
                                      ),
                                      styles: UiData.styleText,
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
                        _name == null ? Icons.done : Icons.home,
                        color: Colors.white,
                        size: 25,
                      ),
                      label: Text(
                        _name == null ? 'เข้าใจแล้ว' : 'กลับหน้าหลัก',
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
