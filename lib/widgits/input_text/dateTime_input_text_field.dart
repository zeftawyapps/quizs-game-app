import 'package:flutter/material.dart';

import 'input_text_field.dart';

class DateTimeTextField extends StatefulWidget {
    DateTimeTextField({Key? key , required this.decoration ,
    this.initDate , this.lastDate , this  .firestDate ,
     required   this.hintText , required this.onSave , required this.onvlaidate
    }) : super(key: key);
    InputDecoration decoration ;
    DateTime? initDate , firestDate , lastDate ;
    String hintText ;
    var onvlaidate , onSave ;
  @override
  State<DateTimeTextField> createState() => _DateTimeTextFieldState();
}

class _DateTimeTextFieldState extends State<DateTimeTextField> {
 DateTime? value;
 TextEditingController controller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    DateTime init = widget .  initDate??DateTime.now() ;
    DateTime first = widget .  firestDate??DateTime.now() ;
    DateTime last = widget .  lastDate ?? first.add(Duration(days: 1)) ;

    return InputTextFormfield(
      controller: controller ,
      onTap: (){
        showDatePicker(context: context, initialDate: init, firstDate: first, lastDate: last )
            .then((value)   {

          setState(() {
            this.value = value ;
          });
        });
      },
      decoration: widget .  decoration.copyWith(hintText: widget .  hintText),
        validate: widget.onvlaidate ,
        saved  :widget.onSave   ,mainValue: this.value.toString(),
    );
  }
}
