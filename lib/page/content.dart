import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hello_older/model/content-data.dart';
import 'package:hello_older/util/custom-decision-dialog.dart';
import 'package:hello_older/util/custom-form-dialog.dart';
import 'package:hello_older/util/uidata.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:styled_text/styled_text.dart';

class ContentPage extends StatefulWidget {
  static String tag = 'content-page';

  ContentPage({Key key}) : super(key: key);

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _name;
  bool _firstTime;
  List<ContentData> _listContent;
  ContentData _selectedContent;
  Set<String> _listReadIdContent;
  String _contentId;
  bool _isPostTested;
  bool _isDialogShowing = false;
  String message = '';

  ScrollController _controller;
  AnimationController _animationController;
  Timer _timer;

  @override
  void initState() {
    _listContent = UiData.listContent;
    _controller = ScrollController();
    _controller.addListener(_scrollListener);

    initialUserName();
    initialReadIdContent();
    initialIsPostTested();
    _initialScrollButton(
      duration: new Duration(seconds: 1),
    );

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animationController.forward();

    super.initState();
  }

  _initialScrollButton({@required duration}) {
    _timer = new Timer(duration, () {
      if (_controller.position.maxScrollExtent > 0.0) {
        setState(() {
          message = 'เลื่อนลงเพื่ออ่านต่อ';
        });
      }
      if (_timer.isActive) {
        _timer.cancel();
      }
    });
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        message = '';
      });
    }
  }

  _moveDown() {
    _controller.animateTo(_controller.position.maxScrollExtent,
        curve: Curves.linear, duration: Duration(milliseconds: 500));
  }

  initialUserName() async {
    String name = await UiData.getUserName();
    bool isFirstTime = await UiData.isFirstTimeExam();
    setState(() {
      _firstTime = isFirstTime;
      _name = name;
    });
  }

  initialIsPostTested() async {
    bool isPostTested = await UiData.isPostTested();
    setState(() {
      _isPostTested = isPostTested;
    });
  }

  initialReadIdContent() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Set<String> listReadIdContent = await UiData.getReadContent();
    setState(() {
      _listReadIdContent = listReadIdContent;

      _listReadIdContent.add(_selectedContent.id);
      sharedPreferences.setStringList(
          UiData.readContentIdKey, _listReadIdContent.toList());
    });
  }

  initialContent() async {
    if (_contentId == null) {
      _contentId = ModalRoute.of(context).settings.arguments;
    }

    _selectedContent =
        _listContent.firstWhere((element) => element.id == _contentId);
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

  Future<void> createDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => CustomDecisionDialog(
        titleIcon: Icons.done,
        title: "ทดสอบหลังเรียน",
        description:
            'คุณศึกษาเนื้อหาครบแล้ว สามารถทดสอบหลังเรียนได้ โดยเลือกเมนู "แบบทดสอบหลังเรียน" ได้ที่หน้าหลัก',
        buttonText: "เข้าใจแล้ว",
        color: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    initialContent();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_listReadIdContent == null) return;
      if (_listReadIdContent.length == _listContent.length && !_isPostTested) {
        if (!_isDialogShowing) {
          _isDialogShowing = true;
          await createDialog(context);
        }
      }
    });

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
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        children: [
                          Text(
                            _selectedContent.topic,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: UiData.themeColor, fontSize: 22.0),
                          ),
                          Divider(),
                          Expanded(
                            child: ListView(
                              controller: _controller,
                              padding: EdgeInsets.all(8.0),
                              shrinkWrap: false,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      child: _selectedContent.image != null
                                          ? Image.asset(
                                              _selectedContent.image,
                                              fit: BoxFit.cover,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  3.5,
                                            )
                                          : null,
                                    ),
                                    StyledText(
                                      text: _selectedContent.description,
                                      newLineAsBreaks: true,
                                      style: TextStyle(
                                          fontFamily: UiData.fontFamily,
                                          color: Colors.black87,
                                          fontSize: 18.0),
                                      styles: UiData.styleText,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                  ),
                  AnimatedCrossFade(
                    sizeCurve: Curves.decelerate,
                    firstChild: Container(),
                    duration: const Duration(milliseconds: 300),
                    crossFadeState: message.isEmpty
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    secondChild: InkWell(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      onTap: () => _moveDown(),
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          children: [
                            Text(
                              message,
                              style: TextStyle(color: Colors.black54),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 15,
                          child: FlatButton(
                            shape: StadiumBorder(
                              side: BorderSide(
                                color: _listContent.first.id != _contentId
                                    ? UiData.themeColor
                                    : Colors.grey,
                                width: 2,
                              ),
                            ),
                            color: UiData.themeColor,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.blueGrey,
                            textColor: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.chevron_left,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                Text(
                                  'เนื้อหาก่อนหน้า',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                            onPressed: _listContent.first.id != _contentId
                                ? () => setState(
                                      () {
                                        _contentId = _listContent[_listContent
                                                    .indexWhere((element) =>
                                                        element.id ==
                                                        _contentId) -
                                                1]
                                            .id;

                                        initialContent();
                                        initialReadIdContent();
                                        _initialScrollButton(
                                          duration: new Duration(seconds: 1),
                                        );
                                      },
                                    )
                                : null,
                          ),
                        ),
                        Flexible(flex: 1, child: SizedBox(width: 1.0)),
                        Flexible(
                          flex: 15,
                          child: FlatButton(
                            shape: StadiumBorder(
                              side: BorderSide(
                                color: _listContent.last.id != _contentId
                                    ? UiData.themeColor
                                    : Colors.grey,
                                width: 2,
                              ),
                            ),
                            color: UiData.themeColor,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.blueGrey,
                            textColor: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'เนื้อหาถัดไป',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal),
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ],
                            ),
                            onPressed: _listContent.last.id != _contentId
                                ? () => setState(
                                      () {
                                        _contentId = _listContent[_listContent
                                                    .indexWhere((element) =>
                                                        element.id ==
                                                        _contentId) +
                                                1]
                                            .id;

                                        initialContent();
                                        initialReadIdContent();
                                        _initialScrollButton(
                                          duration: new Duration(seconds: 1),
                                        );
                                      },
                                    )
                                : null,
                          ),
                        ),
                      ],
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
                        Icons.assignment,
                        color: Colors.white,
                        size: 25,
                      ),
                      label: Text(
                        'เนื้อหาอื่น',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                      onPressed: () => UiData.contentBottomSheet(
                        context,
                        _listContent,
                        _listReadIdContent,
                        activeId: _contentId,
                        canPop: false,
                        hasTransition: false,
                      ),
                    ),
                  ),
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
