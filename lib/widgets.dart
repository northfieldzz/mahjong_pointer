import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String text;

  ConfirmDialog({this.title, @required this.text});

  @override
  Widget build(BuildContext context) {
    final loc = MaterialLocalizations.of(context);
    return AlertDialog(
      title: title != null ? Text(title) : null,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(text),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                child: Text(loc.cancelButtonLabel),
                onPressed: () => Navigator.pop(context, false),
              ),
              FlatButton(
                child: Text(loc.okButtonLabel),
                onPressed: () => Navigator.pop(context, true),
              ),
            ],
          ),
        ],
      ),
      contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
    );
  }
}
