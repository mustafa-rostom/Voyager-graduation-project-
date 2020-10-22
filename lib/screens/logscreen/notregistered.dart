import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voyager/screens/signup.dart';

class NotRegistered extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Container(
        width: 290.0,
        height: 33.0,
        padding: EdgeInsets.only(left: 20.0),
        child: Row(
          children: <Widget>[
            Container(
              child: Text("Don't have an account?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Poppins',
                    color: Color(0xFF4F4F4F),
                    fontWeight: FontWeight.w400

                ),),
            ),

            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent, // makes highlight invisible too
              onTap: (){
                TextStyle(decoration: TextDecoration.underline);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context)=>Signup(),
                  ),
                );
              },
              child: Text("Sign Up",
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF3FCC59) ,


                ),
              ),
            )

          ],
        ),
      ),
    );
  }

}