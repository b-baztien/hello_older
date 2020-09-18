import 'package:flutter/material.dart';
import 'package:hello_older/util/uidata.dart';

class CustomDecisionDialog extends StatefulWidget {
  final IconData titleIcon;
  final String title, description, buttonText;
  final Color color;

  CustomDecisionDialog({
    @required this.titleIcon,
    @required this.title,
    @required this.description,
    @required this.buttonText,
    @required this.color,
  });

  @override
  _CustomDecisionDialogState createState() => _CustomDecisionDialogState();
}

class _CustomDecisionDialogState extends State<CustomDecisionDialog> {
  dialogContent(BuildContext context) {
    return Stack(
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
              Text(
                widget.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
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
                      Navigator.pop(context);
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
            backgroundColor: widget.color,
            radius: UiData.avatarRadius,
          ),
        ),
      ],
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
