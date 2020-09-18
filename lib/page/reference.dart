import 'package:flutter/material.dart';
import 'package:hello_older/util/custom-form-dialog.dart';
import 'package:hello_older/util/uidata.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:styled_text/styled_text.dart';

class ReferencePage extends StatefulWidget {
  static String tag = 'reference-page';
  ReferencePage({Key key}) : super(key: key);

  @override
  _ReferencePageState createState() => _ReferencePageState();
}

class _ReferencePageState extends State<ReferencePage> {
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
                        'assets/images/reference.png',
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
                            'รายการอ้างอิง',
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
                                      text: '<bullet-stroke>\u2022</bullet-stroke>\t' +
                                          'สำนักงานกองทุนสนับสนุนการสร้างเสริมสุขภาพ ศูนย์เรียนรู้สุขภาวะ. (2560). ' +
                                          '<bold>นิทรรศการเตรียมความพร้อม สู่สังคมผู้สูงอายุที่มีความ sook.</bold> ' +
                                          'สืบค้น 10 กรกฎาคม 2563, จาก ' +
                                          '<link href="http://thaihealthcenter.org/exhibitions/happily-activeaging/elder">http://thaihealthcenter.org/exhibitions/happily-activeaging/elder</link>',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black87,
                                        fontFamily: UiData.fontFamily,
                                      ),
                                      styles: UiData.styleText,
                                    ),
                                    StyledText(
                                      newLineAsBreaks: true,
                                      text: '<bullet-stroke>\u2022</bullet-stroke>\t' +
                                          'สำนักส่งเสริมสวัสดิภาพและพิทักษ์เด็กและเยาวชน ผู้ด้อยโอกาส และผู้สูงอายุ. (ม.ป.ป.). ' +
                                          '<bold>เตรียมความพร้อมไม่ต้องเดี๋ยว เผลอแป๊บเดียวก็สูงวัย.</bold> ' +
                                          'ม.ป.ท.',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black87,
                                        fontFamily: UiData.fontFamily,
                                      ),
                                      styles: UiData.styleText,
                                    ),
                                    StyledText(
                                      newLineAsBreaks: true,
                                      text: '<bullet-stroke>\u2022</bullet-stroke>\t' +
                                          'สำนักส่งเสริมสวัสดิภาพและพิทักษ์เด็กและเยาวชน ผู้ด้อยโอกาส และผู้สูงอายุ. ' +
                                          '<bold>การเตรียมความพร้อมเข้าสู่วัยสูงอายุ (แบบย่อ 3 นาที).</bold> ' +
                                          'สืบค้น 10 สิงหาคม 2563, ' +
                                          '<link href="https://www.youtube.com/watch?v=YevwyR0wRoo">https://www.youtube.com/watch?v=YevwyR0wRoo</link>',
                                      style: TextStyle(
                                        fontSize: 16.0,
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
