import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class MyClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Category(),
    );
  }
}

class Category extends StatefulWidget {
  Category({Key key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  String _currentCategory;

  List _categories=[
    "Cardiology","Allergy and Immunology","Internal Medicine","Dermatology","Family Medcine","Hematology","Nephrology","Neurology",

    "Erthopedics"
  ];
  List<DropdownMenuItem<String>> _dropDownMenuItems;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentCategory = _dropDownMenuItems[0].value;
    super.initState();
  }
  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items =  List();
    for (String category in _categories) {
      items.add( DropdownMenuItem(
          value: category,
          child: Text(category)
      ));
    }
    return items;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      color: Colors.greenAccent,
      child:  Center(
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Text("Please Choose yor Category: "),
              new Container(
                padding:  EdgeInsets.only(top: 5),
              ),
              new DropdownButton(
                value: _currentCategory,
                items: _dropDownMenuItems,
                onChanged: changedDropDownItem,
              )
            ],
          )
      ),
    );
  }
  void changedDropDownItem(String selectedCategory) {
    setState(() {
      _currentCategory=selectedCategory;
      if(_currentCategory!=null)
      {
        showDialog(context: context,
            builder: (BuildContext context)
            {
              return AlertDialog(
                title: Text("Please choose date and Time"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Day"),
                    onPressed: ()
                    {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                  )

                ],

              );
            }
        );
      }
      else
      {

      }


    });
  }

}


