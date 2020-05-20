import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart'as http;
import 'Category.dart';
import 'homepage.dart';
import 'myappointment.dart';
import 'profilePage.dart';
import 'package:url_launcher/url_launcher.dart'as UrlLauncher;


class SideBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar (
        backgroundColor: Colors.teal,
      ),
      drawer: Drawer (
          child: Column (
            children: <Widget>[
              DrawerHeader (
                child: CircleAvatar (
                  radius: 60,
                  backgroundImage: AssetImage ("images/haval.JPG"),

                ),
              ),

              Divider (
                color: Colors.blue,
              ),
              Container (
                padding: EdgeInsets.only (top: 10),
                child: Column (
                  children: <Widget>[
                    ListTile (
                      title: Text ("Home"),
                      leading: Icon (Icons.home),

                      onTap: () {
                        Navigator.pop (context);
                        Navigator.push (context, MaterialPageRoute (
                          builder: (context) => HomePage (),

                        ));
                      },
                    ),
                    ListTile (
                      title: Text ("Categories"),
                      leading: Icon (Icons.category),
                      onTap: () {
                        Navigator.pop (context);
                        Navigator.push (context, MaterialPageRoute (
                          builder: (context) => MyClass (),

                        ));
                      },

                    ),
                    ListTile (
                      title: Text ("Profile"),
                      leading: Icon (Icons.person),
                      onTap: () {
                        Navigator.pop (context);
                        Navigator.push (context, MaterialPageRoute (
                          builder: (context) => ProfilePage (),

                        ));
                      },
                    ),
                    ListTile (

                      title: Text ("My Appoinment"),
                      leading: Icon (Icons.schedule),
                      onTap: () {
                        Navigator.push (context, MaterialPageRoute (
                          builder: (context) => AppointmentPage (),


                        ));
                      },
                    ),
                    ListTile (
                      title: Text ("Emergency"),
                      leading: Icon (Icons.local_hospital),
                      onTap: () {
                        showDialog (
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog (
                                backgroundColor: Colors.white,
                                content: Container (
                                  width: MediaQuery
                                      .of (context)
                                      .size
                                      .width / 2,
                                  height: MediaQuery
                                      .of (context)
                                      .size
                                      .height / 2,
                                  decoration: BoxDecoration (
                                      gradient: LinearGradient (
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color (0xFF77EED8),
                                          Color (0xff9EABE4
                                          )
                                        ],
                                      ),
                                      borderRadius: BorderRadius.all (
                                          Radius.circular (10))
                                  ),
                                  child: Column (
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      RaisedButton (
                                        child: Text ("Call Ambulance"),
                                        onPressed: () =>
                                            UrlLauncher.launch (
                                                "tel:9647504221219"),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                        );
                      },
                    ),

                    ListTile (
                        title: Text ("Logout"),
                        leading: Icon (Icons.exit_to_app),
                        onTap: () {
                          showDialog (
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog (
                                  content: Column (
                                    children: <Widget>[
                                      Text (
                                          "Are you sure you want to close Fast Doctor?"),
                                      Row (
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: <Widget>[
                                          FlatButton (
                                            onPressed: () {
                                              Navigator.pop (context);
                                            },
                                            child: Text ("No"),
                                          ),
                                          FlatButton (
                                            onPressed: () {
                                              SystemChannels.platform
                                                  .invokeMethod (
                                                  'SystemNavigator.pop');
                                            },
                                            child: Text ("Yes"),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              }

                          );
                        }

                    ),

                  ],
                ),
              )
            ],
          )

      ),

      body: HomePage (),
    );
  }
}
