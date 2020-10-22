import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class TopVoyager extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width*0.86,
      height: MediaQuery.of(context).size.height*0.19,
      margin: EdgeInsets.only(left: 25.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width*0.265,
            height: MediaQuery.of(context).size.height*0.15,
            decoration: BoxDecoration(
              // color: Color(0xFFE5E5E5),
            ),
            child: Card(
              elevation: 0,
              // color: Colors.red,
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width*0.25,
                    height: MediaQuery.of(context).size.height*0.092,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0)),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            //       colorFilter: ColorFilter.mode(Color(0xFF000000).withOpacity(0.4), BlendMode.darken),
                            image: AssetImage("assets/image/Background.png",)
                        )
                    ),

                  ),
                  SizedBox(
                    height: 5,
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width*0.25,
                    height: MediaQuery.of(context).size.height*0.060,
                    child: Column(
                      children: <Widget>[
                        Text(
                          'mustafa rostom',
                          style: TextStyle(
                              fontSize: 10.0, fontFamily: 'Poppins',fontWeight: FontWeight.w400),
                        ),
                        Text(
                          '12 trip/month   ',
                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF3FCC59),
                              fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox
            (width:10.0)
          ,
          Container(
            width: MediaQuery.of(context).size.width*0.265,
            height: MediaQuery.of(context).size.height*0.15,
            decoration: BoxDecoration(
              // color: Color(0xFFE5E5E5),
            ),
            child: Card(
              elevation: 0,
              // color: Colors.red,
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width*0.25,
                    height: MediaQuery.of(context).size.height*0.092,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0)),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            //       colorFilter: ColorFilter.mode(Color(0xFF000000).withOpacity(0.4), BlendMode.darken),
                            image: AssetImage("assets/image/Background.png",)
                        )
                    ),

                  ),
                  SizedBox(
                    height: 5,
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width*0.25,
                    height: MediaQuery.of(context).size.height*0.060,
                    child: Column(
                      children: <Widget>[
                        Text(
                          'mustafa rostom',
                          style: TextStyle(
                              fontSize: 10.0, fontFamily: 'Poppins',fontWeight: FontWeight.w400),
                        ),
                        Text(
                          '12 trip/month   ',
                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF3FCC59),
                              fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox
            (width:10.0)
          ,
          Container(
            width: MediaQuery.of(context).size.width*0.265,
            height: MediaQuery.of(context).size.height*0.15,
            decoration: BoxDecoration(
              // color: Color(0xFFE5E5E5),
            ),
            child: Card(
              elevation: 0,
              // color: Colors.red,
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width*0.25,
                    height: MediaQuery.of(context).size.height*0.092,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0)),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            //       colorFilter: ColorFilter.mode(Color(0xFF000000).withOpacity(0.4), BlendMode.darken),
                            image: AssetImage("assets/image/Background.png",)
                        )
                    ),

                  ),
                  SizedBox(
                    height: 5,
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width*0.25,
                    height: MediaQuery.of(context).size.height*0.060,
                    child: Column(
                      children: <Widget>[
                        Text(
                          'mustafa rostom',
                          style: TextStyle(
                              fontSize: 10.0, fontFamily: 'Poppins',fontWeight: FontWeight.w400),
                        ),
                        Text(
                          '12 trip/month   ',
                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF3FCC59),
                              fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}