import 'package:flutter/material.dart';
import 'styling.dart';
import 'customText.dart';

///like all the widgets in ths folder, these widgets are meant to make deisgn easier
///rather than repeading the same widget over and over again, I utilize these instead
class CustomButton extends StatefulWidget {
  final VoidCallback callback;
  final icon;
  final String text;
  final Color color;
  final double size;
  final ShapeBorder shape;

  const CustomButton({Key key, @required this.callback, @required this.icon, @required this.text, this.color, this.size, this.shape}) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: widget.shape,
      splashColor: blue,
      onPressed: widget.callback,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Icon(widget.icon, color: widget.color),
          CustomText(text: widget.text, color: widget.color, fontWeight: FontWeight.normal, size: widget.size ?? 13),
        ],
      ),
    );
  }
}

class CustomFlatButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final Color iconColor;
  final VoidCallback callback;
  // final ShapeBorder shape;
  final double height;
  final double width;
  final double radius;
  final double iconSize;
  final icon;
  final double fontSize;

  const CustomFlatButton(
      {Key key, this.text, this.color, this.callback, this.textColor, this.height, this.width, this.radius, this.icon, this.fontSize, this.iconColor, this.iconSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: MaterialButton(
        elevation: 0,
        height: height ?? 45,
        minWidth: width ?? 200,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(radius))),
        onPressed: callback,
        color: color ?? blue,
        child: Container(
          width: width ?? 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon == null ? SizedBox.shrink() : Icon(icon, color: iconColor??white,size: iconSize??17,),
              SizedBox(
                width: 5,
              ),
              CustomText(
                text: text ?? '',
                color: textColor??white,
                size: fontSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
