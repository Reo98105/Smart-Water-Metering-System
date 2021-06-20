import 'package:flutter/material.dart';
import 'package:swms_user_auth_module/intro.dart';
import 'package:swms_user_auth_module/login.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  PageController _controller = PageController(initialPage: 0);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      children: [
        Intro(),
        Login(),
      ],
    );
  }
}
