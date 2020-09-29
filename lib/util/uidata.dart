import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:hello_older/model/content-data.dart';
import 'package:hello_older/page/content.dart';
import 'package:hello_older/page/exam.dart';
import 'package:hello_older/page/home.dart';
import 'package:hello_older/page/objective.dart';
import 'package:hello_older/page/reference.dart';
import 'package:hello_older/page/result-exam.dart';
import 'package:hello_older/page/splash.dart';
import 'package:hello_older/page/take-exam.dart';
import 'package:hello_older/page/team.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:styled_text/styled_text.dart';
import 'package:url_launcher/url_launcher.dart';

class UiData {
  static String objectiveTag = ObjectivePage.tag;
  static String examTag = ExamPage.tag;
  static String takeExamTag = TakeExamPage.tag;
  static String resultExamTag = ResultExamPage.tag;
  static String homeTag = HomePage.tag;
  static String contentTag = ContentPage.tag;
  static String referenceTag = ReferencePage.tag;
  static String teamTag = TeamPage.tag;

  static Map<String, WidgetBuilder> routes = {
    SplashPage.tag: (context) => SplashPage(),
    ObjectivePage.tag: (context) => ObjectivePage(),
    ExamPage.tag: (context) => ExamPage(),
    TakeExamPage.tag: (context) => TakeExamPage(),
    ResultExamPage.tag: (context) => ResultExamPage(),
    HomePage.tag: (context) => HomePage(),
    ContentPage.tag: (context) => ContentPage(),
    ReferencePage.tag: (context) => ReferencePage(),
    TeamPage.tag: (context) => TeamPage(),
  };

  static String fontFamily = 'Kanit';
  static MaterialColor themeMaterialColor = Colors.blue;
  static Color themeColor = Colors.blue[400];

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;

  static Map<String, TextStyle> styleText = {
    'bold-title': TextStyle(fontWeight: FontWeight.w600, color: themeColor),
    'bold': TextStyle(fontWeight: FontWeight.w600),
    'bullet-stroke': TextStyle(
      color: Colors.green[600],
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
    ),
    'link': ActionTextStyle(
      color: themeMaterialColor,
      decoration: TextDecoration.underline,
      onTap: (TextSpan text, Map<String, String> attrs) async {
        await launch(attrs['href']);
      },
    ),
    'bold-underline': TextStyle(
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.underline,
    ),
    'underline': TextStyle(
      decoration: TextDecoration.underline,
    ),
    'bullet': IconStyle(
      Icons.chevron_right,
    ),
    'green': TextStyle(color: Colors.green),
    'red': TextStyle(color: Colors.red),
    'blue': TextStyle(color: Colors.blue),
  };

  static String nameKey = 'name';
  static String firstTimeKey = 'first_time';
  static String preTestScoreKey = 'pre-test_score';
  static String postTestedKey = 'post-tested';
  static String readContentIdKey = 'read_content_id';

  static Future<String> getUserName() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getString(nameKey);
  }

  static Future<bool> isFirstTimeExam() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    bool isFirstTimeExam = sharedPrefs.getBool(firstTimeKey);
    return isFirstTimeExam != null ? isFirstTimeExam : true;
  }

  static Future<int> getPretestScore() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getInt(preTestScoreKey);
  }

  static Future<bool> isPostTested() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    bool isPostTest = sharedPrefs.getBool(postTestedKey);
    return isPostTest;
  }

  static Future<Set<String>> getReadContent() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    List<String> _listTemp = sharedPrefs.getStringList(readContentIdKey);
    return _listTemp == null ? new Set() : _listTemp.toSet();
  }

  static SnackBar successSnackBar(
    String message, {
    Duration duration,
  }) {
    if (duration == null) duration = Duration(seconds: 5);
    return SnackBar(
      duration: duration,
      backgroundColor: Colors.green,
      content: Wrap(
        direction: Axis.horizontal,
        children: <Widget>[
          Icon(Icons.check_circle_outline),
          SizedBox(
            width: 8,
          ),
          Text(
            '$message',
            style: TextStyle(fontSize: 18, fontFamily: UiData.fontFamily),
          ),
        ],
      ),
    );
  }

  static dangerSnackBar(
    String message, {
    Duration duration,
  }) {
    if (duration == null) duration = Duration(seconds: 5);
    return SnackBar(
      duration: duration,
      backgroundColor: Colors.red,
      content: Wrap(
        direction: Axis.horizontal,
        children: <Widget>[
          Icon(Icons.highlight_off),
          SizedBox(
            width: 8,
          ),
          Text(
            '$message',
            style: TextStyle(fontSize: 15, fontFamily: UiData.fontFamily),
          ),
        ],
      ),
    );
  }

  static infoSnackBar(
    String message, {
    Duration duration,
  }) {
    if (duration == null) duration = Duration(seconds: 5);
    return SnackBar(
      duration: duration,
      backgroundColor: Colors.blue,
      content: Wrap(
        direction: Axis.horizontal,
        children: <Widget>[
          Icon(Icons.error_outline),
          SizedBox(
            width: 8,
          ),
          Text(
            '$message',
            style: TextStyle(fontSize: 15, fontFamily: UiData.fontFamily),
          ),
        ],
      ),
    );
  }

  static List<ContentData> listContent = [
    new ContentData(
      id: '1',
      icon: Icons.assignment,
      topic: 'เตรียมความพร้อมเข้าสู่วัยชราด้วยการมีจิตวิทยาเชิงบวก',
      description: 'การจะเข้าสู่วัยชราด้วยความสุข ควรเริ่มต้นด้วยการปรับตัวให้มีจิตวิทยาเชิงบวก ดังนี้\n' +
          '\t<bullet-stroke>\u2022</bullet-stroke><bold-title>\tควรรับรู้ความสามารถของตนเอง</bold-title> วัยกลางคนควรเชื่อมั่นว่าตนเองมีความสามารถ มีการทำงานที่ท้าทาย มีแรงจูงใจที่มีความเชื่อว่างานใดๆ ไม่ยากเกินความสามารถของตน และสามารถทำให้บรรลุผลสำเร็จได้อย่างมีประสิทธิภาพ\n' +
          '\t<bullet-stroke>\u2022</bullet-stroke><bold-title>\tควรมีความหวัง</bold-title> มีความคิดที่มุ่งไปยังเป้าหมาย มีแรงจูงใจหรือตั้งใจ และเชื่อว่าตนสามารถคิดหาแนวทางซึ่งทำให้บรรลุเป้าหมายที่ต้องการได้\n' +
          '\t<bullet-stroke>\u2022</bullet-stroke><bold-title>\tควรมองโลกในแง่ดี</bold-title> มีความคิดบวกที่มีต่อบุคคล สถานการณ์หรือต่อสถานที่ต่างๆ มีความสามารถในการยอมรับความจริงต่างๆ ในชีวิตได้อย่างที่เป็นจริง เชื่อว่าเหตุการณ์ทางบวกจะเกิดขึ้นกับตนเองในปัจจุบันและอนาคต\n' +
          '\t<bullet-stroke>\u2022</bullet-stroke><bold-title>\tมีความสามารถในการฟื้นพลัง</bold-title> คือสามารถปรับสภาพจิตใจ ปรับตัว เมื่อต้องเผชิญกับสถานการณ์ที่เป็นปัญหา อุปสรรค จะสามารถฟื้นตัวกลับสู่สภาพเดิมหรือดีขึ้น สามารถฟื้นฟูสภาพของตนเองให้กลับมาดังเดิมได้',
    ),
    new ContentData(
      id: '2',
      icon: Icons.directions_walk,
      topic: 'แรงจูงใจในการเป็นผู้สูงอายุที่มีศักยภาพ (Active Aging)',
      description:
          'เมื่อก้าวเข้าสู่การเป็นผู้สูงอายุ ควรเป็นผู้สูงอายุที่มีศักยภาพ ดังนี้\n' +
              '\t<bullet-stroke>\u2022</bullet-stroke><bold-title>\tการเป็นผู้สูงอายุที่ยังประโยชน์</bold-title> หมายถึง การมีความสามารถในการพาตนเองเท่าที่จะทําได้ของ และการใช้ความสามารถเพื่อให้เกิดความสร้างสรรค์ต่อตนเองและบุคคลอื่น\n' +
              '\t<bullet-stroke>\u2022</bullet-stroke><bold-title>\tการเป็นผู้สูงอายุที่ประสบความสําเร็จ</bold-title> หมายถึง ผู้ที่ดํารงชีวิตอยู่ในสังคมได้อย่างเหมาะสม โดยมีความพึงพอใจและความต้องการของตนเองมาประกอบ ได้แก่ มีชีวิตที่ยืนยาว มีสุขภาพกายและจิตที่ดี สามารถอยู่ในสังคม และมีเศรษฐกิจที่สามารถดำรงอยู่ได้',
    ),
    new ContentData(
      id: '3',
      icon: Icons.accessibility_new,
      topic: 'การเตรียมความพร้อมก่อนการเข้าวัยผู้สูงอายุ ด้านร่างกาย',
      description: '<bullet-stroke>\u2022</bullet-stroke>\tดูแลให้ดีตั้งแต่อายุน้อยๆ\n' +
          '<bullet-stroke>\u2022</bullet-stroke>\tรับประทานอาหารครบ 5 หมู่ ในปริมาณที่เหมาะสม\n' +
          '<bullet-stroke>\u2022</bullet-stroke>\tออกกำลังกายสม่ำเสมอ\n' +
          '<bullet-stroke>\u2022</bullet-stroke>\tควบคุมน้ำหนักไม่ให้มากหรือน้อยเกินไป\n' +
          '<bullet-stroke>\u2022</bullet-stroke>\tการตรวจร่างกายประจำปี อย่างน้อยปีละ 1 ครั้ง\n' +
          '<bullet-stroke>\u2022</bullet-stroke>\tงดเครื่องดื่มที่มีแอลกอฮอล์และงดสูบบุหรี่',
    ),
    new ContentData(
      id: '4',
      icon: Icons.favorite,
      topic: 'การเตรียมความพร้อมก่อนการเข้าวัยผู้สูงอายุ ด้านจิตใจ',
      image: 'assets/images/43005.png',
      description:
          '<bullet-stroke>\u2022</bullet-stroke>\tทำจิตใจ เตรียมรับมือกับความเสื่อมของร่างกาย\n' +
              '<bullet-stroke>\u2022</bullet-stroke>\tหมั่นทำจิตใจให้สดใสเบิกบาน\n' +
              '<bullet-stroke>\u2022</bullet-stroke>\tศึกษาธรรมะ หรือร่วมกิจกรรมทางศาสนา รู้จักปล่อยวาง',
    ),
    new ContentData(
        id: '5',
        icon: Icons.supervisor_account,
        topic: 'การเตรียมความพร้อมก่อนการเข้าวัยผู้สูงอายุ ด้านสังคม',
        description: '<bullet-stroke>\u2022</bullet-stroke><bold-title>\tเป็นผู้สูงวัยที่เป็นประโยชน์ต่อสังคม</bold-title> ถ่ายทอดประสบการณ์ให้คนรุ่นใหม่\n' +
            '<bullet-stroke>\u2022</bullet-stroke><bold-title>\tประกอบอาชีพที่เหมาะสมตามวัย</bold-title> สภาพร่างกาย ความชอบของตนเอง และมีรายได้เพียงพอ\n' +
            '<bullet-stroke>\u2022</bullet-stroke><bold-title>\tร่วมกิจกรรมนันทนาการ</bold-title> เช่น การเรียนรู้เพื่อพัฒนาตนเอง การเป็นอาสาสมัคร เป็นสมาชิกชมรมผู้สูงอายุ และทำงานอดิเรก เป็นต้น\n' +
            '<bullet-stroke>\u2022</bullet-stroke><bold-title>\tการขยายวงสังคมให้ได้รู้จักเพื่อนต่างวัย</bold-title> ทำให้คลายเหงา การทำจิตใจให้ร่าเริงเบิกบานอยู่เสมอจะทำให้อายุยืน'),
    new ContentData(
        id: '6',
        icon: Icons.attach_money,
        topic: 'การเตรียมความพร้อมก่อนการเข้าวัยผู้สูงอายุ ด้านเศรษฐกิจ',
        description: 'การออมเงินทุกช่วงวัยเป็นหลักประกันให้มีคุณภาพชีวิตที่ดี เมื่อเข้าสู่วัยผู้สูงอายุ\n' +
            '<bold>เทคนิคการออม</bold>\n' +
            '\t<bullet-stroke>\u2022</bullet-stroke><bold-title>\tช่วงอายุก่อน 30 ปี</bold-title> เป็นช่วงที่โอกาสเก็บออมสูง จึงควรแบ่งเงินออมไม่ต่ำกว่า 50 % ของรายได้\n' +
            '\t<bullet-stroke>\u2022</bullet-stroke><bold-title>\tช่วงอายุก่อน 30-40 ปี</bold-title> เป็นช่วงที่มีภาระค่าใช้จ่ายสูง เพราะเป็นรอยต่อของชีวิตคู่และมีครอบครัว ควรแบ่งเงินออมไม่ต่ำกว่า 35% ของรายได้\n' +
            '\t<bullet-stroke>\u2022</bullet-stroke><bold-title>\tช่วงอายุก่อน 30-50 ปี</bold-title> เป็นช่วงที่มีรายจ่ายค่อนข้างมากกว่าช่วงอื่นๆ แต่ก็ควรแบ่งเงินออมไม่ต่ำกว่า 30 % ของรายได้\n' +
            '\t<bullet-stroke>\u2022</bullet-stroke><bold-title>\tช่วงอายุก่อน 50-60 ปี</bold-title> เป็นช่วงที่เหลือเวลาทำงานไม่นาน ควรเน้นการนำเงินส่วนใหญ่ที่ได้ไปเก็บออม โดยควรแบ่งเงินออมไม่ต่ำกว่า 70 % ของรายได้\n' +
            '\t<bullet-stroke>\u2022</bullet-stroke><bold-title>\tช่วงอายุ 70 ปี ขึ้นไป</bold-title> เป็นช่วงวัยเพื่อการพักผ่อนและท่องเที่ยว ควรแบ่งเงินออมไม่ต่ำกว่า 25 % ของรายได้'),
  ];

  static Future<void> contentBottomSheet(BuildContext context,
      List<ContentData> listContent, Set<String> readIdContents,
      {String activeId, bool canPop: true, bool hasTransition: true}) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      enableDrag: true,
      builder: (BuildContext bc) {
        return Container(
          padding: EdgeInsets.only(
            top: 20.0,
            left: 8.0,
            right: 8.0,
            bottom: 8.0,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height / 1.5,
            ),
            child: SingleChildScrollView(
              child: SafeArea(
                child: Wrap(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                      ),
                      child: Stack(
                        children: [
                          Align(
                            heightFactor: 1.5,
                            alignment: Alignment.center,
                            child: Text(
                              'เนื้อหา',
                              style: TextStyle(
                                  color: UiData.themeColor, fontSize: 20.0),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            heightFactor: 1.0,
                            child: IconButton(
                              splashRadius: 20.0,
                              icon: Icon(Icons.close),
                              iconSize: 26.0,
                              onPressed: () => {
                                Navigator.of(context).pop(),
                              },
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Column(
                      children: listContent
                          .map(
                            (contentData) => Column(
                              children: [
                                Ink(
                                  color: activeId == contentData.id
                                      ? Colors.green
                                      : Colors.transparent,
                                  child: ListTile(
                                    selected: true,
                                    leading: Badge(
                                      showBadge: readIdContents
                                              .where((element) =>
                                                  element == contentData.id)
                                              .toList()
                                              .isEmpty
                                          ? true
                                          : false,
                                      animationType: BadgeAnimationType.scale,
                                      position: BadgePosition.topRight(
                                          top: 0.0, right: 0.0),
                                      child: ClipOval(
                                        child: Material(
                                          color: activeId == contentData.id
                                              ? Colors.white
                                              : Colors.blue,
                                          child: SizedBox(
                                            width: 40.0,
                                            height: 40.0,
                                            child: Icon(
                                              contentData.icon,
                                              color: activeId == contentData.id
                                                  ? Colors.green
                                                  : Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      activeId == contentData.id
                                          ? contentData.topic +
                                              ' (ดูอยู่ตอนนี้)'
                                          : contentData.topic,
                                      style: TextStyle(
                                          color: activeId == contentData.id
                                              ? Colors.white
                                              : Colors.black54),
                                    ),
                                    onTap: () => {
                                      activeId == contentData.id
                                          ? Navigator.pop(context)
                                          : canPop
                                              ? hasTransition
                                                  ? Navigator.pushNamed(
                                                      context,
                                                      UiData.contentTag,
                                                      arguments: contentData.id,
                                                    )
                                                  : Navigator
                                                      .pushAndRemoveUntil(
                                                      context,
                                                      PageRouteBuilder(
                                                        settings: RouteSettings(
                                                            arguments:
                                                                contentData.id),
                                                        pageBuilder: (context,
                                                                animation,
                                                                anotherAnimation) =>
                                                            ContentPage(),
                                                        transitionDuration:
                                                            Duration(
                                                                milliseconds:
                                                                    0),
                                                      ),
                                                      ModalRoute.withName(
                                                        UiData.homeTag,
                                                      ),
                                                    )
                                              : hasTransition
                                                  ? Navigator
                                                      .pushNamedAndRemoveUntil(
                                                      context,
                                                      UiData.contentTag,
                                                      ModalRoute.withName(
                                                        UiData.homeTag,
                                                      ),
                                                      arguments: contentData.id,
                                                    )
                                                  : Navigator
                                                      .pushAndRemoveUntil(
                                                      context,
                                                      PageRouteBuilder(
                                                        settings: RouteSettings(
                                                            arguments:
                                                                contentData.id),
                                                        pageBuilder: (context,
                                                                animation,
                                                                anotherAnimation) =>
                                                            ContentPage(),
                                                        transitionDuration:
                                                            Duration(
                                                                milliseconds:
                                                                    0),
                                                      ),
                                                      ModalRoute.withName(
                                                        UiData.homeTag,
                                                      ),
                                                    ),
                                    },
                                  ),
                                ),
                                Divider(),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
