import 'package:flutter/material.dart';

import '../../../../util/validators/base_validator.dart';
import '../../../input_text/input_text_field.dart';
import '../input_validation_item.dart';

class TextFormFieldValidation extends InputValidationForm {
  InputDecoration decoration;
  TextStyle textStyle;
  bool isPssword;
  TextInputType textInputType = TextInputType.text;
  EdgeInsets? padding;
  dynamic initValue;
  TextEditingController? controller;
  TextFormFieldValidation(
      {this.initValue,
      this.textInputType = TextInputType.text,
      this.controller,
      required this.textStyle,
      this.isPssword = false,
      required this.decoration,
      required super.keyData,
      required super.baseValidation,
      required super.hintText ,
      this.padding
      });
  @override
  Widget getWedgetFormField(BuildContext context) {
    mapValue = Map<String, dynamic>();
    return Padding(
      padding:  padding ??   EdgeInsets.symmetric(vertical: 5),
      child: Container(
        decoration: BoxDecoration(boxShadow: []),
        child: InputTextFormfield(
            textInputType: textInputType,
            controller: this.controller,
            mainValue: this.controller != null ? initValue : null,
            style: textStyle,
            isPressed: this.isPssword,
            decoration: decoration.copyWith(labelText: hintText),
            validate: (v) {
              if (baseValidation != null) {
                return BaseValidator.validateValue(
                    context, v.toString().trim(), baseValidation!);
              } else {
                return null;
              }
            },
            saved: (v) {
              if (textInputType == TextInputType.number)
                mapValue!["$keyData"] = int.parse(v!);
              else {
                mapValue!["$keyData"] = v;
              }
            }),
      ),
    );
  }
}
