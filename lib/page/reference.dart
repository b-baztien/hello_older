import 'package:flutter/material.dart';
import 'package:hello_older/util/uidata.dart';
import 'package:hello_older/widget/username-widget.dart';
import 'package:styled_text/styled_text.dart';

class ReferencePage extends StatefulWidget {
  static String tag = 'reference-page';
  ReferencePage({Key key}) : super(key: key);

  @override
  _ReferencePageState createState() => _ReferencePageState();
}

class _ReferencePageState extends State<ReferencePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
                  UsernameWidget(_scaffoldKey),
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
