import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/seemorescreens/alltrips.dart';
import '../screens/seemorescreens/searchbutton.dart';


class SeeMoreTrips extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _StateSeeMore();
  }


}
class _StateSeeMore extends State<SeeMoreTrips>{
  @override
  Widget build(BuildContext context) {
    print("we are in see more func");

    return  Scaffold(
      body : ListView(
        children: <Widget>[
          SearchBar(),
          AllTrips(),
        ],
      )
    );
  }

}