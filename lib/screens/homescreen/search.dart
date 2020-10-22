import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../seemorescreens/searchtrips.dart';

class Search extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(left: 25, right: 25),
      height: 52.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26.0),
    border: Border.all(color: Color(0xFFE9EFF1))
//                          color: Color(0xFFF4F8FF)
    ),
      child:
      Material(
        color: Color(0xFFE9EFF1),
        borderRadius: BorderRadius.circular(26.0),
        child: MaterialButton(

            onPressed: () {Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context)=>SearchTrips(),
                ));},
            child: Row(
              children: <Widget>[
                Icon(Icons.search, color: Color(0xFFAAADAD),size: 25.0,),
                SizedBox(width: 20.0,),
                Text("search trips",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xFF839195),
                    fontSize: 15,
                    fontWeight: FontWeight.w500),

                ),

              ],
            )

          //   style: Theme.of(context).textTheme.button,
        ),
//        TextFormField(
//          style: TextStyle(
//            fontFamily: 'Poppins',
//            fontSize: 15.0,
//            // color: Color.fromRGBO(170, 173, 173, 100)
//          ),
//          decoration: InputDecoration(
//            filled: true,
//            prefixIcon: Icon(Icons.search),
//            labelText: 'search trips',
//            //hintText: 'search for a trip ',
//            labelStyle: TextStyle(
//                fontFamily: 'Poppins',
//                color: Color(0xFF839195),
//                fontSize: 15,
//                fontWeight: FontWeight.w500),
//            contentPadding:
//            EdgeInsets.only(left: 20.0, top: 17.5, bottom: 17.5),
//            border: OutlineInputBorder(
//              borderRadius: BorderRadius.circular(25.0),
//            ),
//            enabledBorder: OutlineInputBorder(
//                borderSide: BorderSide(color: Color(0xFFD7D7D7)),
//                borderRadius: BorderRadius.all(Radius.circular(25.0))
//            ),
//          ),
//        ),
      ),
    );
  }

}