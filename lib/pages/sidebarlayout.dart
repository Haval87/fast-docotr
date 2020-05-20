import 'package:flutter/material.dart';
import 'package:multiclinic/pages/homepage.dart';
import 'package:multiclinic/pages/sidebar.dart';

class SideBarLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          HomePage(),
          SideBar(),


        ],
      ),
    );
  }
}
