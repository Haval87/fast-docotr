import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Img;
import 'package:async/async.dart';
import 'dart:async';



void main(){
  runApp(MaterialApp(
    home: ProfilePage(),
  ));
}
class ProfilePage extends StatefulWidget {

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File _image;
  int selectedRadio;
  final phoneNumberController=TextEditingController();
  final emailController=TextEditingController();
  final weightController=TextEditingController();
  final heightController=TextEditingController();
  final firstNameController=TextEditingController();
  final secondNameController=TextEditingController();
  final ageController=TextEditingController();
  final addressController=TextEditingController();
  bool visible=false;


  Future callApi(File image)async
  {
    setState(() {
      visible=true;
    });
    String firstName=firstNameController.text;
    String secondName=secondNameController.text;
    String age=ageController.text;
    int gender=selectedRadio;
    String height=heightController.text;
    String weight=weightController.text;
    String phoneNumber=phoneNumberController.text;
    String address=addressController.text;
    String email=emailController.text;
    var steam=http.ByteStream(DelegatingStream.typed(image.openRead()));
    var length=await image.length();
    var uri=Uri.parse('http://trimaestro.tech/haval/upload.php/');
    var request=http.MultipartRequest("POST",uri);
    var data = request.fields[{'firstname': firstName,'secondname':secondName,'age':age,'gender':gender,'height':height,
      'weight':weight,'phonenumber':phoneNumber,'address':address,'email':email}];

    var multipartFile=http.MultipartFile("image",steam,length,filename:(image.path));
    request.files.add(multipartFile);
    var response = await http.post(uri, body: json.encode(data));
    var message = jsonDecode(response.body);

    if(response.statusCode == 200){
      setState(() {
        visible = false;
      });
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(message),
          actions: <Widget>[
            FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );

  }
  @override
  void initState() {
    super.initState ();
    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState (() {
      selectedRadio = val;
    });
  }

  Future getImage(ImageSource src) async {
    var image = await ImagePicker.pickImage (source: src);
    final tempDir=await getTemporaryDirectory();
    final path=tempDir.path;
    String firstName=firstNameController.text;
    Img.Image image2=Img.decodeImage(image.readAsBytesSync());
    Img.Image smallerImage=Img.copyResize(image2, width: 500);
    var compressImg=File("$path/image_$firstName.jpg")
      ..writeAsBytesSync(Img.encodeJpg(smallerImage,quality: 85));
    setState (() {
      _image = compressImg;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar (
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text ("Profile", style: TextStyle (
            color: Colors.greenAccent,
            fontWeight: FontWeight.bold,
            fontSize: 20
        ),),
      ),
      body: Center (
        child: Container (
          padding: EdgeInsets.only (top: 10),
          child: Column (

            children: <Widget>[
              _image == null ? CircleAvatar (radius: 75,
                backgroundImage: null,
                child: Align (
                  alignment: Alignment.topLeft,
                  heightFactor: 0.5,
                  child: FloatingActionButton (

                    onPressed: () {
                      showDialog (
                        context: context,
                        builder: (BuildContext context) {
                          return
                            Container (
                              padding: EdgeInsets.only (top: 10),
                              width: MediaQuery.of (context).size.width,
                              height: MediaQuery.of (context).size.height,
                              child: SimpleDialog (
                                title: Text ("Pick an Image"),
                                children: <Widget>[
                                  SimpleDialogOption (
                                    onPressed: () async {
                                      Navigator.pop (context);
                                      getImage (ImageSource.gallery);
                                    },
                                    child: Text (
                                        "Pick an image from Gallery"),
                                  ),
                                  SimpleDialogOption (
                                    onPressed: () async {
                                      Navigator.pop (context);
                                      getImage (ImageSource.camera);
                                    },
                                    child: Text ("Take Picture"),
                                  ),

                                ],

                              ),

                            );
                        },
                      );
                    },
                    tooltip: 'Pick Image',
                    child: new Icon(Icons.add_a_photo),

                  ),
                ),
              ) : CircleAvatar (

                backgroundImage: FileImage (_image),
                radius: 75,
                child: Align (
                  alignment: Alignment.topLeft,
                  heightFactor: 0.5,
                  child: FloatingActionButton (
                    onPressed: () {
                      showDialog (
                        context: context,
                        builder: (BuildContext context) {
                          return Container (
                            width: MediaQuery.of (context).size.width,
                            height: MediaQuery.of (context).size.height / 1.2,
                            child: SimpleDialog (
                              contentPadding: EdgeInsets.all (20),
                              title: Text ("Pick an Image"),
                              children: <Widget>[
                                SimpleDialogOption (
                                  onPressed: () async {
                                    Navigator.pop (context);
                                    getImage (ImageSource.gallery);
                                  },
                                  child: Text (
                                      "Pick an image from Gallery"),
                                ),
                                SimpleDialogOption (
                                  onPressed: () async {
                                    Navigator.pop (context);
                                    getImage (ImageSource.camera);
                                  },
                                  child: Text ("Take Picture"),
                                ),

                              ],

                            ),

                          );
                        },
                      );
                    },
                    tooltip: 'Pick Image',
                    child: new Icon(Icons.add_a_photo),

                  ),
                ),
              ),
              Container (
                width: MediaQuery.of (context).size.width / 1.5,
                height: 50,
                margin: EdgeInsets.only(bottom:8.0),
                padding: EdgeInsets.only(top: 4,right: 10,bottom: 2,left:10),
                decoration: BoxDecoration (
                    borderRadius: BorderRadius.all (Radius.circular (45)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow (
                        color: Colors.black,
                        blurRadius: 10,
                      ),
                    ]
                ),
                child: TextField(
                  controller: phoneNumberController,
                  decoration: InputDecoration (
                    border: InputBorder.none,
                    hintText: '+9647504221219',
                    prefixIcon: Icon (
                        Icons.person, color: Colors.pink),
                  ),

                ),
              ),
              Divider (
                height: 5.5,
                color: Colors.teal,
                thickness: 1.5,
              ),
              Expanded (
                child: Center (
                    child: ListView (
                        children: <Widget>[
                          Container (
                            width: MediaQuery.of (context).size.width / 2,
                            height: 50,
                            margin: EdgeInsets.only(bottom:8.0),
                            padding: EdgeInsets.only(top: 4,right: 10,bottom: 2,left:10),
                            decoration: BoxDecoration (
                                border: Border.all (color: Colors.teal),
                                borderRadius: BorderRadius.circular (20.0)),
                            child: TextField (
                              controller: firstNameController,
                              decoration: InputDecoration (
                                border: InputBorder.none,
                                hintText: "First Name",
                                prefixIcon: Icon (
                                  Icons.person, color: Colors.pink,),
                              ),
                            ),
                          ),
                          SizedBox (
                            height: 10.0,
                          ),
                          Container (
                            width: MediaQuery.of (context).size.width / 2,
                            height: 50,
                            margin: EdgeInsets.only(bottom:8.0),
                            padding: EdgeInsets.only(top: 4,right: 10,bottom: 2,left:10),
                            decoration: BoxDecoration (
                                border: Border.all (color: Colors.teal),
                                borderRadius: BorderRadius.circular (45.0)),
                            child: TextField (
                              showCursor: true,
                              cursorColor: Colors.red,
                              controller: secondNameController,
                              decoration: InputDecoration (
                                prefixIcon: Icon (
                                  Icons.person, color: Colors.pink,),
                                border: InputBorder.none,
                                hintText: "Second Name",),

                            ),
                          ),

                          SizedBox (
                            height: 10.0,
                          ),
                          Container (
                            width: MediaQuery.of (context).size.width,
                            height: 104,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all (10.0),
                            decoration: BoxDecoration (
                                border: Border.all (color: Colors.teal),
                                borderRadius: BorderRadius.circular (45.0)),
                            child: Column (
                              children: <Widget>[
                                Text ("Gender", style: TextStyle (
                                  color: Colors.pink, fontSize: 20, fontWeight: FontWeight.bold,
                                ),),
                                Row (
                                  children: <Widget>[
                                    Expanded (
                                      child: ListTile (
                                        leading: Radio (
                                          value: 1,
                                          groupValue: selectedRadio,
                                          activeColor: Colors.teal,
                                          onChanged: (val) {
                                            setSelectedRadio (val);
                                          },
                                        ),
                                        title: Text ("Male", style: TextStyle (
                                            color: Colors.pink,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12
                                        ),),
                                      ),
                                    ),
                                    Expanded (
                                      child: ListTile (
                                        leading: Radio (
                                          value: 2,
                                          groupValue: selectedRadio,
                                          activeColor: Colors.teal,
                                          onChanged: (val) {
                                            setSelectedRadio (val);
                                          },
                                        ),
                                        title: Text (
                                          "Female", style: TextStyle (
                                            color: Colors.pink,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12
                                        ),),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),

                          SizedBox (
                            height: 10.0,
                          ),
                          Row (
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: <Widget>[
                              Expanded (
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  width: MediaQuery.of(context).size.width/2,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(45)),
                                      border: Border.all(color: Colors.teal)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Icon(Icons.person_outline, color: Colors.pink),
                                      Text("weight:",style: TextStyle(color: Colors.pink)),
                                      Expanded(
                                        child:  TextField(
                                          controller: weightController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration.collapsed(
                                            hintText:"0.0",
                                          ),
                                          onChanged: null,
                                        ),

                                      )
                                    ],
                                  ),
                                ),

                              ),
                              Expanded (
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  width: MediaQuery.of(context).size.width/2,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(45)),
                                      border: Border.all(color: Colors.teal)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Icon(Icons.person_outline,color: Colors.pink,),
                                      Text("Height:"),
                                      Expanded(
                                        child:  TextField(
                                          controller:heightController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration.collapsed(
                                            hintText: "0.0",
                                          ),
                                          onChanged: null,
                                        ),

                                      )

                                    ],

                                  ),
                                ),

                              )
                            ],
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          Container(

                            width: MediaQuery.of(context).size.width/1.55,
                            height: 50,
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
                              border: Border.all(color: Colors.teal),

                            ),
                            child: TextField(
                              controller: ageController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.plus_one,color: Colors.pink,),
                                  hintText: "Age",
                                  border: InputBorder.none
                              ),
                              onChanged: null,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(

                            width: MediaQuery.of(context).size.width/1.55,
                            height: 50,
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
                              border: Border.all(color: Colors.teal),

                            ),
                            child: TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email,color: Colors.pink,),
                                hintText: "Email  Address",
                                border: InputBorder.none,
                              ),
                              onChanged: null,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(

                            width: MediaQuery.of(context).size.width/1.55,
                            height: 50,
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
                              border: Border.all(color: Colors.teal),

                            ),
                            child: TextField(
                              controller: addressController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.place,color: Colors.pink,),
                                hintText: "Address",
                                border: InputBorder.none,
                              ),
                              onChanged: null,
                            ),
                          ),
                          Material (
                            borderRadius: BorderRadius.circular (20.0),
                            elevation: 10.0,
                            color: Colors.green,
                            child: MaterialButton (
                              onPressed: ()
                              {
                                callApi(_image);
                              },
                              child: Text ("Save", style: TextStyle (color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold
                              ),),
                            ),
                          ),
                          SizedBox (
                            height: 10.0,
                          ),
                        ]
                    )
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }

}
