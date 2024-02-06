 import 'package:flutter/material.dart';

import 'input_validation_item.dart';
class ValidationsForm  {
    ValidationsForm( )  ;
List<InputValidationForm> inputValidationForm =[];




 GlobalKey<FormState> form = GlobalKey();

  Widget build(BuildContext context  ,  List<InputValidationForm> inputValidationForm) {

  this.inputValidationForm = inputValidationForm ;
  List<Widget> inputs = _getInputs(context);
    return   Container(
      child: Form(key: form,
      child: Container(
        child: Column(
          children: inputs,
        ),
      ),),
    );
  }

  List<Widget>_getInputs(BuildContext context ){
    List<Widget> inputs = [];
      inputValidationForm.map((e) => {
       inputs.add(e.getWedgetFormField(context))
     }).toList();
     return inputs ;
  }
 Map<String , dynamic > getInputData (){
   Map<String , dynamic > dataMap  =Map();
  if (form.currentState!.validate()){
    form.currentState!.save();
    inputValidationForm.map((e)   {
      if (e.mapValue != null ){
     dataMap[e.keyData] = e.mapValue![e.keyData];   }
    }).toList();
  }
    return dataMap ;
}


}
