import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Scaffold(
          body: Container(
            child: Text("users"),
          ),
             ),
    );
  }
}
