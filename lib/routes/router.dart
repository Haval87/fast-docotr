import 'package:flutter/material.dart';
import 'package:multiclinic/pages/Category.dart';
import 'package:multiclinic/pages/details.dart';
import 'package:multiclinic/pages/homepage.dart';
import 'package:multiclinic/pages/myappointment.dart';
import 'package:multiclinic/pages/profilePage.dart';
import 'package:multiclinic/pages/sidebar.dart';
import 'package:multiclinic/pages/loginpage.dart';
import 'package:multiclinic/pages/not_found_page.dart';
import 'package:multiclinic/pages/startuppage.dart';
import '../pages/sidebarlayout.dart';
import 'route_constants.dart';


class Router {
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case startupRoute:
        return MaterialPageRoute(builder: (_) => StartUpPage());//SideBarLayout());//

      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case homeRoute:
      return MaterialPageRoute(builder: (_) => HomePage());
      case sidebarLayout:
      return MaterialPageRoute(builder: (_) => SideBarLayout());
      case sidebar:
        return MaterialPageRoute(builder: (_) => SideBar());
      case category:
        return MaterialPageRoute(builder: (_) => MyClass());
      case profilePage:
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case myAppointment:
        return MaterialPageRoute(builder: (_) => AppointmentPage());
      case detail:
      return MaterialPageRoute(builder: (_) => Detail());
      default:
        return MaterialPageRoute(builder: (_) => NotFoundPage());
    }
  }
}