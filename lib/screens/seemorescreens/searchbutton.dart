import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../seemorescreens/searchtrips.dart';
class SearchBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
//      width: MediaQuery.of(context).size.width*0.9,
//      height: MediaQuery.of(context).size.height*0.1,
      child: Row(children: <Widget>[
        Material(
          child: Container(
            padding: EdgeInsets.only(top: 6),

            child: Center(
              child: IconButton(
                iconSize: 30.0,
                icon: Icon(Icons.arrow_back,color: Colors.black87),
                //   color: Color(0xFF3FCC59),

                onPressed: () {
                  Navigator.pop(context);
                },
//                splashColor: Colors.transparent,
//                highlightColor: Colors
//                    .transparent, // makes highlight invisible too
              ),
            ),
          ),
        ),
        SizedBox(width: 10.0,),
        Container(
          width: MediaQuery.of(context).size.width*0.25,
          height: MediaQuery.of(context).size.height*0.1,
          child: Center(
            child: Text(
              "All Trips",
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                  color: Color(0xFF3FCC59)
              ),
              textAlign: TextAlign.center,
            ),
          ),

        ),
    SizedBox(
      width: MediaQuery.of(context).size.width*0.4,
    )
    ,Material(
          child: Container(
            padding: EdgeInsets.only(top: 6),

            child: Center(
              child: IconButton(
                iconSize: 30.0,
                icon: Icon(Icons.search,color: Colors.black87),
                //   color: Color(0xFF3FCC59),

                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context)=>SearchTrips(),
                    ),
                  );                },
//                splashColor: Colors.transparent,
//                highlightColor: Colors
//                    .transparent, // makes highlight invisible too
              ),
            ),
          ),
        ),

      ],
      ),
    );
  }

}