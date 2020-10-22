import 'package:flutter/cupertino.dart';

class Hello extends StatelessWidget{
 final String userName;
  Hello(
      this.userName
      );
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.only(left: 20),
      child: Row(
        children: <Widget>[
          Text(
            'Hello, ',
            style: TextStyle(
                fontSize: 35.0,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w300),
          ),
          Text(
           "$userName" ,
            style: TextStyle(
                fontSize: 35.0,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

}