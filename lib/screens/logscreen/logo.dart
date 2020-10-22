import 'package:flutter/widgets.dart';

class Logo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            // decoration:BoxDecoration(
            // border: Border.all(width: 5)
            // ),
            height: 55,
            width: 258,
            child: Image.asset("assets/image/logo.png",
                fit: BoxFit.cover),
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width*0.693,
            height: 43.0,
            decoration:BoxDecoration(
              //  border: Border.all(width: 5)
            ),
            margin: EdgeInsets.only(left: 2.0,right: 2.0,top: 0.5,bottom: 0.5),
            child: Text("Login now to start travelling wherever you want  " ,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,

                  color: Color(0xFF2B2B2B)
              ),

              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

}