import 'package:flutter/material.dart';
import 'package:hello_older/util/custom-form-dialog.dart';
import 'package:hello_older/util/preference-setting.dart';
import 'package:hello_older/util/uidata.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

// ignore: must_be_immutable
class UsernameWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;
  Color fontColor = Colors.black87;
  UsernameWidget(this._scaffoldKey, {this.fontColor});

  @override
  _UsernameWidgetState createState() => _UsernameWidgetState();
}

class _UsernameWidgetState extends State<UsernameWidget> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return PreferenceBuilder<String>(
      preference: PreferenceSettings.getUserNameStream(),
      builder: (BuildContext context, String _name) {
        if (_name.isEmpty && PreferenceSettings.getFirstTime()) {
          return SizedBox.shrink();
        } else {
          return Align(
            heightFactor: 1.0,
            alignment: Alignment.topRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  _name.isEmpty ? '(เพิ่มชื่อของคุณ)' : 'สวัสดี คุณ$_name',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: widget.fontColor,
                  ),
                ),
                IconButton(
                    icon: Icon(_name.isEmpty ? Icons.add : Icons.edit),
                    color: widget.fontColor,
                    splashRadius: 20.0,
                    onPressed: () => createAlertDialog(context)),
              ],
            ),
          );
        }
      },
    );
  }

  Future<void> createAlertDialog(BuildContext context, {String oldName}) async {
    String newName;
    newName = await showDialog(
      context: context,
      builder: (BuildContext context) => CustomFormDialog(
        titleIcon: oldName == null ? Icons.person_add : Icons.face,
        title: oldName == null ? "กรุณากรอกชื่อของคุณ" : "แก้ไขชื่อของคุณ",
        labelText: 'ชื่อของคุณ',
        buttonText: "ตกลง",
        initInput: oldName,
      ),
    );

    if (newName != null) {
      PreferenceSettings.setUserNameStream(newName);

      widget._scaffoldKey.currentState.hideCurrentSnackBar();

      widget._scaffoldKey.currentState.showSnackBar(
        UiData.successSnackBar(
            oldName == null ? 'เพิ่มชื่อสำเร็จแล้ว' : 'แก้ไขชื่อสำเร็จแล้ว'),
      );
    }
  }
}
