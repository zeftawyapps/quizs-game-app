import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class PopUpMenuDep extends StatelessWidget {
      PopUpMenuDep({super.key , required this.onedit , required this.ondelete
      , this.onsort , this.onAddMony
      });
 var onedit   ;
  var ondelete ;
  var onAddMony;
  var onsort ;
  @override
  Widget build(BuildContext context) {
    return  PopupMenuButton(
        iconSize: 5.sp,
        itemBuilder: (context) {
      return [
        PopupMenuItem(

          child: Row(
            children: [
              Icon(Icons.edit , size:4.sp,),
              Text("تعديل" , style: TextStyle(fontSize: 4.sp)),
            ],
          ),
          value: 1,
        ),
        PopupMenuItem(
          child: Row(
            children: [
              Icon(Icons.delete , size: 4 .sp,),
              Text("حذف" , style: TextStyle(fontSize: 4.sp)),
            ],
          ),
          value: 2,
        ),
        // PopupMenuItem(
        //   child: Row(
        //     children: [
        //       Icon(Icons.sort , size: 4 .sp,),
        //       Text("ترتيب" , style: TextStyle(fontSize: 4.sp)),
        //     ],
        //   ),
        //   value: 3,
        // ),
        // PopupMenuItem(
        //   child: Row(
        //     children: [
        //       Icon(Icons.money , size: 4 .sp,),
        //       Text("تقييم نقدي" , style: TextStyle(fontSize: 4.sp)),
        //     ],
        //   ),
        //   value: 4,
        // ),
      ];
    }, onSelected: (value) {
       switch (value) {
         case 1 :
           onedit();
           break;
         case 2 :
           ondelete();
           break;
         case 3 :
           onsort();
           break;
          case 4 :
           onAddMony();
           break;
       }
    });
  }
}
