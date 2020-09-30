import 'package:badges/badges.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello_older/model/score.dart';
import 'package:hello_older/util/custom-decision-dialog.dart';
import 'package:hello_older/util/preference-setting.dart';
import 'package:hello_older/util/uidata.dart';
import 'package:hello_older/widget/username-widget.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  static String tag = 'home-page';

  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  VideoPlayerController _controller;
  ChewieController _chewieController;
  DateTime currentBackPressTime;

  bool _isPostTested;

  @override
  void initState() {
    initialIsPostTested();

    _controller = VideoPlayerController.asset(
      "assets/videos/video.mp4",
    );

    _chewieController = ChewieController(
      videoPlayerController: _controller,
      allowFullScreen: true,
      allowedScreenSleep: false,
      autoInitialize: true,
      allowMuting: true,
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.portraitUp,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight
      ],
      showControls: true,
      autoPlay: false,
      looping: false,
    );

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
    _chewieController.dispose();
  }

  initialIsPostTested() {
    bool isPostTest = PreferenceSettings.getPostTested();
    setState(() {
      _isPostTested = isPostTest;
    });
  }

  Future<void> createDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => CustomDecisionDialog(
        titleIcon: Icons.close,
        title: "ไม่สามารถดำเนินการได้",
        description:
            'กรุณาศึกษาเนื้อหาในเมนู "เนื้อหาการเรียนรู้" ให้ครบถ้วน ก่อนดำเนินการสอบ',
        buttonText: "เข้าใจแล้ว",
        color: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: Icon(
          Icons.home,
          color: Colors.white,
          size: 30.0,
        ),
        title: Text(
          'หน้าหลัก',
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
        actions: [
          UsernameWidget(
            fontColor: Colors.white,
          ),
        ],
        backgroundColor: UiData.themeMaterialColor,
      ),
      body: WillPopScope(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  child: Column(
                    children: [
                      Divider(
                        indent: 20.0,
                        endIndent: 20.0,
                        thickness: 1.0,
                        height: 20.0,
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                            top: 0,
                            left: 16,
                            right: 16,
                            bottom: 16,
                          ),
                          child: GridView.count(
                            padding: EdgeInsets.only(
                              top: 15.0,
                            ),
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            crossAxisCount: 2,
                            childAspectRatio: .90,
                            children: <Widget>[
                              cardMenuWidget(
                                UiData.themeMaterialColor,
                                Colors.white,
                                'จุดประสงค์การเรียนรู้',
                                () async => {
                                  await Navigator.pushNamed(
                                    context,
                                    UiData.objectiveTag,
                                  ),
                                },
                                image: 'assets/images/44126.png',
                              ),
                              PreferenceBuilder(
                                  preference:
                                      PreferenceSettings.getReadContentSteam(),
                                  builder: (
                                    BuildContext context,
                                    List<String> _listData,
                                  ) {
                                    Set<String> _listReadIdContent =
                                        _listData.toSet();
                                    int _countIdContentBadge =
                                        UiData.listContent.length -
                                            _listReadIdContent.length;

                                    return Badge(
                                      padding: EdgeInsets.all(10.0),
                                      badgeContent: Text(
                                        _countIdContentBadge.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      showBadge: _countIdContentBadge > 0
                                          ? true
                                          : false,
                                      position: BadgePosition.topRight(
                                        top: -20.0,
                                        right: 5.0,
                                      ),
                                      borderRadius: 50.0,
                                      animationType: BadgeAnimationType.slide,
                                      child: cardMenuWidget(
                                        UiData.themeMaterialColor,
                                        Colors.white,
                                        'เนื้อหาการเรียนรู้',
                                        () async {
                                          await UiData.contentBottomSheet(
                                            context,
                                            UiData.listContent,
                                          );
                                        },
                                        image: 'assets/images/5946.png',
                                      ),
                                    );
                                  }),
                              cardMenuWidget(
                                UiData.themeMaterialColor,
                                Colors.white,
                                'สรุป',
                                () async {
                                  await _createVideoDialog(context);

                                  _chewieController.pause();
                                  _chewieController
                                      .seekTo(Duration(milliseconds: 0));
                                },
                                image: 'assets/images/48.png',
                              ),
                              PreferenceBuilder(
                                  preference:
                                      PreferenceSettings.getReadContentSteam(),
                                  builder: (
                                    BuildContext context,
                                    List<String> _listData,
                                  ) {
                                    Set<String> _listReadIdContent =
                                        _listData.toSet();
                                    int _countIdContentBadge =
                                        UiData.listContent.length -
                                            _listReadIdContent.length;

                                    return _isPostTested
                                        ? cardMenuWidget(
                                            UiData.themeMaterialColor,
                                            Colors.white,
                                            'แบบทดสอบการเรียนรู้',
                                            () {
                                              Score _score = new Score(
                                                topicScore:
                                                    'แบบทดสอบการเรียนรู้',
                                                score: 0,
                                                saveScoreFn: () => {},
                                              );
                                              Navigator.pushNamed(
                                                context,
                                                UiData.examTag,
                                                arguments: _score,
                                              );
                                            },
                                            image: 'assets/images/3297140.png',
                                          )
                                        : Badge(
                                            animationType:
                                                BadgeAnimationType.scale,
                                            shape: BadgeShape.square,
                                            badgeColor:
                                                _countIdContentBadge == 0
                                                    ? Colors.green
                                                    : Colors.red,
                                            padding: EdgeInsets.only(
                                              top: 5.0,
                                              bottom: 5.0,
                                              left: 10.0,
                                              right: 10.0,
                                            ),
                                            position: BadgePosition.topRight(
                                                top: -10.0, right: 0.0),
                                            borderRadius: 20,
                                            badgeContent:
                                                _countIdContentBadge == 0
                                                    ? Text(
                                                        'สามารถสอบได้',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      )
                                                    : Text(
                                                        'ไม่สามารถดำเนินการได้',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                            child: cardMenuWidget(
                                              UiData.themeMaterialColor,
                                              Colors.white,
                                              'แบบทดสอบหลังเรียน',
                                              () {
                                                if (_countIdContentBadge == 0) {
                                                  Score _score = new Score(
                                                    topicScore:
                                                        'แบบทดสอบหลังเรียน',
                                                    saveScoreFn: () {
                                                      PreferenceSettings
                                                          .setPostTested(true);
                                                    },
                                                    score: 0,
                                                  );
                                                  Navigator.pushNamed(
                                                      context, UiData.examTag,
                                                      arguments: _score);
                                                } else {
                                                  createDialog(context);
                                                }
                                              },
                                              image:
                                                  'assets/images/3297140.png',
                                            ),
                                          );
                                  }),
                              cardMenuWidget(
                                UiData.themeMaterialColor,
                                Colors.white,
                                'รายการอ้างอิง',
                                () => {
                                  Navigator.pushNamed(
                                    context,
                                    UiData.referenceTag,
                                  ),
                                },
                                image: 'assets/images/2830038.png',
                              ),
                              cardMenuWidget(
                                UiData.themeMaterialColor,
                                Colors.white,
                                'ผู้จัดทำ',
                                () => {
                                  Navigator.pushNamed(
                                    context,
                                    UiData.teamTag,
                                  ),
                                },
                                image: 'assets/images/20644.png',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          onWillPop: onWillPop),
    );
  }

  Widget cardMenuWidget(
    Color cardColors,
    Color fontColors,
    String text,
    Function() onTapFn, {
    Color borderColor,
    IconData icon,
    String image,
  }) {
    return Card(
      color: cardColors,
      elevation: 2,
      shape: RoundedRectangleBorder(
        side: borderColor != null
            ? BorderSide(color: borderColor, width: 5.0)
            : BorderSide.none,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: onTapFn,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              icon != null
                  ? Icon(
                      icon,
                      size: 100.0,
                      color: fontColors,
                    )
                  : image != null
                      ? Image.asset(
                          image,
                          fit: BoxFit.fitHeight,
                          height: 135.0,
                        )
                      : Text(
                          text.substring(0, 1),
                          style: TextStyle(fontSize: 70.0, color: fontColors),
                        ),
              Text(
                text,
                style: TextStyle(fontSize: 16.0, color: fontColors),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _createVideoDialog(BuildContext context) async {
    return await showDialog(
      useRootNavigator: true,
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) => Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: UiData.padding,
              bottom: UiData.padding,
              left: UiData.padding,
              right: UiData.padding,
            ),
            margin: EdgeInsets.only(top: UiData.avatarRadius),
            child: Chewie(
              controller: _chewieController,
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      _scaffoldKey.currentState.showSnackBar(
        UiData.infoSnackBar(
          'แตะอีกครั้งเพื่อออก',
          duration: Duration(seconds: 2),
        ),
      );
      return Future.value(false);
    }
    return Future.value(true);
  }
}
