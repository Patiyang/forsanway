import 'package:flutter/material.dart';

import 'styling.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final iconOne;
  final iconTwo;
  final Color containerColor;
  final Color hintColor;
  final TextEditingController controller;
  final bool obscure;
  final bool readOnly;
  final TextInputType textInputType;
  final TextAlign align;
  final double radius;
  final double width;
  final changed;
  final int maxLines;
//validator components
  final InputBorder inputBorder;
  final validator;
  const CustomTextField({
    Key key,
    this.hint,
    this.width,
    this.iconOne,
    this.iconTwo,
    this.containerColor,
    this.hintColor,
    this.controller,
    this.validator,
    this.obscure,
    this.textInputType,
    this.align,
    @required this.radius,
    this.inputBorder,
    this.changed,
    this.readOnly,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(radius)), boxShadow: [
        BoxShadow(blurRadius: 0, color: containerColor ?? white, spreadRadius: 0),
      ]),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 11),
        width: width ?? MediaQuery.of(context).size.width - 100,
        child: TextFormField(
          maxLines: maxLines ?? 1,
          readOnly: readOnly ?? false,
          textAlign: align ?? TextAlign.center,
          keyboardType: textInputType,
          obscureText: obscure ?? false,
          validator: validator,
          onChanged: changed,
          controller: controller,
          style: TextStyle(color: black),
          cursorColor: black,
          decoration: InputDecoration(
            // icon: Icon(iconOne),
            // prefixIcon: Icon(iconOne),
            // suffixIcon: Icon(iconTwo),
            border: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(color: hintColor ?? grey),
          ),
        ),
      ),
    );
  }
}

class LoginTextField extends StatelessWidget {
  final String hint;
  final iconOne;
  final iconTwo;
  final Color containerColor;
  final Color hintColor;
  final TextEditingController controller;
  final bool obscure;
  final TextInputType textInputType;
  final TextAlign align;
  final double radius;
  final InputBorder inputBorder;
  final validator;

  const LoginTextField(
      {Key key,
      this.hint,
      this.iconOne,
      this.iconTwo,
      this.containerColor,
      this.hintColor,
      this.controller,
      this.obscure,
      this.textInputType,
      this.align,
      this.radius,
      this.inputBorder,
      this.validator})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 3),
        child: TextFormField(
          textAlign: align ?? TextAlign.start,
          keyboardType: textInputType,
          obscureText: obscure ?? false,
          validator: validator,
          controller: controller,
          style: TextStyle(color: black),
          cursorColor: black,
          decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(radius??17))),
            suffixIcon: iconTwo,
            labelText: hint,
            hintStyle: TextStyle(color: hintColor ?? grey),
            
          ),
        ),
      ),
    );
  }
}
