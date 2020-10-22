import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/logscreen/loginput.dart';
import 'logscreen/logo.dart';
import 'logscreen/notregistered.dart';

class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _StateLogin();
  }

}
class _StateLogin extends State<Login>{


  @override
  Widget build(BuildContext context) {
    print('here is wedgit of login');

    return Scaffold(
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height*0.15,
          ),

          Logo(),

          SizedBox(
            height: MediaQuery.of(context).size.height* 0.08,
          ),

          LogInput(),

          SizedBox(
            height: MediaQuery.of(context).size.height*0.14,
          )
          ,
          NotRegistered()
        ],),
    );
  }}
