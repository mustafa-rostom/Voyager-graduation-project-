import 'package:flutter/material.dart';

class Background extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Container(
      /* width: 414.0,
            height: 312.0,*/
      height: MediaQuery.of(context).size.height*0.3999,
      width: MediaQuery.of(context).size.width*1.0,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            // border: Border.all(width: 2.0)
          ),
          height: 108.0,
          width: 346.0,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Make a ",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 40.0,
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    "TRIP ",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 40.0,
                        color: Color(0xFF3FCC59),
                        fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              SizedBox(
                height: 2.0,
              ),
              Text(
                "Bibendum etiam ut sit quam ultrices elementum, morbi.Bibendum etiam",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12.0,
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.w100
                ),
                textAlign: TextAlign.center,)
            ],
          ),
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50.0),bottomRight: Radius.circular(50.0)),
          image: DecorationImage(
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(Color(0xFF000000).withOpacity(0.4), BlendMode.darken),
              image: AssetImage("assets/image/Background.png",)
          )
      ),

    );
  }

}