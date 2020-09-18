import 'package:flutter/material.dart';
import 'package:hello_older/util/uidata.dart';

class CustomFormDialog extends StatefulWidget {
  final IconData titleIcon;
  final String title, labelText, buttonText;
  final String initInput;

  CustomFormDialog({
    @required this.titleIcon,
    @required this.title,
    @required this.labelText,
    @required this.buttonText,
    this.initInput,
  });

  @override
  _CustomFormDialogState createState() => _CustomFormDialogState();
}

class _CustomFormDialogState extends State<CustomFormDialog> {
  final _formKey = GlobalKey<FormState>();

  String _newInputValue;

  dialogContent(BuildContext context) {
    return Form(
      key: _formKey,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: UiData.avatarRadius + UiData.padding,
              bottom: UiData.padding,
              left: UiData.padding,
              right: UiData.padding,
            ),
            margin: EdgeInsets.only(top: UiData.avatarRadius),
            decoration: new BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(UiData.padding),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // To make the card compact
              children: <Widget>[
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: widget.labelText,
                      floatingLabelBehavior: FloatingLabelBehavior.auto),
                  initialValue: widget.initInput,
                  autofocus: true,
                  validator: (String input) {
                    if (input.isEmpty) {
                      return 'กรุณากรอกชื่อ';
                    }
                    return null;
                  },
                  onSaved: (input) => _newInputValue = input,
                ),
                SizedBox(height: 24.0),
                Align(
                  alignment: Alignment.bottomCenter,
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
                        Icons.done,
                        color: Colors.white,
                        size: 25,
                      ),
                      label: Text(
                        widget.buttonText,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          Navigator.pop(context, _newInputValue);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: UiData.padding,
            right: UiData.padding,
            child: CircleAvatar(
              child: Icon(
                widget.titleIcon,
                color: Colors.white,
                size: 90.0,
              ),
              backgroundColor: UiData.themeColor,
              radius: UiData.avatarRadius,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UiData.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}
