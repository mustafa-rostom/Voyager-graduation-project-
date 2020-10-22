import 'package:flutter/cupertino.dart';

class Background extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50.0),
              bottomRight: Radius.circular(50.0))),
      height: MediaQuery.of(context).size.height * 0.38,
      width: double.infinity,
      //MediaQuery.of(context).size.width*1.0,
      child: Image.asset(
        'assets/image/Cover.png',
        fit: BoxFit.cover,
      ),
    );
  }

}