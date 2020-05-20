import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'details.dart';

class HomePage extends StatefulWidget {
  HomePage():super();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List> getData() async {
    final response = await http.get('http://trimaestro.tech/read.php');
    return json.decode(response.body);
  }
  int _btmNavIndex=0;
  void btmNavIndex(index)
  {
    setState(() {
      _btmNavIndex=index;
    });
  }

  CarouselSlider carouselSlider;

  List imgList = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSUojDCOBE-R1yjOGcLKodxPWzT6g_OuEL4CUzLV94m4ZmBerDw',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQa5BJVcHccpngaPX9MVuv2CWCo8VzErRYSc_ROntW6TiWwiVQw',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRxHgMYk1LXCbzSFp3gB-GfEnV1aXzcR_2mq8GnvxZb-Z6IwufG',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS70AJjlm2VmiI7VpdluSe8jSf2OnNsiUdSJFprP7jlROE-ZHJr',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSSgFtKUjpkaIJ9umm1seKud2eWjsjHLmhzu9SU8KJ6AJNybtX7'
  ];
  int _current=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
       currentIndex: _btmNavIndex,
        type: BottomNavigationBarType.fixed,
        items:<BottomNavigationBarItem> [
          BottomNavigationBarItem(
              icon: Icon(Icons.home,color: Colors.teal),
              title: Text("Home",style: TextStyle(color: Colors.teal,fontSize: 8),)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today,color: Colors.teal),
            title: Text("My Appointments",style: TextStyle(color: Colors.teal,fontSize: 8),),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite,color: Colors.teal),
            title: Text("My Favourite",style: TextStyle(color: Colors.teal,fontSize: 8),),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings,color: Colors.teal),
            title: Text("Settings",style: TextStyle(color: Colors.teal,fontSize: 8),),
          ),
        ],
        onTap: (index){
         btmNavIndex(index);
         Navigator.pushReplacementNamed(context, '/myappointment');
        },
      ),
      backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        body:ListView(
          children: <Widget>[
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  carouselSlider = CarouselSlider(
                    height: 200.0,
                    initialPage: 0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    reverse: false,
                    enableInfiniteScroll: true,
                    autoPlayInterval: Duration(seconds: 2),
                    autoPlayAnimationDuration: Duration(milliseconds: 2000),
                    pauseAutoPlayOnTouch: Duration(seconds: 10),
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index) {
                      setState(() {
                       index=_current;
                      });
                    },
                    items: imgList.map((imgUrl) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              color: Colors.green,
                            ),
                            child: Image.network(
                              imgUrl,
                              fit: BoxFit.fill,
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Divider(
                    color: Colors.blue,
                  ),
                  Container(
                      padding: EdgeInsets.only(bottom: 82.0),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height/1.5,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFFffFFFF),Color(0xffffffff)],
                        ),
                        borderRadius: BorderRadius.only(bottomLeft:
                        Radius.circular(20.0),topLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),topRight: Radius.circular(20.0),
                        ),
                      ),
                      child:FutureBuilder<List>(
                        future: getData(),
                        builder: (context,snapshot){
                          if(snapshot.hasError) print(snapshot.error);
                          return snapshot.hasData? ItemList(
                            list:snapshot.data,
                          ):Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      )


                  )
                ],
              ),
            ),
          ],
        ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;

  ItemList({this.list});

  @override
  Widget build(BuildContext context) {

    return ListView.builder (

        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, index) {
          return ListTile (
              title:CircleAvatar(

                radius: 40,
                backgroundImage: NetworkImage("https://trimaestro.tech/"+"${list[index]['imglink']}")

              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(list[index]['full_name'],style: TextStyle(color:Colors.pink,fontSize: 20,fontWeight: FontWeight.bold),),
                  Text("${list[index]['specialist']}",style: TextStyle(color: Colors.pink,fontSize: 16),),
                  Text("${list[index]['phone']}"),
                  Text("${list[index]['city']}"),
                  Text("${list[index]['experience1']}"),

                ],
              ),
          onTap: () =>
          Navigator.of (context).push (
          MaterialPageRoute (
          builder: (BuildContext context) =>
          Detail (list: list, index: index,)
          )
            ),

          );
        }
          );
        }
}
