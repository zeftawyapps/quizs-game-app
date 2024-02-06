import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class PopUpMenu extends StatelessWidget {
      PopUpMenu({super.key , required this.onedit , required this.ondelete});
 var onedit   ;
  var ondelete ;
  @override
  Widget build(BuildContext context) {
    return  PopupMenuButton(
        iconSize: 5.sp,
        itemBuilder: (context) {
      return [
        PopupMenuItem(
          child: Row(
            children: [
              Icon(Icons.edit , ),
              Text("تعديل"),
            ],
          ),
          value: 1,
        ),
        PopupMenuItem(
          child: Row(
            children: [
              Icon(Icons.delete ,),
              Text("حذف"),
            ],
          ),
          value: 2,
        ),
      ];
    }, onSelected: (value) {
      if (value == 1) {
        onedit();
      } else {
        ondelete();
      }
    });
  }
}
