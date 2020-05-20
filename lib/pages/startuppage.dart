
import 'package:flutter/material.dart';
import 'package:multiclinic/localization/app_localization.dart';
import 'package:multiclinic/routes/route_constants.dart';


class StartUpPage extends StatefulWidget {
  StartUpPage({Key key}):super(key:key);
  @override
  _StartUpPageState createState() => _StartUpPageState();
}

class _StartUpPageState extends State<StartUpPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/background.jpg"), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            title: Text(buildTranslate(context, 'app_name')),
          ),
          body: Container(
            child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                Container(
                  child: Text(buildTranslate(context, "change_Language"),style: TextStyle(
                    color: Colors.black87,fontSize: 18.0
                  ),),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                ),
                Container(
                  width: MediaQuery.of(context).size.width/1.2,
                  height: 50,
                  child:
                  RaisedButton(

                    shape:  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.black)),
                    onPressed: () {
                      Navigator.pushNamed(context, loginRoute);
                    },
                    color: Colors.pink,
                    textColor: Colors.white,
                    child: Text(buildTranslate(context, "english").toUpperCase(),
                        style: TextStyle(fontSize: 14)),

                  ),
                ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width/1.2,
                      height: 50,
                      child:
                      RaisedButton(

                        shape:  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.black)),
                        onPressed: () {
                          Navigator.pushNamed(context, loginRoute);
                        },
                        color: Colors.pink,
                        textColor: Colors.white,
                        child: Text(buildTranslate(context, "kurdish").toUpperCase(),
                            style: TextStyle(fontSize: 14)),

                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width/1.2,
                      height: 50,
                      child:
                      RaisedButton(

                        shape:  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.black)),
                        onPressed: () {
                          Navigator.pushNamed(context, loginRoute);
                        },
                        color: Colors.pink,
                        textColor: Colors.white,
                        child: Text(buildTranslate(context, "arabic").toUpperCase(),
                            style: TextStyle(fontSize: 14)),

                      ),
                    ),

          ],
          ),
          )
          )
        ));
  }
}



