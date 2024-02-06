import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class LogInDialog extends StatefulWidget {
  const LogInDialog({super.key});

  @override
  State<LogInDialog> createState() => _LogInDialogState();
}

class _LogInDialogState extends State<LogInDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      width: 200.w,
      child: Text("LogInDialog"),
    );
  }
}
