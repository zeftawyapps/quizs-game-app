import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class PopUpMenuDeps extends StatelessWidget {
      PopUpMenuDeps({super.key , required  this.ispublis ,   required this.onpublish});

  var onpublish ;
  bool ispublis = false;
  @override
  Widget build(BuildContext context) {
    return  PopupMenuButton(
        iconSize: 5.sp,
        itemBuilder: (context) {
      return [

        PopupMenuItem(
          child: Row(
            children: [
              Icon( ispublis == false ?   Icons.publish : Icons.public_off , color: Colors.black,),
              Text( ispublis == false ? "نشر" : "الغاء النشر " , style: TextStyle(color: Colors.black),),
            ],
          ),
          value: 2,
        ),
      ];
    }, onSelected: (value) {

        onpublish();

    });
  }
}
