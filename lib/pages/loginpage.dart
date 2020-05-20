
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String phoneNo;
  String smsOTP;
  String verificationId;
  String errorMessage = '';
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhone() async {

    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsOTPDialog (context).then ((value) {

        print ('sign in');
      });
    };
    try {
      await _auth.verifyPhoneNumber (
          phoneNumber: this.phoneNo,
          codeAutoRetrievalTimeout: (String verId) {
            this.verificationId = verId;
          },
          codeSent: smsOTPSent,
          timeout: const Duration(seconds: 15),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            Navigator.pushReplacementNamed(context, '/profilePage');
          },
          verificationFailed: (AuthException exception) {
            print ('${exception.message}');
          });
    } catch (e) {
      handleError (e);
    }
  }

  Future<bool> smsOTPDialog(BuildContext context) {
    return showDialog (
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text ('Enter Code'),
            content: Container (
              padding: EdgeInsets.only (bottom: 32),
              height: 85,
              child: Column (children: [
                TextField (
                  onChanged: (value) {
                    this.smsOTP = value;
                  },
                ),
                (
                    errorMessage != '' ? Text (errorMessage, style: TextStyle (color: Colors.red),) : Container ())
              ]),
            ),
            contentPadding: EdgeInsets.all (10),
            actions: <Widget>[
              FlatButton (
                child: Text ('OK'),
                onPressed: () {
                  _auth.currentUser ().then ((user) {
                    if (user != null)
                    {
                      Navigator.of (context).pop ();
                      Navigator.of(context).pushReplacementNamed('/profilePage');
                    } else {
                      signIn ();
                    }
                  });
                },
              )
            ],
          );
        });
  }

  signIn() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential (
        verificationId: verificationId,
        smsCode: smsOTP,
      );
      final FirebaseUser user = (await _auth.signInWithCredential (credential)).user;
      final FirebaseUser currentUser = await _auth.currentUser ();
      assert(user.uid == currentUser.uid);
      Navigator.of (context).pop ();
      Navigator.of (context).pushReplacementNamed ('/profilePage');
    } catch (e) {
      handleError (e);
    }
  }

  handleError(PlatformException error) {
    print (error);
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        FocusScope.of (context).requestFocus (new FocusNode());
        setState (() {
          errorMessage = 'INVALID CODE';
        });
        Navigator.of (context).pop ();
        smsOTPDialog (context).then ((value) {
          print ('sign in');
        });
        break;
      default:
        setState (() {
          errorMessage = error.message;
        });

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: Column (
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/2.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF42f5d7),Color(0xff42f5d7)],
                ),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90.0)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top:40),
                      child: CircleAvatar(
                        radius: 75,
                        backgroundImage:AssetImage("images/logo_clinic.png"),
                        backgroundColor:Colors.transparent,
                      ),
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10,right: 16,left: 20,bottom: 20),
                      child: Text("enter Your Phone Number",style: TextStyle(
                          color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.5
                      ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    margin: EdgeInsets.only(bottom:8.0),
                    padding: EdgeInsets.only(top: 4,right: 10,bottom: 2,left:10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(45)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                        ),
                      ],

                    ),
                    child: TextField(
                        decoration: InputDecoration(
                          hintText: "+9647504221219",
                          border: InputBorder.none,
                        ),
                        autofocus: true,
                        onChanged: (value){
                         this.phoneNo=value;
                        }
                    ),
                  )
                ],
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top: 32,bottom:192),
                child:Center(
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius:  BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.black)
                    ),
                    color: Color(0xff42f5d7),
                    splashColor: Colors.pink,
                    child: Text("Request Code",style:
                    TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.5),),
                    onPressed:verifyPhone,

                  ),

                ),
              ),

            ),

          ],
        ),
      ),

    );
  }
}