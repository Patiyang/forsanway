import 'package:flutter/material.dart';
import 'package:forsanway/widgets/customText.dart';
import 'package:forsanway/widgets/styling.dart';

class CustomListTile extends StatelessWidget {
  final VoidCallback callBack;
  final String text;
  final String subtitleText;
  final double padding;
  final double titleTextSize;
  final double subtitleTextSize;
  final FontWeight fontWeight;
  final trailing;
  final leadingIcon;
  final Color color;
  final Color iconColor;
  const CustomListTile(
      {Key key,
      this.callBack,
      this.text,
      this.padding,
      this.titleTextSize,
      this.fontWeight,
      this.subtitleText,
      this.subtitleTextSize,
      this.leadingIcon,
      this.trailing, this.color, this.iconColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      tileColor: color??grey[200],
      onTap: callBack,
      title: CustomText(text: text, size: titleTextSize ?? 19, fontWeight: fontWeight ?? FontWeight.w600),
      subtitle: CustomText(text: subtitleText, size: subtitleTextSize ?? 13),
      contentPadding: EdgeInsets.all(padding ?? 10),
      leading: Icon(leadingIcon,color:iconColor??blue),
      trailing: trailing ?? SizedBox.shrink(),
    );
  }
}
