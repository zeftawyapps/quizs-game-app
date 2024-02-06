 import 'package:flutter/material.dart';
import 'package:islamic_quizs_game/widgits/app_drawer.dart';


class ProjectScreen extends StatelessWidget {
    ProjectScreen( { required this.child ,   Key? key}) : super(key: key);
Widget child ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: SafeArea(
        child: child ,
      ),
    );
  }
}
