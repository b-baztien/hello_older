import 'package:flutter/material.dart';
import 'package:hello_older/util/uidata.dart';
import 'package:hello_older/widget/username-widget.dart';
import 'package:styled_text/styled_text.dart';

class TeamPage extends StatefulWidget {
  static String tag = 'team-page';
  TeamPage({Key key}) : super(key: key);

  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  @override
  void initState() {
    super.initState();
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
                  UsernameWidget(),
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
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst),
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
