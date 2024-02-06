
import 'package:flutter/material.dart';

import '../../../../util/validators/base_validator.dart';
import '../../../input_text/dateTime_input_text_field.dart';
import '../input_validation_item.dart';

class DateTimeTextFieldValidaion extends InputValidationForm{
  InputDecoration decoration ;
  DateTime? initDate , firestDate , lastDate ;
  DateTimeTextFieldValidaion({
    this.initDate , this.firestDate , this.lastDate ,
    required this.decoration,
    required super.keyData, required super.baseValidation,  required super.hintText});
@override
  Widget getWedgetFormField(BuildContext context) {
  DateTime init = initDate??DateTime.now() ;
  DateTime first = firestDate??DateTime.now() ;
  DateTime last = lastDate ?? first.add(Duration(days: 1)) ;
  mapValue = Map<String , dynamic>();

  return DateTimeTextField(decoration: decoration, hintText: hintText,
      onvlaidate: (v){
        if (baseValidation != null ){
          return BaseValidator.validateValue(context, v.toString().trim(), baseValidation!) ;}
        else {return null ; }
      } ,
      onSave : (v){
        mapValue!["$keyData"] = v ;   }
  );

  }


}