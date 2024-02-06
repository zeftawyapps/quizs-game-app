import 'package:flutter/material.dart';

import '../../../../util/validators/base_validator.dart';
import '../../../input_text/dropDown_text_feild.dart';
import '../input_validation_item.dart';

class DrobDaownValidation extends InputValidationForm {
  List<String> itemslsit;
  InputDecoration decoration;
  DrobDaownValidation(
      {required this.decoration,
      required this.itemslsit,
      required super.keyData,
       super.baseValidation,
      required super.hintText});
  @override
  Widget getWedgetFormField(BuildContext context) {
    mapValue = Map<String , dynamic>();
    return DropDownInputTextField(
      itemslsit: itemslsit,
      hintText: hintText,
      decoration: decoration,
      validation: (v) {
        if (baseValidation != null) {
          return BaseValidator.validateValue(
              context, v.toString().trim(), baseValidation!);
        } else {
          return null;
        }
      },
      onsaved: (v) {
       mapValue!["$keyData"] = v;
      },
    );
  }
}
