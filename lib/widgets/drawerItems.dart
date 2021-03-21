
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'styling.dart';
import 'customText.dart';

class ListTiles extends StatelessWidget {
  final icon;
  final String text;
  final VoidCallback callback;
  const ListTiles({Key key, @required this.icon, @required this.text, this.callback}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        padding: EdgeInsets.only(left: 15, top: 5, bottom: 10),
        height: 50,
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Icon(icon, color: grey),
            SizedBox(width: 30),
            CustomText(text: text, size: 13, fontWeight: FontWeight.w600, color: grey, letterSpacing: .3),
          ],
        ),
      ),
    );
  }
}
