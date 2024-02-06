import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';


class DropDownInputTextField extends StatefulWidget {
  DropDownInputTextField(
      {Key? key,
      required this.itemslsit,
        this.val,

      this.onsaved,
      this.validation,
        this.icon,
      required this.hintText,
      this.useicon = true,
      this.textFieldColor  , required this.decoration})
      : super(key: key);
InputDecoration decoration ;
  bool useicon = true;
  List<String> itemslsit;
  String? val;
  String hintText;

  var onsaved;
  Icon? icon;
  var validation;
  Color? textFieldColor;
  @override
  _DropDownInputTextFieldState createState() => _DropDownInputTextFieldState();
}

class _DropDownInputTextFieldState extends State<DropDownInputTextField> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      items: widget.itemslsit.map((String category) {
        return DropdownMenuItem(
            value: category,
            child: Text(
              category,
              style:
                  TextStyle(fontSize: 14.sp),
            ));
      }).toList(),
      onChanged: (v){
        setState(() {
          widget.val = v;
        });
      },
      value: widget.val != null ? widget.val : widget.itemslsit[0],
      onSaved: widget.onsaved,
      validator: widget.validation,
      style: TextStyle(fontSize: 20.sp, color: Colors.black),
      decoration: widget.decoration.copyWith(hintText: widget.hintText ) ,
    );
  }
}
